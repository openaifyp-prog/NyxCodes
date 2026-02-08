import { WindowManager } from './window.js';
import { ProjectHub } from './ProjectHub.js';
import { Terminal } from './Terminal.js';
import { Starfield } from './Starfield.js';
import { GameCenter } from './GameCenter.js';

/**
 * @fileoverview Nebula OS Shell - Core System Logic
 */

class NebulaShell {
    constructor() {
        this.timeElement = document.getElementById('system-time');
        this.startBtn = document.getElementById('start-btn');
        this.systemMenu = document.getElementById('system-menu');

        this.starfield = new Starfield('desktop');
        this.windowManager = new WindowManager();
        this.windowManager.onMinimize = (id) => this.updateTaskbar();
        this.windowManager.onClose = (id) => this.updateTaskbar();
        this.windowManager.onCreate = (id) => this.updateTaskbar();


        this.projectHub = new ProjectHub(this.windowManager);
        this.gameCenter = new GameCenter(this.windowManager);

        this.init();
    }

    init() {
        this.updateClock();
        setInterval(() => this.updateClock(), 1000);

        // HUD Telemetry
        this.updateHUD();
        setInterval(() => this.updateHUD(), 3000);

        const bootLogs = [
            'Initializing Kernel...',
            'Mounting Virtual File System...',
            'Loading Aero-Neon UI Engine...',
            'Establishing Neural Link...',
            'System Ready.'
        ];

        const loader = document.getElementById('boot-loader');
        const status = document.getElementById('boot-status');

        let logIndex = 0;
        const logInterval = setInterval(() => {
            if (status) status.textContent = bootLogs[logIndex];
            logIndex++;
            if (logIndex >= bootLogs.length) {
                clearInterval(logInterval);
                setTimeout(() => {
                    if (loader) {
                        loader.style.opacity = '0';
                        setTimeout(() => loader.remove(), 500);
                    }
                    this.setupEventListeners();
                    this.renderIcons();
                    this.spawnWelcomeWindow();
                    this.updateTaskbar();
                    // Initial state is locked (set in HTML/CSS)
                }, 500);
            }
        }, 400);
    }

    updateHUD() {
        const mem = document.getElementById('hud-mem');
        const link = document.getElementById('hud-link');
        if (mem) mem.textContent = `${Math.floor(Math.random() * 10) + 35}%`;
        if (link) {
            const states = ['Secure', 'Active', 'Stable', 'Encrypted'];
            link.textContent = states[Math.floor(Math.random() * states.length)];
        }
    }

    unlock() {
        const loginScreen = document.getElementById('login-screen');
        const desktop = document.getElementById('desktop');

        loginScreen.classList.add('hidden');
        desktop.classList.remove('system-locked');

        // Short delay to allow CSS transitions to finish
        setTimeout(() => {
            loginScreen.style.display = 'none';
        }, 800);
    }

    lock() {
        const loginScreen = document.getElementById('login-screen');
        const desktop = document.getElementById('desktop');

        loginScreen.style.display = 'flex';
        // Force reflow
        loginScreen.offsetHeight;

        loginScreen.classList.remove('hidden');
        desktop.classList.add('system-locked');
    }

    updateTaskbar() {
        const taskbarApps = document.getElementById('taskbar-apps');
        if (!taskbarApps) return;
        taskbarApps.innerHTML = '';

        this.windowManager.windows.forEach(win => {
            const id = win.id;
            const title = win.querySelector('.window-title').textContent;

            // Skip Welcome Window in taskbar
            if (title.toLowerCase().includes('welcome')) return;

            const app = document.createElement('div');
            app.className = `taskbar-item ${win.classList.contains('minimized') ? '' : 'active'}`;
            app.innerHTML = `<span style="font-size: 10px; opacity: 0.7;">⧉</span> ${title}`;
            app.onclick = () => this.windowManager.restore(id);
            taskbarApps.appendChild(app);
        });
    }


