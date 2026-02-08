export class Terminal {
    constructor(container, onSystemCommand) {
        this.container = container;
        this.onSystemCommand = onSystemCommand;
        this.history = [];
        this.historyIndex = -1;
        this.currentDir = '/';

        this.vfs = {
            'projects': {
                type: 'dir', children: [
                    { name: 'haven', type: 'file', content: 'HostelHaven - Managed Instance' },
                    { name: 'syntax', type: 'file', content: 'Syntax Landing - Static Build' },
                    { name: 'atlas', type: 'file', content: 'Atlas Explorer - Geopolitical Hub' },
                    { name: 'logic', type: 'file', content: 'StudioLogic - Performance Core' },
                    { name: 'zenith', type: 'file', content: 'Zenith - Creative Collective' }
                ]
            },
            'system': {
                type: 'dir', children: [
                    { name: 'kernel.sys', type: 'file', content: 'Nebula Core v1.0.4 - Secure Instance' },
                    { name: 'config.json', type: 'file', content: '{"theme": "Aero-Neon", "mode": "Performance"}' }
                ]
            },
            'readme.txt': { type: 'file', content: 'Welcome to Nebula OS Terminal. Type help to see system commands.' }
        };

        this.init();
    }

    init() {
        this.container.innerHTML = `
            <div class="terminal-body" style="font-family: 'JetBrains Mono', monospace; font-size: 13px; line-height: 1.5; color: #10b981; padding: 10px; height: 100%; display: flex; flex-direction: column;">
                <div id="term-output" style="flex: 1; overflow-y: auto; padding-bottom: 20px;">
                    <span style="color: #6366f1;">Initializing Nebula Kernel...</span><br>
                    Welcome to Nebula CLI [Version 1.0.42]<br>
                    (c) 2026 Awais Tariq Systems. All rights reserved.<br><br>
                    Type 'help' for available commands.<br>
                </div>
                <div class="term-input-line" style="display: flex; gap: 8px; border-top: 1px solid rgba(255,255,255,0.05); padding-top: 10px;">
                    <span style="color: #6366f1; font-weight: bold;">visitor@nebula:${this.currentDir}$</span>
                    <input type="text" id="term-input" spellcheck="false" autocomplete="off" style="flex: 1; background: transparent; border: none; color: white; outline: none; font-family: inherit; font-size: inherit;">
                </div>
            </div>
        `;

        this.input = this.container.querySelector('#term-input');
        this.output = this.container.querySelector('#term-output');
        this.promptLabel = this.container.querySelector('b'); // Not used, directly targeted span above

        this.input.addEventListener('keydown', (e) => {
            if (e.key === 'Enter') {
                const cmd = this.input.value.trim();
                if (cmd) {
                    this.history.push(cmd);
                    this.historyIndex = this.history.length;
                    this.execute(cmd);
                }
                this.input.value = '';
            } else if (e.key === 'ArrowUp') {
                e.preventDefault();
                if (this.historyIndex > 0) {
                    this.historyIndex--;
                    this.input.value = this.history[this.historyIndex];
                }
            } else if (e.key === 'ArrowDown') {
                e.preventDefault();
                if (this.historyIndex < this.history.length - 1) {
                    this.historyIndex++;
                    this.input.value = this.history[this.historyIndex];
                } else {
                    this.historyIndex = this.history.length;
                    this.input.value = '';
                }
            }
        });

        this.input.focus();
    }

    execute(cmd) {
        const prompt = `<span style="color: #6366f1;">visitor@nebula:${this.currentDir}$</span>`;
        this.output.innerHTML += `<div style="margin-top: 8px;">${prompt} ${cmd}</div>`;

        const parts = cmd.split(' ');
        const baseCmd = parts[0].toLowerCase();
        const args = parts.slice(1);

        const response = this.processCommand(baseCmd, args);
        if (response) {
            this.output.innerHTML += `<div style="margin-bottom: 15px; color: #cbd5e1;">${response}</div>`;
        }

        this.output.scrollTop = this.output.scrollHeight;
    }

    processCommand(cmd, args) {
        switch (cmd) {
            case 'help':
                return `
                    <div style="color: #6366f1; font-weight: bold; margin-bottom: 5px;">Common Commands:</div>
                    - <span style="color: #10b981;">neofetch</span>: Display system info<br>
                    - <span style="color: #10b981;">ls</span>: List files and directories<br>
                    - <span style="color: #10b981;">cat [file]</span>: Read file content<br>
                    - <span style="color: #10b981;">open [app]</span>: Launch system app (terminal, settings, projects)<br>
                    - <span style="color: #10b981;">launch [id]</span>: Launch specific project window<br>
                    - <span style="color: #10b981;">whoami</span>: Display user info<br>
                    - <span style="color: #10b981;">ping [target]</span>: Test connection<br>
                    - <span style="color: #10b981;">matrix</span>: Start digital rain<br>
                    - <span style="color: #10b981;">clear</span>: Clear screen
                `;
            case 'open':
                if (!args[0]) return '<span style="color: #ef4444;">Error: Specify an app.</span>';
                if (this.onSystemCommand) this.onSystemCommand('open', args[0]);
                return `Opening system component: ${args[0]}...`;
            case 'launch':
                if (!args[0]) return '<span style="color: #ef4444;">Error: Specify a project ID.</span>';
                if (this.onSystemCommand) this.onSystemCommand('launch', args[0]);
                return `Launching industrial project instance: ${args[0]}...`;
            case 'ping':
                const target = args[0] || 'nebula.core';
                this.startPingSimulation(target);
                return `Connecting to ${target}...`;
            case 'ls':
                const items = this.currentDir === '/' ? Object.keys(this.vfs) : [];
                if (this.currentDir === '/') {
                    return Object.entries(this.vfs).map(([name, data]) => {
                        const color = data.type === 'dir' ? '#6366f1' : '#10b981';
                        return `<span style="color: ${color}; margin-right: 20px;">${name}${data.type === 'dir' ? '/' : ''}</span>`;
                    }).join('');
                }
                return 'Permission Denied.';
            case 'cat':
                if (!args[0]) return '<span style="color: #ef4444;">Error: Specify a file.</span>';
                const file = this.vfs[args[0]];
                if (file && file.type === 'file') return file.content;
                return `<span style="color: #ef4444;">Error: File '${args[0]}' not found.</span>`;
            case 'neofetch':
                return `
                    <div style="display: flex; gap: 20px;">
                        <pre style="color: #6366f1; font-size: 10px; margin: 0;">
   _  __     __          __      
  / |/ /__  / /  __ __  / /___ _ 
 /    / _ \\/ _ \\/ // / / / _ \`/ 
/_/|_/\\___/_.__/\\_,_/ /_/\\_,_/  
                                 
                        </pre>
                        <div>
                            <span style="color: #6366f1; font-weight: bold;">visitor</span>@<span style="color: #6366f1; font-weight: bold;">nebula-pc</span><br>
                            -----------------<br>
                            <span style="color: #6366f1;">OS:</span> Nebula OS v1.0.4 x86_64<br>
                            <span style="color: #6366f1;">Host:</span> Web-Virtual-Instance<br>
                            <span style="color: #6366f1;">Kernel:</span> 5.15.0-nebula-generic<br>
                            <span style="color: #6366f1;">Uptime:</span> 4h 20m<br>
                            <span style="color: #6366f1;">Packages:</span> 17 (projects)<br>
                            <span style="color: #6366f1;">Shell:</span> nebula-sh 1.2<br>
                            <span style="color: #6366f1;">Resolution:</span> 1920x1080<br>
                            <span style="color: #6366f1;">CPU:</span> Virtual Neural Engine<br>
                            <span style="color: #6366f1;">Memory:</span> 420MB / 1024MB<br>
                        </div>
                    </div>
                `;
            case 'whoami':
                return 'User: Awais Tariq<br>Role: Architect / Full-stack Developer (Master Artisan)';
            case 'telemetry':
                return `<div style="color: #10b981;">Latency: 2ms | Render: OffscreenCanvas/WebGL | Instance: Active</div>`;
            case 'matrix':
                this.startMatrixEffect();
                return 'Matrix Mode Initialized. [Press Enter to continue]';
            case 'clear':
                this.output.innerHTML = '';
                return '';
            default:
                return `<span style="color: #ef4444;">Command not found: ${cmd}</span>`;
        }
    }

    startPingSimulation(target) {
        let iterations = 0;
        const maxIterations = 5;
        const pingInterval = setInterval(() => {
            const latency = Math.floor(Math.random() * 20) + 1;
            this.output.innerHTML += `<div>Reply from ${target}: seq=${iterations} time=${latency}ms status=SECURE</div>`;
            this.output.scrollTop = this.output.scrollHeight;
            iterations++;

            if (iterations === maxIterations) {
                clearInterval(pingInterval);
                this.output.innerHTML += `<div style="color: #10b981; margin-top: 5px;">Connection to ${target} established. Link quality: 99.8%</div>`;
                this.output.scrollTop = this.output.scrollHeight;
            }
        }, 800);
    }

    startMatrixEffect() {
        this.output.innerHTML = '';
        const matrixInterval = setInterval(() => {
            const line = Array.from({ length: 40 }, () => Math.random() > 0.5 ? '1' : '0').join('');
            this.output.innerHTML += `<div style="color: #10b981; opacity: 0.8; font-size: 11px;">${line}</div>`;
            this.output.scrollTop = this.output.scrollHeight;
            if (this.output.children.length > 30) this.output.children[0].remove();
        }, 50);

        const stopListener = (e) => {
            if (e.key === 'Enter') {
                clearInterval(matrixInterval);
                this.output.innerHTML = '';
                this.execute('clear');
                this.input.removeEventListener('keydown', stopListener);
            }
        };
        this.input.addEventListener('keydown', stopListener);
    }
}
