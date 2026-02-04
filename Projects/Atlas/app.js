/* --- State --- */
let allCountries = [];
let filteredCountries = [];
let comparisonList = [];

/* --- DOM Elements --- */
const grid = document.getElementById('countries-grid');
const searchInput = document.getElementById('search-input');
const regionChips = document.querySelectorAll('.chip');
const totalCountSpan = document.getElementById('total-count');
const totalPopSpan = document.getElementById('total-pop');

const slot1 = document.getElementById('slot-1');
const slot2 = document.getElementById('slot-2');
const compareBtn = document.getElementById('compare-btn');
const modal = document.getElementById('comparison-modal');
const modalBody = document.getElementById('comparison-result');
const closeModal = document.querySelector('.close-modal');

/* --- Init --- */
// Fetch "Everything" but optimize by skipping unused heavy data (translations, demonyms, etc)
const API_URL = 'https://restcountries.com/v3.1/all?fields=name,cca3,flags,region,population,area,capital,languages,currencies';

async function init() {
    try {
        // Try fetching with retries
        const data = await fetchWithRetry(API_URL, 3);

        allCountries = data.map(c => ({
            name: c.name.common,
            code: c.cca3,
            flag: c.flags.svg,
            region: c.region,
            population: c.population,
            area: c.area,
            capital: c.capital && c.capital.length > 0 ? c.capital[0] : 'N/A',
            languages: c.languages ? Object.values(c.languages).join(', ') : 'N/A',
            currencies: c.currencies ? Object.values(c.currencies).map(curr => curr.name).join(', ') : 'N/A',
            density: c.area > 0 ? (c.population / c.area).toFixed(1) : 0
        })).sort((a, b) => b.population - a.population);

        filteredCountries = [...allCountries];

        updateStats();
        renderGrid(filteredCountries.slice(0, 20)); // Lazy render first 20

        // Render rest after a frame
        setTimeout(() => {
            renderGrid(filteredCountries);
        }, 50);

    } catch (error) {
        console.warn('Live API failed after retries. Using backup data.', error);
        useBackupData();
    }
}

async function fetchWithRetry(url, retries = 3, delay = 1000) {
    for (let i = 0; i < retries; i++) {
        try {
            const res = await fetch(url);
            if (!res.ok) throw new Error(`HTTP ${res.status}`);
            return await res.json();
        } catch (err) {
            console.log(`Attempt ${i + 1} failed. Retrying in ${delay}ms...`);
            if (i === retries - 1) throw err;
            await new Promise(r => setTimeout(r, delay));
        }
    }
}

function useBackupData() {
    allCountries = backupData.map(c => ({
        name: c.name.common,
        code: c.cca3,
        flag: c.flags.svg,
        region: c.region,
        population: c.population,
        area: c.area,
        capital: c.capital ? c.capital[0] : 'N/A'
    })).sort((a, b) => b.population - a.population);

    filteredCountries = [...allCountries];
    updateStats();
    renderGrid(filteredCountries);
    showToast('Network unstable: Functioning in Offline Mode');
}

function showToast(msg) {
    const toast = document.createElement('div');
    toast.style.cssText = `
        position: fixed; bottom: 20px; right: 20px;
        background: var(--accent); color: white;
        padding: 10px 20px; border-radius: 8px;
        box-shadow: 0 4px 12px rgba(0,0,0,0.3);
        z-index: 1000; font-size: 0.9rem;
        animation: slideIn 0.3s ease;
    `;
    toast.textContent = msg;
    document.body.appendChild(toast);
    setTimeout(() => toast.remove(), 4000);
}

