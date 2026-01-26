// DOM Elements
const priceGrid = document.getElementById('price-grid');
const trendingList = document.getElementById('trending-list');
const lastUpdatedEl = document.getElementById('last-updated');
const ctx = document.getElementById('mainChart').getContext('2d');

let mainChart;

// --- API Configurations (Coingecko Free Tier) ---
const PRICES_API = 'https://api.coingecko.com/api/v3/simple/price?ids=bitcoin,ethereum,solana,ripple&vs_currencies=usd&include_24hr_change=true';
const TRENDING_API = 'https://api.coingecko.com/api/v3/search/trending';
const CHART_API = 'https://api.coingecko.com/api/v3/coins/bitcoin/market_chart?vs_currency=usd&days=1&interval=hourly';

// --- Formatters ---
const formatUSD = (num) => new Intl.NumberFormat('en-US', { style: 'currency', currency: 'USD' }).format(num);
const formatPct = (num) => `${num > 0 ? '+' : ''}${num.toFixed(2)}%`;

async function fetchPrices() {
    try {
        const res = await fetch(PRICES_API);
        const data = await res.json();
        renderPrices(data);
        lastUpdatedEl.innerText = `Updated: ${new Date().toLocaleTimeString()}`;
    } catch (e) {
        console.error("Price Fetch Error", e);
    }
}

async function fetchTrending() {
    try {
        const res = await fetch(TRENDING_API);
        const data = await res.json();
        renderTrending(data.coins.slice(0, 4));
    } catch (e) {
        console.error("Trending Fetch Error", e);
    }
}

async function fetchChart() {
    try {
        const res = await fetch(CHART_API);
        const data = await res.json();
        renderChart(data.prices);
    } catch (e) {
        console.error("Chart Fetch Error", e);
    }
}

// --- Render Functions ---

function renderPrices(data) {
    priceGrid.innerHTML = '';

    // Map IDs to display names and icons (simplified for demo)
    const configs = [
        { id: 'bitcoin', name: 'Bitcoin', symbol: 'BTC', icon: 'https://assets.coingecko.com/coins/images/1/small/bitcoin.png' },
        { id: 'ethereum', name: 'Ethereum', symbol: 'ETH', icon: 'https://assets.coingecko.com/coins/images/279/small/ethereum.png' },
        { id: 'solana', name: 'Solana', symbol: 'SOL', icon: 'https://assets.coingecko.com/coins/images/4128/small/solana.png' },
        { id: 'ripple', name: 'XRP', symbol: 'XRP', icon: 'https://assets.coingecko.com/coins/images/44/small/xrp-symbol-white-128.png' }
    ];

    configs.forEach(coin => {
        const price = data[coin.id].usd;
        const change = data[coin.id].usd_24h_change;
        const isPos = change >= 0;

        priceGrid.innerHTML += `
            <div class="glass-panel p-6 rounded-2xl hover:bg-white/5 transition-colors cursor-pointer group">
                <div class="flex justify-between items-start mb-4">
                    <div class="flex items-center gap-3">
                        <img src="${coin.icon}" class="w-8 h-8 rounded-full">
                        <div>
                            <h4 class="font-bold">${coin.name}</h4>
                            <span class="text-xs text-gray-400">${coin.symbol}</span>
                        </div>
                    </div>
                    <div class="${isPos ? 'bg-green-500/20 text-green-400' : 'bg-red-500/20 text-red-400'} px-2 py-1 rounded text-xs font-bold">
                        ${formatPct(change)}
                    </div>
                </div>
                <div class="text-2xl font-bold font-mono tracking-tight group-hover:text-indigo-400 transition-colors">
                    ${formatUSD(price)}
                </div>
            </div>
        `;
    });
}

function renderTrending(coins) {
    trendingList.innerHTML = coins.map(item => `
        <div class="flex items-center justify-between p-2 rounded hover:bg-white/5 transition-colors">
            <div class="flex items-center gap-3">
                <img src="${item.item.small}" class="w-6 h-6 rounded-full">
                <span class="font-medium text-sm">${item.item.name}</span>
            </div>
            <span class="text-xs text-gray-500">Rank #${item.item.market_cap_rank}</span>
        </div>
    `).join('');
}

function renderChart(prices) {
    // Labels (Hours) and Data (Prices)
    const labels = prices.map(p => new Date(p[0]).toLocaleTimeString([], { hour: '2-digit', minute: '2-digit' }));
    const dataPoints = prices.map(p => p[1]);

    if (mainChart) mainChart.destroy();

    mainChart = new Chart(ctx, {
        type: 'line',
        data: {
            labels: labels,
            datasets: [{
                label: 'Bitcoin (USD)',
                data: dataPoints,
                borderColor: '#6366f1',
                backgroundColor: 'rgba(99, 102, 241, 0.1)',
                borderWidth: 2,
                pointRadius: 0,
                fill: true,
                tension: 0.4
            }]
        },
        options: {
            responsive: true,
            maintainAspectRatio: false,
            plugins: {
                legend: { display: false }
            },
            scales: {
                x: { display: false },
                y: {
                    display: true,
                    grid: { color: 'rgba(255, 255, 255, 0.05)' },
                    ticks: { color: '#64748b' }
                }
            },
            interaction: {
                intersect: false,
                mode: 'index',
            },
        }
    });
}

// Init
fetchPrices();
fetchTrending();
fetchChart();
// Refresh prices every 60s
setInterval(fetchPrices, 60000);
