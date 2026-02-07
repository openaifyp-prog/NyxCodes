/**
 * @fileoverview Particle system for the Cyberpunk Nexus.
 * Handles "Data-bits" emitted during algorithmic operations.
 */

export class ParticleSystem {
    constructor() {
        this.particles = [];
        this.colors = ['#00f3ff', '#bc00ff', '#ffffff'];
    }

    /**
     * Emits particles from a specific location.
     * @param {number} x 
     * @param {number} y 
     * @param {number} count 
     */
    emit(x, y, count = 5) {
        for (let i = 0; i < count; i++) {
            this.particles.push({
                x,
                y,
                vx: (Math.random() - 0.5) * 4,
                vy: (Math.random() - 0.5) * 4,
                life: 1.0,
                decay: 0.02 + Math.random() * 0.03,
                size: 1 + Math.random() * 3,
                color: this.colors[Math.floor(Math.random() * this.colors.length)]
            });
        }
    }

    /**
     * Updates and draws particles.
     * @param {CanvasRenderingContext2D} ctx 
     */
    update(ctx) {
        for (let i = this.particles.length - 1; i >= 0; i--) {
            const p = this.particles[i];
            p.x += p.vx;
            p.y += p.vy;
            p.life -= p.decay;

            if (p.life <= 0) {
                this.particles.splice(i, 1);
                continue;
            }

            ctx.globalAlpha = p.life;
            ctx.fillStyle = p.color;
            ctx.shadowBlur = 5;
            ctx.shadowColor = p.color;
            ctx.fillRect(p.x, p.y, p.size, p.size);
        }
        ctx.globalAlpha = 1.0;
        ctx.shadowBlur = 0;
    }
}
