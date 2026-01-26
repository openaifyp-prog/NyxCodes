// Basic Date Display
const dateElement = document.getElementById('current-date');
const options = { weekday: 'long', year: 'numeric', month: 'long', day: 'numeric' };
if (dateElement) dateElement.textContent = new Date().toLocaleDateString('en-US', options);

const heroSection = document.getElementById('hero-section');
const newsGrid = document.getElementById('news-grid');
const categoryButtons = document.querySelectorAll('.category-btn');

// --- Real Data Source ---
// Using saurav.tech NewsAPI Mirror (Free, No Key required)
const BASE_URL = 'https://saurav.tech/NewsAPI/top-headlines/category/';
const REGION = 'us.json';

// Fallback data (Simulated)
const fallbackData = [
    {
        title: "System Update: Connecting to News Feed...",
        source: { name: "Nexus System" },
        urlToImage: "https://images.unsplash.com/photo-1504711434969-e33886168f5c?q=80&w=2070",
        description: "We are currently establishing a connection to the global news network.",
        url: "#",
        publishedAt: new Date().toISOString()
    }
];

async function fetchNews(category = 'general') {
    // Show Loading State
    if (newsGrid) newsGrid.innerHTML = '<div class="col-span-1 md:col-span-3 text-center py-20 text-gray-500 animate-pulse font-serif text-xl">Fetching live updates...</div>';

    try {
        // Fetch from the mirror API
        const response = await fetch(`${BASE_URL}${category}/${REGION}`);
        if (!response.ok) throw new Error('Network response was not ok');
        const data = await response.json();

        let articles = data.articles;

        // Filter out broken articles (removed content, no images)
        articles = articles.filter(article =>
            article.urlToImage &&
            article.title !== "[Removed]" &&
            article.description
        );

        // Render
        if (articles.length > 0) {
            renderHero(articles[0]);
            renderGrid(articles.slice(1));
        } else {
            renderGrid(fallbackData);
            if (heroSection) heroSection.innerHTML = '';
        }

    } catch (error) {
        console.error("Fetch Error:", error);
        if (newsGrid) newsGrid.innerHTML = `
            <div class="col-span-1 md:col-span-3 text-center py-10">
                <p class="text-red-500 mb-2">Unable to load live news.</p>
                <p class="text-gray-400 text-sm">Please check your internet connection.</p>
            </div>
        `;
    }
}

function renderHero(article) {
    if (!heroSection || !article) return;

    const date = new Date(article.publishedAt).toLocaleDateString(undefined, { hour: '2-digit', minute: '2-digit' });

    heroSection.innerHTML = `
        <a href="${article.url}" target="_blank" class="block relative w-full h-[400px] md:h-[500px] rounded-2xl overflow-hidden group cursor-pointer shadow-xl">
            <img src="${article.urlToImage}" alt="${article.title}" class="w-full h-full object-cover group-hover:scale-105 transition-transform duration-700">
            <div class="absolute inset-0 bg-gradient-to-t from-black/90 via-black/40 to-transparent"></div>
            <div class="absolute bottom-0 left-0 p-6 md:p-10 text-white max-w-3xl">
                <span class="bg-red-600 text-white text-xs font-bold px-3 py-1 rounded-full uppercase tracking-wider mb-3 inline-block">Top Story</span>
                <h1 class="text-3xl md:text-5xl font-bold font-serif leading-tight mb-4 group-hover:text-gray-200 transition-colors drop-shadow-lg">${article.title}</h1>
                <p class="text-lg text-gray-300 line-clamp-2 md:line-clamp-none mb-4 drop-shadow-md">${article.description || ''}</p>
                <div class="flex items-center gap-4 text-sm text-gray-400">
                    <span class="font-medium text-white">${article.source.name}</span>
                    <span>•</span>
                    <span>${date}</span>
                </div>
            </div>
        </a>
    `;
}

function renderGrid(articles) {
    if (!newsGrid) return;

    newsGrid.innerHTML = articles.map(article => {
        const date = new Date(article.publishedAt).toLocaleDateString(undefined, { month: 'short', day: 'numeric' });

        return `
        <a href="${article.url}" target="_blank" class="flex flex-col group cursor-pointer h-full bg-white rounded-xl overflow-hidden shadow-sm hover:shadow-md transition-shadow">
            <div class="relative h-48 overflow-hidden bg-gray-200">
                <img src="${article.urlToImage}" alt="${article.title}" loading="lazy" class="w-full h-full object-cover group-hover:scale-110 transition-transform duration-500">
            </div>
            <div class="flex-1 flex flex-col p-4">
                <div class="flex items-center gap-2 mb-2">
                     <span class="text-xs font-bold text-red-600 uppercase tracking-wider">${article.source.name}</span>
                </div>
                <h3 class="text-xl font-bold font-serif leading-snug mb-2 group-hover:text-red-700 transition-colors text-gray-900 line-clamp-3">
                    ${article.title}
                </h3>
                <p class="text-gray-600 text-sm line-clamp-3 mb-4 flex-1">
                    ${article.description || ''}
                </p>
                <div class="flex items-center justify-between text-xs text-gray-400 mt-auto border-t border-gray-100 pt-3">
                    <span>${date}</span>
                    <span class="text-blue-600 font-medium">Read More &rarr;</span>
                </div>
            </div>
        </a>
    `}).join('');
}

// Category Filtering
if (categoryButtons) {
    categoryButtons.forEach(btn => {
        btn.addEventListener('click', () => {
            // Active State UI
            categoryButtons.forEach(b => {
                b.classList.remove('text-black', 'border-b-2', 'border-black');
                b.classList.add('text-gray-500');
            });
            btn.classList.remove('text-gray-500');
            btn.classList.add('text-black', 'border-b-2', 'border-black');

            const category = btn.dataset.category;
            fetchNews(category);
        });
    });
}

// Search functionality 
const searchInput = document.getElementById('search-input');
let searchTimeout;

if (searchInput) {
    searchInput.addEventListener('input', (e) => {
        clearTimeout(searchTimeout);
        searchTimeout = setTimeout(() => {
            const term = e.target.value.toLowerCase();
            const articles = document.querySelectorAll('#news-grid > a');

            articles.forEach(article => {
                const title = article.querySelector('h3').innerText.toLowerCase();
                if (title.includes(term)) {
                    article.style.display = 'flex';
                } else {
                    article.style.display = 'none';
                }
            });
        }, 300);
    });
}

// Start
fetchNews('general');
