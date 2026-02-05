/* --- Data: Luxury Properties --- */
const featuredProperties = [
    {
        id: 1,
        title: "The Obsidian Penthouse",
        location: "Manhattan, NY",
        price: "$45,000,000",
        image: "https://images.unsplash.com/photo-1542314831-068cd1dbfeeb?ixlib=rb-4.0.3&auto=format&fit=crop&w=2600&q=80",
        tags: ["Penthouse", "Skyline View", "Pool"]
    },
    {
        id: 2,
        title: "Villa Serenity",
        location: "Amalfi Coast, Italy",
        price: "€12,500,000",
        image: "https://images.unsplash.com/photo-1623298317883-6b70254edf31?ixlib=rb-4.0.3&auto=format&fit=crop&w=2600&q=80",
        tags: ["Waterfront", "Historic", "Vineyard"]
    },
    {
        id: 3,
        title: "Aspen Alpine Estate",
        location: "Aspen, CO",
        price: "$28,000,000",
        image: "https://images.unsplash.com/photo-1512917774080-9991f1c4c750?ixlib=rb-4.0.3&auto=format&fit=crop&w=2600&q=80",
        tags: ["Ski-in/Out", "Modern", "Mountain View"]
    },
    {
        id: 4,
        title: "Kyoto Tea House",
        location: "Kyoto, Japan",
        price: "¥850,000,000",
        image: "https://images.unsplash.com/photo-1600607686527-6fb886090705?ixlib=rb-4.0.3&auto=format&fit=crop&w=2600&q=80",
        tags: ["Traditional", "Zen Garden", "Private"]
    },
    {
        id: 5,
        title: "Monaco Harbor View",
        location: "Monte Carlo, Monaco",
        price: "€32,000,000",
        image: "https://images.unsplash.com/photo-1512915922686-57c11dde9b6b?ixlib=rb-4.0.3&auto=format&fit=crop&w=2600&q=80",
        tags: ["Seaview", "Modern", "Exclusive"]
    },
    {
        id: 6,
        title: "Beverly Hills Estate",
        location: "Los Angeles, CA",
        price: "$19,500,000",
        image: "https://images.unsplash.com/photo-1600585154340-be6161a56a0c?ixlib=rb-4.0.3&auto=format&fit=crop&w=2600&q=80",
        tags: ["Pool", "Cinema", "Gated"]
    }
];

const heroSlides = [
    {
        image: "https://images.unsplash.com/photo-1613553507747-5f8d62ad5904?ixlib=rb-4.0.3&auto=format&fit=crop&w=2600&q=80",
        title: "The Architectural Void",
        subtitle: "Minimalist concrete sanctuary in the desert."
    },
    {
        image: "https://images.unsplash.com/photo-1512917774080-9991f1c4c750?ixlib=rb-4.0.3&auto=format&fit=crop&w=2600&q=80",
        title: "Alpine Elevation",
        subtitle: "Where luxury meets the peaks."
    },
    {
        image: "https://images.unsplash.com/photo-1600596542815-2a4d9fpps52d?ixlib=rb-4.0.3&auto=format&fit=crop&w=2600&q=80",
        title: "Urban Zenith",
        subtitle: "The crown jewel of the skyline."
    }
];

/* --- Global State --- */
let currentSlide = 0;
let slideInterval;

/* --- Hero Slider Logic --- */
function initSlider() {
    const sliderContainer = document.getElementById('hero-slider');
    if (!sliderContainer) return;

    // Generate Slides
    heroSlides.forEach((slide, index) => {
        const slideDiv = document.createElement('div');
        slideDiv.classList.add('slide');
        if (index === 0) slideDiv.classList.add('active');
        slideDiv.style.backgroundImage = `url('${slide.image}')`;
        sliderContainer.appendChild(slideDiv);
    });

    // Control Listeners
    const prevBtn = document.getElementById('prev-slide');
    const nextBtn = document.getElementById('next-slide');
    if (nextBtn) nextBtn.addEventListener('click', () => { moveSlide(1); resetTimer(); });
    if (prevBtn) prevBtn.addEventListener('click', () => { moveSlide(-1); resetTimer(); });

    startSlideTimer();
}

function moveSlide(direction) {
    let next = currentSlide + direction;
    if (next >= heroSlides.length) next = 0;
    if (next < 0) next = heroSlides.length - 1;
    updateSlide(next);
}