// Backup Data (Top 10 Countries for Demo)
const backupData = [
    { "name": { "common": "France" }, "cca3": "FRA", "region": "Europe", "population": 67391582, "area": 551695, "capital": ["Paris"], "flags": { "svg": "https://flagcdn.com/fr.svg" } },
    { "name": { "common": "United States" }, "cca3": "USA", "region": "Americas", "population": 329484123, "area": 9372610, "capital": ["Washington, D.C."], "flags": { "svg": "https://flagcdn.com/us.svg" } },
    { "name": { "common": "China" }, "cca3": "CHN", "region": "Asia", "population": 1402112000, "area": 9640011, "capital": ["Beijing"], "flags": { "svg": "https://flagcdn.com/cn.svg" } },
    { "name": { "common": "India" }, "cca3": "IND", "region": "Asia", "population": 1380004385, "area": 3287590, "capital": ["New Delhi"], "flags": { "svg": "https://flagcdn.com/in.svg" } },
    { "name": { "common": "Brazil" }, "cca3": "BRA", "region": "Americas", "population": 212559409, "area": 8515767, "capital": ["Brasília"], "flags": { "svg": "https://flagcdn.com/br.svg" } },
    { "name": { "common": "Australia" }, "cca3": "AUS", "region": "Oceania", "population": 25499881, "area": 7692024, "capital": ["Canberra"], "flags": { "svg": "https://flagcdn.com/au.svg" } },
    { "name": { "common": "Canada" }, "cca3": "CAN", "region": "Americas", "population": 38005238, "area": 9984670, "capital": ["Ottawa"], "flags": { "svg": "https://flagcdn.com/ca.svg" } },
    { "name": { "common": "Germany" }, "cca3": "DEU", "region": "Europe", "population": 83240525, "area": 357114, "capital": ["Berlin"], "flags": { "svg": "https://flagcdn.com/de.svg" } },
    { "name": { "common": "Japan" }, "cca3": "JPN", "region": "Asia", "population": 125836021, "area": 377930, "capital": ["Tokyo"], "flags": { "svg": "https://flagcdn.com/jp.svg" } },
    { "name": { "common": "United Kingdom" }, "cca3": "GBR", "region": "Europe", "population": 67215293, "area": 242900, "capital": ["London"], "flags": { "svg": "https://flagcdn.com/gb.svg" } }
];

/* --- Rendering --- */
function renderGrid(data) {
    grid.innerHTML = data.map((country, index) => `
        <article class="country-card" 
                 onclick="toggleCompare('${country.code}')"
                 style="animation-delay: ${index * 0.05}s">
            <img src="${country.flag}" alt="${country.name}" class="card-flag" loading="lazy">
            <div class="card-info">
                <h3>${country.name}</h3>
                <div class="card-meta">
                    <span>${formatNumber(country.population)} People</span>
                    <span>${country.capital}</span>
                </div>
            </div>
            ${getSelectionBadge(country.code)}
        </article>
    `).join('');
}

function getSelectionBadge(code) {
    if (comparisonList.find(c => c.code === code)) {
        return `<div style="position:absolute; top:8px; right:8px; background:var(--accent); color:white; padding:4px 8px; border-radius:4px; font-size:10px; font-weight:bold;">SELECTED</div>`;
    }
    return '';
}

function updateStats() {
    totalCountSpan.textContent = filteredCountries.length;
    // Calculate total population of visible countries
    const totalPop = filteredCountries.reduce((acc, curr) => acc + curr.population, 0);
    totalPopSpan.textContent = formatCompactNumber(totalPop);
}

/* --- Layout Toggles --- */
const gridViewBtn = document.getElementById('grid-view');
const listViewBtn = document.getElementById('list-view');

gridViewBtn.addEventListener('click', () => {
    grid.classList.remove('list-view');
    gridViewBtn.classList.add('active');
    listViewBtn.classList.remove('active');
});

listViewBtn.addEventListener('click', () => {
    grid.classList.add('list-view');
    listViewBtn.classList.add('active');
    gridViewBtn.classList.remove('active');
});

/* --- Filtering --- */
function filterData() {
    const query = searchInput.value.toLowerCase();
    const activeRegion = document.querySelector('.chip.active').dataset.region;

    filteredCountries = allCountries.filter(c => {
        const matchesName = c.name.toLowerCase().includes(query);
        const matchesRegion = activeRegion === 'all' || c.region === activeRegion;
        return matchesName && matchesRegion;
    });

    updateStats();
    renderGrid(filteredCountries);
}

searchInput.addEventListener('input', filterData);

regionChips.forEach(chip => {
    chip.addEventListener('click', () => {
        document.querySelector('.chip.active').classList.remove('active');
        chip.classList.add('active');
        filterData();
    });
});

/* --- Comparator Logic --- */
window.toggleCompare = function (code) {
    const country = allCountries.find(c => c.code === code);

    // Check if currently selected
    const index = comparisonList.findIndex(c => c.code === code);

    if (index >= 0) {
        // Deselect it if already selected
        comparisonList.splice(index, 1);
    } else {
        // Select new country
        if (comparisonList.length >= 2) {
            // FIFO: Remove the oldest one (first in array)
            comparisonList.shift();
        }
        comparisonList.push(country);
    }

    updateComparatorUI();
    renderGrid(filteredCountries); // Re-render to show badges
};