    renderIcons() {
        const iconGrid = document.getElementById('desktop-icons');
        iconGrid.innerHTML = '';
        const apps = [
            { id: 'projects', label: 'Project Hub', icon: '📁' },
            { id: 'terminal', label: 'Terminal', icon: '⌨️' },
            { id: 'games', label: 'Games', icon: '🎮' },
            { id: 'settings', label: 'System', icon: '⚙️' }
        ];

        apps.forEach(app => {
            const icon = document.createElement('div');
            icon.className = 'icon';
            icon.dataset.app = app.id;
            icon.innerHTML = `
                <div class="icon-img">
                    <div class="icon-glow"></div>
                    ${app.icon}
                </div>
                <div class="icon-label">${app.label}</div>
            `;

            // Icon Shine Follow
            icon.addEventListener('mousemove', (e) => {
                const rect = icon.getBoundingClientRect();
                const x = ((e.clientX - rect.left) / rect.width) * 100;
                const y = ((e.clientY - rect.top) / rect.height) * 100;
                icon.style.setProperty('--icon-mouse-x', `${x}%`);
                icon.style.setProperty('--icon-mouse-y', `${y}%`);
            });

            icon.addEventListener('click', () => this.launchApp(app.id));
            iconGrid.appendChild(icon);
        });
    }

    launchApp(id) {
        // Single Instance Check
        const existing = document.getElementById(`win-${id}`);
        if (existing) {
            this.windowManager.restore(`win-${id}`);
            return;
        }

        if (id === 'projects') {
            this.projectHub.open();
        } else if (id === 'terminal') {
            const win = this.windowManager.createWindow({
                id: 'win-terminal',
                title: 'System Terminal',
                content: '<div class="terminal-container" style="height: 100%;"></div>',
                width: 600,
                height: 400
            });
            const container = win.querySelector('.terminal-container');
            new Terminal(container, (type, id) => {
                if (type === 'open') this.launchApp(id);
                if (type === 'launch') this.projectHub.launchProject(id);
            });
        } else if (id === 'settings') {
            this.spawnSettingsWindow();
        } else if (id === 'games') {
            this.gameCenter.open();
        }
    }

    setTheme(themeName) {
        document.body.classList.remove('theme-deep-space', 'theme-solar-flare');
        if (themeName !== 'aero') {
            document.body.classList.add(`theme-${themeName}`);
        }

        // Update Starfield color based on theme
        if (this.starfield) {
            const colors = {
                'aero': '#ffffff',
                'deep-space': '#ec4899',
                'solar-flare': '#f59e0b'
            };
            this.starfield.starColor = colors[themeName] || '#ffffff';
        }
    }

