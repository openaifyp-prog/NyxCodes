/**
 * @fileoverview Nebula OS Starfield Engine - Immersive Background
 */

export class Starfield {
    constructor(containerId) {
        this.canvas = document.createElement('canvas');
        this.ctx = this.canvas.getContext('2d');
        this.container = document.getElementById(containerId);

        this.stars = [];
        this.count = 400;
        this.mouse = { x: 0, y: 0 };

        this.init();
    }

    init() {
        this.canvas.style.position = 'absolute';
        this.canvas.style.top = '0';
        this.canvas.style.left = '0';
        this.canvas.style.zIndex = '-2';
        this.container.appendChild(this.canvas);

        this.resize();
        window.addEventListener('resize', () => this.resize());

        document.addEventListener('mousemove', (e) => {
            this.mouse.x = (e.clientX - window.innerWidth / 2) * 0.05;
            this.mouse.y = (e.clientY - window.innerHeight / 2) * 0.05;
        });

        this.createStars();
        this.animate();
    }

    resize() {
        this.canvas.width = window.innerWidth;
        this.canvas.height = window.innerHeight;
    }

    createStars() {
        for (let i = 0; i < this.count; i++) {
            this.stars.push({
                x: Math.random() * this.canvas.width,
                y: Math.random() * this.canvas.height,
                size: Math.random() * 1.5,
                speed: Math.random() * 0.5 + 0.1,
                opacity: Math.random()
            });
        }
    }

    animate() {
        this.ctx.clearRect(0, 0, this.canvas.width, this.canvas.height);

        this.stars.forEach(star => {
            // Draw Star
            const color = this.starColor || '#ffffff';
            this.ctx.fillStyle = color;
            this.ctx.globalAlpha = star.opacity;
            this.ctx.beginPath();
            this.ctx.arc(star.x, star.y, star.size, 0, Math.PI * 2);
            this.ctx.fill();
            this.ctx.globalAlpha = 1.0;

            // Move Star (Parallax)
            star.x += (star.speed + this.mouse.x * 0.1);
            star.y += (this.mouse.y * 0.1);

            // Wrap around
            if (star.x > this.canvas.width) star.x = 0;
            if (star.x < 0) star.x = this.canvas.width;
            if (star.y > this.canvas.height) star.y = 0;
            if (star.y < 0) star.y = this.canvas.height;
        });

        requestAnimationFrame(() => this.animate());
    }
}