function updateComparatorUI() {
    // Update Slots
    const c1 = comparisonList[0];
    const c2 = comparisonList[1];

    if (c1) {
        slot1.classList.add('filled');
        slot1.textContent = c1.name;
        slot1.style.backgroundImage = `linear-gradient(rgba(0,0,0,0.6), rgba(0,0,0,0.6)), url(${c1.flag})`;
    } else {
        slot1.classList.remove('filled');
        slot1.textContent = slot1.dataset.empty;
        slot1.style.backgroundImage = 'none';
    }

    if (c2) {
        slot2.classList.add('filled');
        slot2.textContent = c2.name;
        slot2.style.backgroundImage = `linear-gradient(rgba(0,0,0,0.6), rgba(0,0,0,0.6)), url(${c2.flag})`;
    } else {
        slot2.classList.remove('filled');
        slot2.textContent = slot2.dataset.empty;
        slot2.style.backgroundImage = 'none';
    }

    // Enable Button
    compareBtn.disabled = comparisonList.length !== 2;
}

compareBtn.addEventListener('click', () => {
    if (comparisonList.length !== 2) return;

    const [c1, c2] = comparisonList;

    // Helper to determine winner/highlight
    const getWinnerClass = (val1, val2) => {
        if (parseFloat(val1) > parseFloat(val2)) return ['winner', ''];
        if (parseFloat(val2) > parseFloat(val1)) return ['', 'winner'];
        return ['', ''];
    };

    const popWinners = getWinnerClass(c1.population, c2.population);
    const areaWinners = getWinnerClass(c1.area, c2.area);
    const densityWinners = getWinnerClass(c1.density, c2.density);

    // Generate Comparison HTML
    modalBody.innerHTML = `
        <div class="comp-header">
            <div style="text-align:center">
                <img src="${c1.flag}" class="flag">
                <h3>${c1.name}</h3>
            </div>
            <div class="vs-badge">VS</div>
            <div style="text-align:center">
                <img src="${c2.flag}" class="flag">
                <h3>${c2.name}</h3>
            </div>
        </div>
        
        <div class="comparison-grid">
            ${createCompRow('Population', formatCompactNumber(c1.population), formatCompactNumber(c2.population), popWinners)}
            ${createCompRow('Land Area', formatCompactNumber(c1.area) + ' km²', formatCompactNumber(c2.area) + ' km²', areaWinners)}
            ${createCompRow('Density', c1.density + '/km²', c2.density + '/km²', densityWinners)}
            ${createCompRow('Region', c1.region, c2.region, ['', ''])}
            ${createCompRow('Currencies', c1.currencies, c2.currencies, ['', ''])}
        </div>

        <div class="insight-box">
             <i class="ph ph-lightbulb"></i>
             <span>${generateInsight(c1, c2)}</span>
        </div>
    `;

    modal.classList.add('active');
});

function createCompRow(label, val1, val2, winners) {
    return `
        <div class="comp-row">
            <div class="comp-val ${winners[0]}">${val1}</div>
            <div class="comp-label">${label}</div>
            <div class="comp-val ${winners[1]}">${val2}</div>
        </div>
    `;
}

closeModal.addEventListener('click', () => {
    modal.classList.remove('active');
});

/* --- Utilities --- */
function formatNumber(num) {
    return new Intl.NumberFormat('en-US').format(num);
}

function formatCompactNumber(num) {
    return new Intl.NumberFormat('en-US', { notation: "compact", maximumFractionDigits: 1 }).format(num);
}

function generateInsight(c1, c2) {
    const insights = [];

    // Geographical Shared
    if (c1.region !== 'N/A' && c1.region === c2.region) {
        insights.push(`Both are located in the region of **${c1.region}**.`);
    }

    // Population Density
    const d1 = parseFloat(c1.density);
    const d2 = parseFloat(c2.density);
    if (d1 > d2 * 10) {
        insights.push(`**${c1.name}** is extremely crowded compared to **${c2.name}**.`);
    }

    // Population Diff
    if (c1.population > c2.population * 100) {
        insights.push(`**${c1.name}** has a massive population advantage.`);
    }

    // Default or Mixed
    if (insights.length === 0) {
        return `These two nations offer distinct geographic and cultural landscapes, with **${c1.name}** and **${c2.name}** representing unique chapters of world history.`;
    }

    return insights.join(' ');
}

/* --- Run --- */
init();