function updateSlide(index) {
    const sliderContainer = document.getElementById('hero-slider');
    if (!sliderContainer) return;

    const slides = sliderContainer.querySelectorAll('.slide');
    if (!slides.length) return;

    const heroTitle = document.querySelector('.hero-title');
    const heroSubtitle = document.querySelector('.hero-subtitle');

    // Fade Out
    slides.forEach(s => s.classList.remove('active'));

    // Update Text
    if (heroTitle && heroSlides[index]) heroTitle.textContent = heroSlides[index].title;
    if (heroSubtitle && heroSlides[index]) heroSubtitle.textContent = heroSlides[index].subtitle;

    // Reset Animations for text
    if (heroTitle && heroSubtitle) {
        heroTitle.classList.remove('fade-in-up');
        heroSubtitle.classList.remove('fade-in-up');
        void heroTitle.offsetWidth; // Force Reflow
        heroTitle.classList.add('fade-in-up');
        heroSubtitle.classList.add('fade-in-up');
    }

    // Fade In
    slides[index].classList.add('active');
    currentSlide = index;
}

function startSlideTimer() {
    const sliderContainer = document.getElementById('hero-slider');
    if (!sliderContainer) return;
    slideInterval = setInterval(() => moveSlide(1), 6000);
}

function resetTimer() {
    if (slideInterval) {
        clearInterval(slideInterval);
        startSlideTimer();
    }
}

/* --- Property Grid Rendering --- */
function renderProperties() {
    const gridContainer = document.getElementById('property-grid');
    if (!gridContainer) return;

    gridContainer.innerHTML = featuredProperties.map(prop => `
        <article class="property-card">
            <div class="property-image-wrapper">
                <img src="${prop.image}" alt="${prop.title}" class="property-image">
                <div class="property-overlay">
                    <span class="btn-outline">View Details</span>
                </div>
            </div>
            
            <div class="property-info">
                <h3 class="property-title">${prop.title}</h3>
                <p class="property-location">${prop.location}</p>
                <div class="property-meta">
                    <span class="property-price">${prop.price}</span>
                    <span class="property-tag">${prop.tags[0]}</span>
                </div>
            </div>
        </article>
    `).join('');
}

/* --- Header Scroll Effect --- */
function initHeaderScroll() {
    const header = document.querySelector('.site-header');
    if (!header) return;

    window.addEventListener('scroll', () => {
        if (window.scrollY > 50) {
            header.classList.add('scrolled');
        } else {
            // Only remove if it's not a sub-page that starts with scrolled
            // Actually, sub-pages want the background when scrolling too.
            // If we're at the very top, we can remove it.
            header.classList.remove('scrolled');
        }
    });
}

/* --- Mobile Menu Logic --- */
function initMobileMenu() {
    const toggleBtn = document.querySelector('.menu-toggle');
    if (!toggleBtn) return;
    const icon = toggleBtn.querySelector('i');

    // Create Overlay if it doesn't exist
    let overlay = document.querySelector('.mobile-nav-overlay');
    if (!overlay) {
        overlay = document.createElement('div');
        overlay.className = 'mobile-nav-overlay';
        document.body.appendChild(overlay);
    }

    // Clone Links (Only if overlay is empty)
    if (overlay.innerHTML === '') {
        const links = document.querySelectorAll('.desktop-nav a');
        links.forEach(link => {
            const mobileLink = link.cloneNode(true);
            mobileLink.className = 'mobile-nav-link';
            mobileLink.style.color = ''; // Reset active state color
            overlay.appendChild(mobileLink);

            // Close on click
            mobileLink.addEventListener('click', () => toggleMenu());
        });
    }

    function toggleMenu() {
        overlay.classList.toggle('active');
        const isActive = overlay.classList.contains('active');

        // Toggle Icon
        if (icon) icon.className = isActive ? 'ph ph-x' : 'ph ph-list';

        // Prevent scrolling when menu is open
        document.body.style.overflow = isActive ? 'hidden' : '';
    }

    // Attach click listener (ensure single attachment)
    toggleBtn.removeEventListener('click', toggleMenu);
    toggleBtn.addEventListener('click', toggleMenu);
}

/* --- Init --- */
document.addEventListener('DOMContentLoaded', () => {
    try {
        initHeaderScroll();
    } catch (e) {
        console.error("Header scroll init failed", e);
    }

    try {
        initMobileMenu();
    } catch (e) {
        console.error("Mobile menu init failed", e);
    }

    try {
        initSlider();
    } catch (e) {
        console.error("Slider init failed", e);
    }

    try {
        renderProperties();
    } catch (e) {
        console.error("Properties init failed", e);
    }
});