    spawnSettingsWindow() {
        const win = this.windowManager.createWindow({
            id: 'win-settings',
            title: 'System Settings',
            content: `
                <div id="settings-view" style="padding: 20px; color: white;">
                    <h3 style="margin-bottom: 20px; color: var(--primary);">Personalization</h3>
                    <div class="settings-group" style="margin-bottom: 30px;">
                        <label style="display: block; font-size: 12px; color: rgba(255,255,255,0.5); margin-bottom: 10px;">Primary Aesthetic</label>
                        <div style="display: grid; grid-template-columns: 1fr 1fr 1fr; gap: 10px;">
                            <button class="setting-btn" data-theme="aero">Aero</button>
                            <button class="setting-btn" data-theme="deep-space">Cosmos</button>
                            <button class="setting-btn" data-theme="solar-flare">Nova</button>
                        </div>
                    </div>
                    <div class="settings-group">
                        <label style="display: block; font-size: 12px; color: rgba(255,255,255,0.5); margin-bottom: 15px;">System Telemetry</label>
                        <div style="padding: 15px; background: rgba(0,0,0,0.2); border-radius: 10px; font-family: 'JetBrains Mono', monospace; font-size: 11px;">
                            <div style="display: flex; justify-content: space-between; margin-bottom: 8px;">
                                <span>Core Version</span>
                                <span style="color: var(--primary);">1.0.42-Master</span>
                            </div>
                            <div style="display: flex; justify-content: space-between;">
                                <span>Build Instance</span>
                                <span style="color: var(--primary);">Production-Stable</span>
                            </div>
                        </div>
                    </div>
                    
                    <style>
                        .setting-btn {
                            background: rgba(255, 255, 255, 0.05);
                            border: 1px solid rgba(255,255,255,0.1);
                            color: white;
                            padding: 12px 5px;
                            border-radius: 8px;
                            cursor: pointer;
                            font-size: 12px;
                            transition: all 0.3s;
                        }
                        .setting-btn:hover {
                            background: rgba(255, 255, 255, 0.1);
                        }
                        .setting-btn.active {
                            background: rgba(99, 102, 241, 0.2);
                            border-color: var(--primary);
                            box-shadow: 0 0 15px rgba(99, 102, 241, 0.2);
                        }
                    </style>
                </div>
            `,
            width: 450,
            height: 480,
            x: (window.innerWidth - 450) / 2,
            y: (window.innerHeight - 480) / 2
        });

        // Initialize button states and listeners
        const btns = win.querySelectorAll('.setting-btn');
        const currentTheme = document.body.classList.contains('theme-deep-space') ? 'deep-space' :
            document.body.classList.contains('theme-solar-flare') ? 'solar-flare' : 'aero';

        btns.forEach(btn => {
            if (btn.dataset.theme === currentTheme) btn.classList.add('active');

            btn.addEventListener('click', () => {
                btns.forEach(b => b.classList.remove('active'));
                btn.classList.add('active');
                this.setTheme(btn.dataset.theme);
            });

            // Re-apply cursor hover listeners to new buttons
            btn.addEventListener('mouseenter', () => document.body.classList.add('cursor-hover'));
            btn.addEventListener('mouseleave', () => document.body.classList.remove('cursor-hover'));
        });
    }

    spawnWelcomeWindow() {
        this.windowManager.createWindow({
            title: 'Welcome to Nebula OS',
            content: `
                <div style="text-align: center; padding: 20px;">
                    <h2 style="color: #6366f1; margin-bottom: 10px;">System Initialized</h2>
                    <p style="font-size: 14px; line-height: 1.5;">
                        Nebula OS is a high-performance virtual desktop environment designed to showcase advanced system architecture and UI design.
                    </p>
                    <div style="margin-top: 20px; padding: 15px; background: rgba(255,255,255,0.03); border-radius: 8px;">
                        <ul style="text-align: left; font-size: 12px; color: rgba(255,255,255,0.7);">
                            <li>• Multi-window Management</li>
                            <li>• Real-time Thread Monitoring</li>
                            <li>• Virtual Project Ecosystem</li>
                        </ul>
                    </div>
                </div>
            `,
            width: 450,
            height: 350,
            x: (window.innerWidth - 450) / 2,
            y: (window.innerHeight - 350) / 2
        });
    }

    updateClock() {
        const now = new Date();
        const hours = String(now.getHours()).padStart(2, '0');
        const minutes = String(now.getMinutes()).padStart(2, '0');
        this.timeElement.textContent = `${hours}:${minutes}`;
    }

