/**
 * Engine V2: Robust Project Loader
 * Focus: Prevents layout collapse on missing data.
 */

document.addEventListener('DOMContentLoaded', () => {
    console.log('Engine V2: Started');

    // Debug: Check if data exists
    if (typeof PROJECTS_DETAILS === 'undefined') {
        console.error('CRITICAL: PROJECTS_DETAILS is not defined. Check case-study-data.js loading.');
        document.getElementById('hero-title').textContent = 'Error: Data Source Missing';
        return;
    }

    const urlParams = new URLSearchParams(window.location.search);
    const projectId = urlParams.get('project');
    console.log('Project ID from URL:', projectId);

    // 1. Fail-Safe Data Retrieval
    if (!projectId || !PROJECTS_DETAILS[projectId]) {
        console.warn('Project ID missing or invalid. Defaulting to clean-africa for demo.');
        loadProject('clean-africa');
    } else {
        loadProject(projectId);
    }
});

function loadProject(id) {
    const data = PROJECTS_DETAILS[id];
    if (!data) return;

    // --- A. THEME INJECTION ---
    document.documentElement.style.setProperty('--primary', data.themeColor || '#0f172a');

    // --- B. TEXT CONTENT HYDRATION ---
    safeSetText('hero-title', data.title);
    safeSetText('hero-intro', data.intro);
    safeSetText('challenge-text', data.challenge);
    safeSetText('solution-text', data.solution);

    // --- C. BUTTON LINKING ---
    const btnLive = document.getElementById('btn-live');
    if (btnLive) {
        btnLive.href = data.liveLink || '#';
        if (!data.liveLink) {
            btnLive.style.opacity = '0.5';
            btnLive.textContent = 'Coming Soon';
            btnLive.style.pointerEvents = 'none';
        }
    }

    // --- D. ROBUST IMAGE LOADING ---
    const heroImg = document.getElementById('hero-img');
    if (heroImg) {
        if (data.mockup) {
            heroImg.style.display = 'block'; // RESET visibility in case onerror fired previously
            heroImg.src = data.mockup;
        } else {
            // If data explicitly says "" (no image), hide img but KEEP container size
            heroImg.style.display = 'none';
        }
    }

    // --- E. TAGS GENERATION ---
    const tagsContainer = document.getElementById('hero-tags');
    if (tagsContainer && data.tech) {
        tagsContainer.innerHTML = ''; // Clear loading placeholder
        data.tech.forEach(tech => {
            const span = document.createElement('span');
            span.className = 'tag';
            span.textContent = tech;
            tagsContainer.appendChild(span);
        });
    }

    // --- F. RESULTS LIST ---
    const resultsContainer = document.getElementById('results-list');
    if (resultsContainer && data.results) {
        resultsContainer.innerHTML = '';
        data.results.forEach(res => {
            const li = document.createElement('li');
            li.textContent = res;
            resultsContainer.appendChild(li);
        });
    }

    // --- H. USE CASE INJECTION (ZIG-ZAG) ---
    const useCaseWrapper = document.getElementById('use-cases');

    // 1. Custom Content Injector
    if (useCaseWrapper && data.customContent) {
        useCaseWrapper.innerHTML = '<div style="padding:4rem; text-align:center;">Loading content...</div>';
        fetch(data.customContent)
            .then(r => r.text())
            .then(html => useCaseWrapper.innerHTML = html)
            .catch(e => useCaseWrapper.innerHTML = 'Error loading content.');
    }

    // 2. Standard JSON Generator (Fallback)
    if (useCaseWrapper && data.detailedUseCases && !data.customContent) {
        useCaseWrapper.innerHTML = ''; // Clear
        data.detailedUseCases.forEach((uc, index) => {
            const row = document.createElement('div');
            row.className = 'feature-row';

            // Visual Side (Left or Right based on index)
            let visualHTML = '';
            if (uc.visual) {
                // If specific visual path
                visualHTML = `<img src="${uc.visual}" alt="${uc.title}" onerror="this.onerror=null; this.src='https://placehold.co/600x400?text=Missing+Visual'">`;
            } else if (uc.type === 'diagram' && uc.steps) {
                // Generate a flow diagram from the steps array
                const stepsHTML = uc.steps.map((step, i) => {
                    const arrow = i < uc.steps.length - 1
                        ? `<div style="align-self:center; color:#cbd5e1; font-size:1rem; margin:0 0.5rem;"><i class="fa-solid fa-arrow-right"></i></div>`
                        : '';
                    return `
                        <div style="display:flex; flex-direction:column; align-items:center; gap:0.5rem; min-width:80px;">
                           <div style="width:40px; height:40px; background:${data.themeColor}20; color:${data.themeColor}; border-radius:50%; display:flex; align-items:center; justify-content:center; font-size:1rem; border:1px solid ${data.themeColor}50;">
                               <i class="${step.icon}"></i>
                           </div>
                           <span style="font-size:0.75rem; font-weight:600; color:#475569; text-align:center; max-width:80px; line-height:1.2;">${step.label}</span>
                        </div>
                        ${arrow}
                    `;
                }).join('');

                visualHTML = `
                    <div style="padding:2rem; background:white; border-radius:1rem; box-shadow:0 4px 6px -1px rgb(0 0 0 / 0.05); display:flex; justify-content:center; align-items:center; flex-wrap:wrap; height:100%;">
                        <div style="display:flex; flex-wrap:wrap; justify-content:center; gap:0.5rem;">
                            ${stepsHTML}
                        </div>
                    </div>`;
            } else if (uc.type === 'diagram') {
                // Fallback if steps missing
                visualHTML = `<div style="padding:2rem; text-align:center; color:#64748b;"><i class="fa-solid fa-code-branch" style="font-size:3rem; margin-bottom:1rem;"></i><br>Architecture Diagram</div>`;
            } else {
                visualHTML = `<div style="padding:2rem; text-align:center; color:#64748b;"><i class="fa-solid fa-layer-group" style="font-size:3rem; margin-bottom:1rem;"></i><br>${uc.title}</div>`;
            }

            // Logic Steps from Array
            const logicList = uc.logic ? `<ul style="margin-top:1rem; padding-left:1.2rem; color:#64748b;">${uc.logic.map(i => `<li>${i}</li>`).join('')}</ul>` : '';

            row.innerHTML = `
                <div class="text-col">
                    <span style="color:var(--primary); font-weight:700; text-transform:uppercase; font-size:0.85rem; letter-spacing:0.1em;">Feature 0${index + 1}</span>
                    <h2 style="font-family:var(--font-display); font-size:2.5rem; margin: 0.5rem 0 1.5rem;">${uc.title}</h2>
                    <p style="color:#334155; line-height:1.7;">${uc.scenario}</p>
                    ${logicList}
                </div>
                <div class="visual-col">
                    ${visualHTML}
                </div>
            `;
            useCaseWrapper.appendChild(row);
        });
    }
}



// Utility: Prevents crash if ID missing in HTML
function safeSetText(id, text) {
    const el = document.getElementById(id);
    if (el) el.textContent = text || '';
}
