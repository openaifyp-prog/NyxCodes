import { Pseudocode } from './utils/pseudocode.js';
import { Theory } from './utils/theory.js';
import { RENDER_MODE } from './engine.js';

document.addEventListener('DOMContentLoaded', () => {
    const canvas = document.getElementById('mainCanvas');
    const complexityCanvas = document.getElementById('complexityCanvas');
    const pseudocodeContainer = document.getElementById('pseudocodeContainer');

    const ui = {
        mode: document.getElementById('modeSelect'),
        algorithm: document.getElementById('algorithmSelect'),
        heuristic: document.getElementById('heuristicSelect'),
        heuristicGroup: document.getElementById('heuristicGroup'),
        density: document.getElementById('arraySize'),
        densityValue: document.getElementById('sizeValue'),
        speed: document.getElementById('speed'),
        speedValue: document.getElementById('speedValue'),
        start: document.getElementById('btnStart'),
        randomize: document.getElementById('btnRandomize'),
        comparisons: document.getElementById('statComparisons'),
        steps: document.getElementById('statSwaps'),
        bigO: document.getElementById('statComplexity'),
        currentMode: document.getElementById('currentMode'),
        theory: document.getElementById('btnTheory'),
        theoryModal: document.getElementById('theoryModal'),
        theoryClose: document.getElementById('btnCloseTheory'),
        theoryTitle: document.getElementById('theoryTitle'),
        theoryContent: document.getElementById('theoryContent'),
        overlay: document.getElementById('modalOverlay')
    };

    const algorithms = {
        LINEAR: [
            { id: 'quickSort', name: 'QuickSort', bigO: 'O(n log n)' },
            { id: 'radixSort', name: 'Radix Sort', bigO: 'O(nk)' },
            { id: 'bubbleSort', name: 'Bubble Sort', bigO: 'O(n²)' }
        ],
        GRID: [
            { id: 'aStar', name: 'A* Pathfinding', bigO: 'O(E log V)' },
            { id: 'dijkstra', name: "Dijkstra's Algo", bigO: 'O(E + V log V)' },
            { id: 'maze_backtracking', name: 'Maze: Backtracking', bigO: 'O(N)' }
        ]
    };

    let worker = new Worker('worker.js', { type: 'module' });
    let complexityCtx = complexityCanvas.getContext('2d');
    let currentMode = RENDER_MODE.LINEAR;
    let gridData = null;
    let lastX = 0;
    let lastY = 0;
    let maxOpsObserved = 100;

    /**
     * Incremental Graph Drawing Logic.
     * Efficiently appends new data points without redrawing the whole history.
     */
    const updateGraph = (ops) => {
        const w = complexityCanvas.width = complexityCanvas.clientWidth;
        const h = complexityCanvas.height = complexityCanvas.clientHeight;

        // Handle max scaling
        if (ops > maxOpsObserved) {
            maxOpsObserved = ops * 1.5;
            // Full redraw needed when scale changes (rare)
            return;
        }

        const step = 2; // Pixels per data point
        const newY = h - (ops / maxOpsObserved) * h;

        // Shift existing graph left
        complexityCtx.globalCompositeOperation = 'copy';
        complexityCtx.drawImage(complexityCanvas, -step, 0);
        complexityCtx.globalCompositeOperation = 'source-over';

        // Draw new segment
        complexityCtx.strokeStyle = '#00f3ff';
        complexityCtx.lineWidth = 1;
        complexityCtx.beginPath();
        complexityCtx.moveTo(w - step - 1, lastY);
        complexityCtx.lineTo(w - 1, newY);
        complexityCtx.stroke();

        lastY = newY;
    };

    /**
     * Pseudocode Display Logic.
     */
    const updatePseudocode = (algoId) => {
        const lines = Pseudocode[algoId] || ["// CODE_STREAM_NOT_AVAILABLE"];
        pseudocodeContainer.innerHTML = lines.map((l, i) =>
            `<div class="code-line" id="line-${i}">${l}</div>`
        ).join('');
    };

    const highlightLine = (lineIdx) => {
        document.querySelectorAll('.code-line').forEach(el => el.classList.remove('active'));
        const activeLine = document.getElementById(`line-${lineIdx}`);
        if (activeLine) activeLine.classList.add('active');
    };

    /**
     * Mode Initialization.
     */
    const initMode = (mode) => {
        currentMode = mode;
        ui.currentMode.textContent = `DOMAIN: ${mode}`;

        // Update Algorithm Select
        ui.algorithm.innerHTML = algorithms[mode].map(a =>
            `<option value="${a.id}">${a.name}</option>`
        ).join('');

        ui.heuristicGroup.classList.toggle('hidden', mode !== 'GRID');
        updatePseudocode(ui.algorithm.value);
        ui.bigO.textContent = algorithms[mode][0].bigO;

        // Reset graph
        complexityCtx.clearRect(0, 0, complexityCanvas.width, complexityCanvas.height);
        lastY = complexityCanvas.height;
    };

    const randomize = () => {
        const density = parseInt(ui.density.value);
        if (currentMode === RENDER_MODE.LINEAR) {
            const array = Array.from({ length: density }, () => Math.floor(Math.random() * 1000) + 1);
            worker.postMessage({ type: 'RANDOMIZE', payload: { array } });
        } else {
            const rows = 21, cols = 31;
            const grid = Array.from({ length: rows }, () => Array(cols).fill('empty'));
            gridData = { grid, rows, cols, start: '0,0', end: `${rows - 1},${cols - 1}` };
            worker.postMessage({ type: 'RANDOMIZE', payload: { array: gridData } });
        }
    };

    /**
     * Worker Communications.
     */
    worker.onmessage = (e) => {
        const { type, stats, line } = e.data;
        if (type === 'STATS_UPDATE') {
            ui.comparisons.textContent = stats.comparisons;
            ui.steps.textContent = stats.swaps;
            updateGraph(stats.operations);
        }
        if (type === 'HIGHLIGHT_LINE') highlightLine(line);
        if (type === 'FINISHED') toggleControls(false);
        if (type === 'READY') randomize();
    };

    const toggleControls = (disabled) => {
        ui.start.disabled = disabled;
        ui.randomize.disabled = disabled;
        ui.mode.disabled = disabled;
        ui.algorithm.disabled = disabled;
    };

    // Events
    ui.mode.addEventListener('change', (e) => {
        worker.postMessage({ type: 'SWITCH_MODE', payload: { mode: e.target.value } });
        initMode(e.target.value);
    });

    ui.algorithm.addEventListener('change', (e) => {
        updatePseudocode(e.target.value);
        const algo = algorithms[currentMode].find(a => a.id === e.target.value);
        ui.bigO.textContent = algo ? algo.bigO : '---';
    });

    ui.density.addEventListener('input', (e) => {
        ui.densityValue.textContent = e.target.value;
        randomize();
    });

    ui.start.addEventListener('click', () => {
        toggleControls(true);
        complexityCtx.clearRect(0, 0, complexityCanvas.width, complexityCanvas.height);
        lastY = complexityCanvas.height;

        const data = currentMode === RENDER_MODE.LINEAR
            ? Array.from({ length: parseInt(ui.density.value) }, () => Math.floor(Math.random() * 1000) + 1)
            : gridData;

        worker.postMessage({
            type: 'START',
            payload: {
                mode: currentMode,
                algoName: ui.algorithm.value,
                data: data,
                speed: parseInt(ui.speed.value),
                heuristic: ui.heuristic.value
            }
        });
    });

    ui.randomize.addEventListener('click', () => {
        worker.postMessage({ type: 'STOP' });
        randomize();
    });

    // Theory Modal Logic
    const toggleTheory = (show) => {
        ui.theoryModal.classList.toggle('active', show);
        ui.overlay.classList.toggle('active', show);
    };

    ui.theory.addEventListener('click', () => {
        const algoId = ui.algorithm.value;
        const data = Theory[algoId];
        if (data) {
            ui.theoryTitle.textContent = data.title;
            ui.theoryContent.innerHTML = `
                <p style="margin-bottom: 15px">${data.description}</p>
                <div style="background: #f8fafc; padding: 12px; border-radius: 8px; border: 1px solid #e2e8f0;">
                    <strong style="display: block; font-size: 0.75rem; color: #64748b; text-transform: uppercase;">Theoretical Complexity</strong>
                    <code style="color: #3b82f6; font-weight: bold;">${data.complexity}</code>
                    <strong style="display: block; font-size: 0.75rem; color: #64748b; text-transform: uppercase; margin-top: 10px;">Common Use Case</strong>
                    <span style="font-size: 0.9rem;">${data.useCase}</span>
                </div>
            `;
            toggleTheory(true);
        }
    });

    ui.theoryClose.addEventListener('click', () => toggleTheory(false));
    ui.overlay.addEventListener('click', () => toggleTheory(false));

    // Final Init
    const rect = canvas.parentElement.getBoundingClientRect();
    const offscreen = canvas.transferControlToOffscreen();
    worker.postMessage({
        type: 'INIT',
        payload: {
            canvas: offscreen,
            pixelRatio: window.devicePixelRatio || 1,
            width: rect.width,
            height: rect.height,
            mode: RENDER_MODE.LINEAR
        }
    }, [offscreen]);

    initMode('LINEAR');

    // Handle Resize
    window.addEventListener('resize', () => {
        const rect = canvas.parentElement.getBoundingClientRect();
        worker.postMessage({
            type: 'RESIZE',
            payload: {
                width: rect.width,
                height: rect.height
            }
        });
    });
});

