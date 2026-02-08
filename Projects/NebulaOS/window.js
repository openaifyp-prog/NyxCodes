/**
 * @fileoverview Nebula OS Windowing Engine
 */

export class WindowManager {
    constructor() {
        this.windowLayer = document.getElementById('window-layer');
        this.windows = [];
        this.highestZIndex = 100;
    }

    createWindow(options = {}) {
        let {
            title = 'New Window',
            content = '',
            width = 600,
            height = 400,
            x = 100,
            y = 100,
            id = `win-${Math.random().toString(36).substr(2, 9)}`
        } = options;

        const isMobile = window.innerWidth < 600;

        if (isMobile) {
            width = window.innerWidth * 0.95;
            height = Math.min(height, window.innerHeight * 0.8);
            x = (window.innerWidth - width) / 2;
            y = 40; // Avoid taskbar/header
        } else {
            // Clamp to screen
            width = Math.min(width, window.innerWidth - 40);
            height = Math.min(height, window.innerHeight - 100);
            x = Math.max(10, Math.min(x, window.innerWidth - width - 10));
            y = Math.max(10, Math.min(y, window.innerHeight - height - 10));
        }

        const win = document.createElement('div');
        win.id = id;
        win.className = `window ${isMobile ? 'mobile-view' : ''}`;
        win.style.width = isMobile ? `${width}px` : `${width}px`;
        win.style.height = isMobile ? `${height}px` : `${height}px`;
        win.style.left = `${x}px`;
        win.style.top = `${y}px`;
        win.style.zIndex = ++this.highestZIndex;

        win.innerHTML = `
            <div class="window-header">
                <div class="window-title">${title}</div>
                <div class="window-controls">
                    <div class="control-btn minimize"></div>
                    <div class="control-btn maximize"></div>
                    <div class="control-btn close"></div>
                </div>
            </div>
            <div class="window-content">${content}</div>
            <div class="resizer" style="position: absolute; bottom: 0; right: 0; width: 15px; height: 15px; cursor: nwse-resize; z-index: 10;"></div>
        `;

        this.windowLayer.appendChild(win);
        this.setupDragging(win);
        this.setupControls(win);

        this.windows.push(win);
        if (this.onCreate) this.onCreate(win.id);
        return win;
    }

    setupDragging(win) {
        const header = win.querySelector('.window-header');
        let isDragging = false;
        let startX, startY, initialX, initialY;

        header.onmousedown = (e) => {
            isDragging = true;
            startX = e.clientX;
            startY = e.clientY;
            initialX = win.offsetLeft;
            initialY = win.offsetTop;

            // Bring to front
            win.style.zIndex = ++this.highestZIndex;

            document.onmousemove = (e) => {
                if (!isDragging) return;
                const dx = e.clientX - startX;
                const dy = e.clientY - startY;
                win.style.left = `${initialX + dx}px`;
                win.style.top = `${initialY + dy}px`;
            };

            document.onmouseup = () => {
                isDragging = false;
                document.onmousemove = null;
                document.onmouseup = null;
            };
        };
    }

    close(id) {
        const win = document.getElementById(id);
        if (win) {
            win.remove();
            this.windows = this.windows.filter(w => w.id !== id);
            if (this.onClose) this.onClose(id);
        }
    }

    setupControls(win) {
        win.querySelector('.control-btn.close').onclick = () => {
            this.close(win.id);
        };

        const minimizeBtn = win.querySelector('.control-btn.minimize');
        minimizeBtn.onclick = () => {
            win.classList.add('minimized');
            if (this.onMinimize) this.onMinimize(win.id);
        };

        const maximizeBtn = win.querySelector('.control-btn.maximize');
        let isMaximized = false;
        let prevRect = {};

        maximizeBtn.onclick = () => {
            if (!isMaximized) {
                prevRect = {
                    width: win.style.width,
                    height: win.style.height,
                    left: win.style.left,
                    top: win.style.top
                };
                win.style.width = '100vw';
                win.style.height = 'calc(100vh - 50px)';
                win.style.left = '0';
                win.style.top = '0';
                win.style.borderRadius = '0';
                isMaximized = true;
            } else {
                win.style.width = prevRect.width;
                win.style.height = prevRect.height;
                win.style.left = prevRect.left;
                win.style.top = prevRect.top;
                win.style.borderRadius = '12px';
                isMaximized = false;
            }
        };

        const resizer = win.querySelector('.resizer');
        resizer.onmousedown = (e) => {
            e.preventDefault();
            const startWidth = parseInt(document.defaultView.getComputedStyle(win).width, 10);
            const startHeight = parseInt(document.defaultView.getComputedStyle(win).height, 10);
            const startX = e.clientX;
            const startY = e.clientY;

            const onMouseMove = (e) => {
                win.style.width = startWidth + (e.clientX - startX) + 'px';
                win.style.height = startHeight + (e.clientY - startY) + 'px';
            };

            const onMouseUp = () => {
                document.removeEventListener('mousemove', onMouseMove);
                document.removeEventListener('mouseup', onMouseUp);
            };

            document.addEventListener('mousemove', onMouseMove);
            document.addEventListener('mouseup', onMouseUp);
        };

        win.onmousedown = () => {
            win.style.zIndex = ++this.highestZIndex;
        };
    }

    restore(id) {
        const win = document.getElementById(id);
        if (win) {
            win.classList.remove('minimized');
            win.style.zIndex = ++this.highestZIndex;
        }
    }
}