    setupEventListeners() {
        document.getElementById('login-btn').addEventListener('click', () => this.unlock());

        // High-Performance Cursor Engine (Desktop Only)
        const cursor = document.getElementById('cursor');
        const cursorDot = document.getElementById('cursor-dot');
        const isTouch = 'ontouchstart' in window || navigator.maxTouchPoints > 0;

        if (!isTouch) {
            let mouseX = 0, mouseY = 0;
            let cursorX = 0, cursorY = 0;
            let dotX = 0, dotY = 0;

            document.addEventListener('mousemove', (e) => {
                mouseX = e.clientX;
                mouseY = e.clientY;

                // Update Window Shine (Directly for responsiveness)
                document.querySelectorAll('.window').forEach(win => {
                    const rect = win.getBoundingClientRect();
                    const x = e.clientX - rect.left;
                    const y = e.clientY - rect.top;
                    win.style.setProperty('--mouse-x', `${x}px`);
                    win.style.setProperty('--mouse-y', `${y}px`);
                    const shine = (x / rect.width) * 50 - 25;
                    win.style.setProperty('--shine-pos', `${shine}%`);
                });
            });

            // Animation Loop for Smooth Cursor
            const animateCursor = () => {
                // Lerp (Linear Interpolation) for outer ring
                cursorX += (mouseX - cursorX) * 0.15;
                cursorY += (mouseY - cursorY) * 0.15;

                // Fast follow for inner dot
                dotX += (mouseX - dotX) * 0.45;
                dotY += (mouseY - dotY) * 0.45;

                cursor.style.left = `${cursorX - 20}px`;
                cursor.style.top = `${cursorY - 20}px`;

                cursorDot.style.left = `${dotX - 3}px`;
                cursorDot.style.top = `${dotY - 3}px`;

                requestAnimationFrame(animateCursor);
            };
            animateCursor();

            document.addEventListener('mousedown', () => document.body.classList.add('cursor-active'));
            document.addEventListener('mouseup', () => document.body.classList.remove('cursor-active'));

            document.querySelectorAll('button, .icon, .project-item, .control-btn, #login-btn').forEach(el => {
                el.addEventListener('mouseenter', () => document.body.classList.add('cursor-hover'));
                el.addEventListener('mouseleave', () => document.body.classList.remove('cursor-hover'));
            });
        } else {
            if (cursor) cursor.style.display = 'none';
            if (cursorDot) cursorDot.style.display = 'none';
            document.body.style.cursor = 'default';
        }

        this.startBtn.addEventListener('click', (e) => {
            e.stopPropagation();
            const isHidden = this.systemMenu.classList.contains('hidden');
            if (isHidden) {
                this.systemMenu.classList.remove('hidden');
            } else {
                this.systemMenu.classList.add('hidden');
            }
        });

        // System Menu Links
        const menuLinks = this.systemMenu.querySelector('.system-menu-links');
        const links = [
            { icon: '🏠', label: 'Main Portfolio', action: () => window.location.href = '../../index.html' },
            { icon: '📁', label: 'Browse Projects', action: () => this.launchApp('projects') },
            { icon: '🔒', label: 'Lock System', action: () => this.lock() },
            { icon: '🔌', label: 'Power Off', action: () => window.location.href = '../../index.html' }
        ];

        links.forEach(link => {
            const item = document.createElement('div');
            item.className = 'menu-item';
            item.style.cssText = 'display: flex; align-items: center; gap: 15px; padding: 12px; cursor: pointer; border-radius: 8px; transition: all 0.2s; color: white;';
            item.innerHTML = `<span>${link.icon}</span><span style="font-size: 14px;">${link.label}</span>`;
            item.addEventListener('mouseenter', () => item.style.background = 'rgba(255,255,255,0.05)');
            item.addEventListener('mouseleave', () => item.style.background = 'transparent');
            item.addEventListener('click', (e) => {
                e.stopPropagation();
                link.action();
                this.systemMenu.classList.add('hidden');
            });
            menuLinks.appendChild(item);
        });

        document.addEventListener('click', (e) => {
            if (!this.systemMenu.contains(e.target) && e.target !== this.startBtn && !this.startBtn.contains(e.target)) {
                this.systemMenu.classList.add('hidden');
            }
        });

        this.systemMenu.addEventListener('click', (e) => {
            e.stopPropagation();
        });
    }
}

document.addEventListener('DOMContentLoaded', () => {
    window.shell = new NebulaShell();
});
