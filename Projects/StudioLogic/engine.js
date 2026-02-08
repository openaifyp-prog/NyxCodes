import { ParticleSystem } from './utils/particles.js';

/**
 * @fileoverview Unified rendering engine for Cyberpunk Nexus 2.0.
 * Optimized with Layered Rendering (Cache Layer) for 60FPS fluid performance.
 */

export const RENDER_MODE = {
    LINEAR: 'LINEAR',
    GRID: 'GRID'
};

export class UnifiedRenderer {
    /**
     * @param {HTMLCanvasElement|OffscreenCanvas} canvas 
     * @param {number} pixelRatio 
     */
    constructor(canvas, pixelRatio = 1) {
        this.canvas = canvas;
        this.ctx = canvas.getContext('2d');
        this.pixelRatio = pixelRatio;
        this.mode = RENDER_MODE.LINEAR;

        // Internal State
        this.data = [];
        this.activeIndices = new Set();
        this.comparingIndices = new Set();
        this.path = [];
        this.visited = new Set();

        // Effects
        this.particles = new ParticleSystem();
        this.isGlitching = false;
        this.glitchTimer = 0;

        // Cache Layer (for static grid)
        this.cacheCanvas = typeof OffscreenCanvas !== 'undefined'
            ? new OffscreenCanvas(1, 1)
            : document.createElement('canvas');
        this.cacheCtx = this.cacheCanvas.getContext('2d');
        this.cacheValid = false;

        this.colors = {
            background: '#050505',
            neonCyan: '#00f3ff',
            electricPurple: '#bc00ff',
            glowCyan: 'rgba(0, 243, 255, 0.5)',
            glowPurple: 'rgba(188, 0, 255, 0.5)',
            comparing: '#ffffff',
            wall: '#111111',
            visited: 'rgba(188, 0, 255, 0.3)',
            path: '#00f3ff',
            gridLines: 'rgba(0, 243, 255, 0.05)'
        };

        this.animationId = null;
    }

    setMode(mode) {
        this.mode = mode;
        this.particles.particles = [];
        this.cacheValid = false;
        this.render();
    }

    handleResize(width, height) {
        this.canvas.width = width * this.pixelRatio;
        this.canvas.height = height * this.pixelRatio;
        this.ctx.scale(this.pixelRatio, this.pixelRatio);

        // Update cache canvas size
        this.cacheCanvas.width = this.canvas.width;
        this.cacheCanvas.height = this.canvas.height;
        this.cacheCtx.scale(this.pixelRatio, this.pixelRatio);

        this.cacheValid = false;
        this.render();
    }

    setData(data) {
        this.data = data;
        this.cacheValid = false;
    }

    setHighlights(active = new Set(), comparing = new Set()) {
        this.activeIndices = active;
        this.comparingIndices = comparing;
    }

    setGridState(visited = new Set(), path = []) {
        this.visited = visited;
        this.path = path;
    }

    triggerGlitch() {
        this.isGlitching = true;
        this.glitchTimer = 10;
    }

    start() {
        const loop = () => {
            this.render();
            this.animationId = requestAnimationFrame(loop);
        };
        this.animationId = requestAnimationFrame(loop);
    }

    stop() {
        if (this.animationId) {
            cancelAnimationFrame(this.animationId);
            this.animationId = null;
        }
    }

    /**
     * Caches static grid lines once.
     */
    updateGridCache(width, height) {
        if (!this.data || !this.data.grid) return;
        const { cols, rows } = this.data;
        const cellW = width / cols;
        const cellH = height / rows;

        this.cacheCtx.clearRect(0, 0, width, height);
        this.cacheCtx.strokeStyle = this.colors.gridLines;
        this.cacheCtx.lineWidth = 1;

        this.cacheCtx.beginPath();
        for (let i = 0; i <= cols; i++) {
            this.cacheCtx.moveTo(i * cellW, 0);
            this.cacheCtx.lineTo(i * cellW, height);
        }
        for (let j = 0; j <= rows; j++) {
            this.cacheCtx.moveTo(0, j * cellH);
            this.cacheCtx.lineTo(width, j * cellH);
        }
        this.cacheCtx.stroke();
        this.cacheValid = true;
    }

    render() {
        const width = this.canvas.width / this.pixelRatio;
        const height = this.canvas.height / this.pixelRatio;
        const ctx = this.ctx;

        ctx.fillStyle = this.colors.background;
        ctx.fillRect(0, 0, width, height);

        if (this.mode === RENDER_MODE.GRID) {
            if (!this.cacheValid) this.updateGridCache(width, height);
            ctx.drawImage(this.cacheCanvas, 0, 0, width, height);
        }

        if (this.isGlitching && this.glitchTimer > 0) {
            ctx.save();
            ctx.translate((Math.random() - 0.5) * 5, 0);
            this.glitchTimer--;
            if (this.glitchTimer === 0) this.isGlitching = false;
        }

        if (this.mode === RENDER_MODE.LINEAR) {
            this.renderLinear(ctx, width, height);
        } else {
            this.renderGrid(ctx, width, height);
        }

        this.particles.update(ctx);

        if (this.isGlitching) {
            ctx.restore();
        }
    }

