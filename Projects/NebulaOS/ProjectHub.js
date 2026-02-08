/**
 * @fileoverview Nebula OS Project Hub - Portfolio Showcase
 */

export class ProjectHub {
    constructor(windowManager) {
        this.windowManager = windowManager;
        this.projects = [
            { id: 'clean', title: 'Clean Africa', icon: '🌱', category: 'Web' },
            { id: 'education', title: 'Education Landing', icon: '🎓', category: 'Web' },
            { id: 'dartar', title: 'Dartar.Ai', icon: '🎯', category: 'SaaS' },
            { id: 'zenith', title: 'Zenith Architecture', icon: '🏛️', category: 'Design' },
            { id: 'gourmet', title: 'Gourmet AI', icon: '🍲', category: 'Web' },
            { id: 'atlas', title: 'Atlas Explorer', icon: '🌍', category: 'Web' },
            { id: 'syntax', title: 'Syntax Snaps', icon: '📸', category: 'Web' },
            { id: 'velvet', title: 'Velvet Real Estate', icon: '✨', category: 'Web' },
            { id: 'orbit', title: 'Orbit Tasks', icon: '🛰️', category: 'Productivity' },
            { id: 'flux', title: 'Flux Fintech', icon: '💳', category: 'Web' },
            { id: 'haven', title: 'Hostel Haven', icon: '🏠', category: 'Web' },
            { id: 'decora', title: 'Decora Interior', icon: '🛋️', category: 'Design' },
            { id: 'codemaze', title: 'Code Maze', icon: '🎮', category: 'Mobile' },
            { id: 'coinpulse', title: 'CoinPulse', icon: '📈', category: 'Web' },
            { id: 'nexus', title: 'Nexus News', icon: '📰', category: 'Web' },
            { id: 'weather', title: 'WeatherNova 3D', icon: '☁️', category: 'Web' },
            { id: 'logic', title: 'Studio Logic', icon: '🧠', category: 'Systems' }
        ];

    }

    open() {
        const content = this.renderGrid();
        const win = this.windowManager.createWindow({
            id: 'win-projects',
            title: 'Project Hub',
            content: content,
            width: 850,
            height: 600,
            x: (window.innerWidth - 850) / 2,
            y: (window.innerHeight - 600) / 2
        });

        this.attachListeners(win);
    }

    renderGrid() {
        return `
            <div class="project-hub-container">
                <header class="hub-header">
                    <h3 style="margin:0;">Project Ecosystem</h3>
                    <p style="margin:5px 0 0 0;">${this.projects.length} Verified Industrial Applications</p>
                </header>
                <div class="project-grid">
                    ${this.projects.map(p => `
                        <div class="project-item" data-id="${p.id}">
                            <div class="project-icon">${p.icon}</div>
                            <div class="project-info">
                                <div class="project-name">${p.title}</div>
                                <div class="project-tag">${p.category}</div>
                            </div>
                        </div>
                    `).join('')}
                </div>
            </div>
            <style>
                .project-hub-container { color: white; padding: 20px; }
                .hub-header { margin-bottom: 25px; border-bottom: 1px solid rgba(255,255,255,0.1); padding-bottom: 15px; }
                .hub-header h3 { font-size: 24px; font-weight: 700; color: #6366f1; }
                .hub-header p { font-size: 13px; color: rgba(255,255,255,0.5); }
                
                .project-grid {
                    display: grid;
                    grid-template-columns: repeat(auto-fill, minmax(160px, 1fr));
                    gap: 12px;
                }
                @media (max-width: 500px) {
                    .project-grid { grid-template-columns: 1fr; }
                    .hub-header h3 { font-size: 18px; }
                }
                
                .project-item {
                    background: rgba(255,255,255,0.03);
                    border: 1px solid rgba(255,255,255,0.05);
                    border-radius: 12px;
                    padding: 15px;
                    display: flex;
                    align-items: center;
                    gap: 15px;
                    cursor: pointer;
                    transition: all 0.2s;
                }
                
                .project-item:hover {
                    background: rgba(99, 102, 241, 0.1);
                    border-color: #6366f1;
                    transform: translateY(-2px);
                }
                
                .project-icon {
                    font-size: 24px;
                    width: 48px;
                    height: 48px;
                    background: rgba(255,255,255,0.05);
                    border-radius: 10px;
                    display: flex;
                    align-items: center;
                    justify-content: center;
                }
                
                .project-name { font-weight: 600; font-size: 14px; }
                .project-tag { font-size: 11px; color: #6366f1; text-transform: uppercase; font-weight: 700; }
            </style>
        `;
    }

    attachListeners(win) {
        const items = win.querySelectorAll('.project-item');
        items.forEach(item => {
            item.addEventListener('click', () => {
                const id = item.dataset.id;
                this.launchProject(id);
            });
        });
    }

    launchProject(id) {
        // Single Instance Check for Projects
        const winId = `proj-${id}`;
        const existing = document.getElementById(winId);
        if (existing) {
            this.windowManager.restore(winId);
            return;
        }

        let url = '';
        switch (id) {
            case 'clean': url = '../CleanAfrica/CleanAfrica.html'; break;
            case 'education': url = '../Education landing page/index.html'; break;
            case 'dartar': url = '../Dartar.Ai/darterAi.html'; break;
            case 'zenith': url = '../Zenith/index.html'; break;
            case 'gourmet': url = '../Gourmet/index.html'; break;
            case 'atlas': url = '../Atlas/index.html'; break;
            case 'syntax': url = '../Syntax/index.html'; break;
            case 'velvet': url = '../Velvet/index.html'; break;
            case 'orbit': url = '../Orbit/index.html'; break;
            case 'flux': url = '../Flux/index.html'; break;
            case 'haven': url = '../HostelHaven/index.html'; break;
            case 'decora': url = '../Decora Interior Design/DecoraInteriorDesign.html'; break;
            case 'codemaze': url = 'https://github.com/openaifyp-prog/NyxCodes/tree/main/codemaze'; break;
            case 'coinpulse': url = '../CoinPulse/index.html'; break;
            case 'nexus': url = '../NexusNews/index.html'; break;
            case 'weather': url = '../WeatherNova/index.html'; break;
            case 'logic': url = '../StudioLogic/index.html'; break;
            default: url = 'https://google.com'; // Fallback
        }

        this.windowManager.createWindow({
            id: winId,
            title: `App: ${id.toUpperCase()}`,
            content: `<iframe src="${url}" style="width: 100%; height: 100%; border: none; border-radius: 8px;"></iframe>`,
            width: 900,
            height: 600
        });
    }
}