    renderLinear(ctx, width, height) {
        if (!Array.isArray(this.data) || this.data.length === 0) return;

        const barWidth = width / this.data.length;
        const maxValue = Math.max(...this.data, 1);

        this.data.forEach((val, i) => {
            const barHeight = (val / maxValue) * (height * 0.8);
            const x = i * barWidth;
            const y = height - barHeight;

            let color = this.colors.neonCyan;
            let glowColor = this.colors.glowCyan;

            if (this.activeIndices.has(i)) {
                color = this.colors.electricPurple;
                glowColor = this.colors.glowPurple;
                this.particles.emit(x + barWidth / 2, y, 2);
            } else if (this.comparingIndices.has(i)) {
                color = this.colors.comparing;
                glowColor = 'rgba(255, 255, 255, 0.3)';
            }

            ctx.shadowBlur = 15;
            ctx.shadowColor = glowColor;
            ctx.fillStyle = color;
            ctx.fillRect(x + 1, y, barWidth - 2, barHeight);

            ctx.shadowBlur = 0;
            ctx.fillStyle = 'rgba(255, 255, 255, 0.2)';
            ctx.fillRect(x + 1, y, (barWidth - 2) / 4, barHeight);
        });
    }

    renderGrid(ctx, width, height) {
        if (!this.data || !this.data.grid) return;

        const { grid, cols, rows, start, end } = this.data;

        // Mobile Adaptive Padding (Safe Zone)
        const isMobile = width < 768;
        const padding = isMobile ? 24 : 0;
        const availableW = width - (padding * 2);
        const availableH = height - (padding * 2);

        const cellW = availableW / cols;
        const cellH = availableH / rows;

        ctx.save();
        ctx.translate(padding, padding);

        for (let r = 0; r < rows; r++) {
            for (let c = 0; c < cols; c++) {
                const cell = grid[r][c];
                const x = c * cellW;
                const y = r * cellH;

                if (cell === 'wall') {
                    ctx.fillStyle = this.colors.wall;
                    ctx.fillRect(x + 1, y + 1, cellW - 2, cellH - 2);
                } else if (this.visited.has(`${r},${c}`)) {
                    ctx.fillStyle = this.colors.visited;
                    ctx.fillRect(x + 1, y + 1, cellW - 2, cellH - 2);
                }
            }
        }

        // Render Start (A) and End (B) Markers
        const drawMarker = (posStr, label, color) => {
            if (!posStr) return;
            const [r, c] = posStr.split(',').map(Number);
            const x = c * cellW + cellW / 2;
            const y = r * cellH + cellH / 2;

            ctx.fillStyle = color;
            ctx.beginPath();
            ctx.arc(x, y, Math.min(cellW, cellH) * 0.4, 0, Math.PI * 2);
            ctx.fill();

            ctx.fillStyle = '#ffffff';
            ctx.font = `bold ${Math.min(cellW, cellH) * 0.5}px Inter`;
            ctx.textAlign = 'center';
            ctx.textBaseline = 'middle';
            ctx.fillText(label, x, y);
        };

        drawMarker(start, 'A', '#3b82f6');
        drawMarker(end, 'B', '#10b981');

        if (this.path.length > 0) {
            ctx.beginPath();
            ctx.strokeStyle = this.colors.path;
            ctx.lineWidth = Math.min(cellW, cellH) / 3;
            ctx.shadowBlur = 10;
            ctx.shadowColor = this.colors.path;

            this.path.forEach((pos, i) => {
                const [r, c] = pos.split(',').map(Number);
                const x = c * cellW + cellW / 2;
                const y = r * cellH + cellH / 2;
                if (i === 0) ctx.moveTo(x, y);
                else ctx.lineTo(x, y);
            });
            ctx.stroke();
            ctx.shadowBlur = 0;
        }

        ctx.restore();
    }
}

/**
 * Enhanced Algorithm Engine.
 */
export class AlgorithmEngine {
    constructor(renderer, onStatsUpdate, onLineHighlight) {
        this.renderer = renderer;
        this.onStatsUpdate = onStatsUpdate;
        this.onLineHighlight = onLineHighlight;
        this.array = [];
        this.grid = null;
        this.delay = 50;
        this.isInterrupted = false;
        this.stats = { comparisons: 0, swaps: 0, operations: 0 };
    }

    setArray(array) {
        this.array = [...array];
        this.renderer.setData(this.array);
    }

    setGrid(gridData) {
        this.grid = gridData;
        this.renderer.setData(this.grid);
    }

    setSpeed(ms) { this.delay = ms; }
    abort() { this.isInterrupted = true; }

    async run(algorithmGenerator) {
        this.isInterrupted = false;
        this.stats.operations = 0;

        for await (const state of algorithmGenerator) {
            if (this.isInterrupted) break;

            if (state.line !== undefined) {
                this.onLineHighlight(state.line);
            }

            if (state.type === 'compare') {
                this.stats.comparisons++;
                this.renderer.setHighlights(new Set(), new Set(state.indices));
            } else if (state.type === 'swap') {
                this.stats.swaps++;
                this.renderer.setHighlights(new Set(state.indices), new Set());
                this.renderer.triggerGlitch();
            } else if (state.type === 'grid_update') {
                this.renderer.setGridState(state.visited, state.path);
            }

            this.stats.operations++;
            this.onStatsUpdate(this.stats);
            await new Promise(resolve => setTimeout(resolve, this.delay));
        }

        this.renderer.setHighlights();
        this.onLineHighlight(-1);
    }
}
