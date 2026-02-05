document.addEventListener('DOMContentLoaded', () => {
    const body = document.body;

    // --- 1. Preloader ---
    // --- 1. Preloader ---
    const preloader = document.getElementById('preloader');
    // Reduced timeout for better LCP
    if (preloader) {
        setTimeout(() => {
            preloader.classList.add('loaded');
        }, 500);
    }

    // --- 2. Custom Cursor ---
    // --- 2. Custom Cursor ---
    const cursor = document.querySelector('.cursor');
    // REMOVED: Initial selection here is now handled by functions
    let mouseX = 0, mouseY = 0;
    let cursorX = 0, cursorY = 0;

    if (cursor) {
        window.addEventListener('mousemove', (e) => {
            mouseX = e.clientX;
            mouseY = e.clientY;
        });

        function animateCursor() {
            const dx = mouseX - cursorX;
            const dy = mouseY - cursorY;

            // Idle detection to save CPU
            if (Math.abs(dx) < 0.1 && Math.abs(dy) < 0.1) {
                requestAnimationFrame(animateCursor);
                return;
            }

            cursorX += dx * 0.1;
            cursorY += dy * 0.1;
            // Use CSS variables for hardware accelerated movement
            cursor.style.setProperty('--cursor-x', `${cursorX}px`);
            cursor.style.setProperty('--cursor-y', `${cursorY}px`);
            requestAnimationFrame(animateCursor);
        }
        animateCursor();
    }

    function initHoverLinks() {
        const hoverLinks = document.querySelectorAll('a, button, .cursor-hover');
        hoverLinks.forEach(link => {
            // Remove previous listeners to avoid duplicates if re-init (optional but safer)
            link.removeEventListener('mouseenter', onMouseEnter);
            link.removeEventListener('mouseleave', onMouseLeave);

            link.addEventListener('mouseenter', onMouseEnter);
            link.addEventListener('mouseleave', onMouseLeave);
        });
    }

    const onMouseEnter = () => { if (cursor) cursor.classList.add('cursor-grow'); }
    const onMouseLeave = () => { if (cursor) cursor.classList.remove('cursor-grow'); }

    initHoverLinks();

    // --- 3. Magnetic Buttons ---
    function initMagneticLinks() {
        const magneticLinks = document.querySelectorAll('.magnetic-link');
        magneticLinks.forEach(link => {
            // Clean up old listeners
            link.removeEventListener('mousemove', onMagneticMove);
            link.removeEventListener('mouseleave', onMagneticLeave);

            link.addEventListener('mousemove', onMagneticMove);
            link.addEventListener('mouseleave', onMagneticLeave);
        });
    }

    function onMagneticMove(e) {
        const rect = this.getBoundingClientRect();
        const x = e.clientX - (rect.left + rect.width / 2);
        const y = e.clientY - (rect.top + rect.height / 2);
        this.style.transform = `translate(${x * 0.1}px, ${y * 0.1}px)`;
        this.style.transition = 'transform 0.1s ease-out';
    }

    function onMagneticLeave() {
        this.style.transform = 'translate(0, 0)';
        this.style.transition = 'transform 0.4s cubic-bezier(0.165, 0.84, 0.44, 1)';
    }

    initMagneticLinks();

    // --- NEW: Typing Effect ---
    const typingWords = ['Web Development', 'UI Design', 'Responsive Layouts'];
    let textIndex = 0;
    let charIndex = 0;
    let isDeleting = false;
    const typeSpeed = 100;
    const deleteSpeed = 50;
    const delay = 2000;
    const typingEl = document.getElementById('typing-effect');

    function type() {
        const currentWord = typingWords[textIndex];
        let displayText = '';

        if (isDeleting) {
            displayText = currentWord.substring(0, charIndex - 1);
            charIndex--;
        } else {
            displayText = currentWord.substring(0, charIndex + 1);
            charIndex++;
        }

        typingEl.textContent = displayText;

        let typeDuration = isDeleting ? deleteSpeed : typeSpeed;

        if (!isDeleting && charIndex === currentWord.length) {
            typeDuration = delay;
            isDeleting = true;
        } else if (isDeleting && charIndex === 0) {
            typeDuration = 500;
            isDeleting = false;
            textIndex = (textIndex + 1) % typingWords.length;
        }

        setTimeout(type, typeDuration);
    }

    // Start the typing effect
    if (typingEl) {
        // setTimeout(type, 500); // Handled by immediate hero reveal
    }


    // --- 4. Hero 3D Sphere (three.js) ---
    let scene, camera, renderer, particleSystem;
    let mouse = new THREE.Vector2();
    const canvas = document.getElementById('hero-canvas');

    function initThree() {
        scene = new THREE.Scene();
        camera = new THREE.PerspectiveCamera(75, window.innerWidth / window.innerHeight, 0.1, 1000);

        // Adjust camera distance based on screen width
        if (window.innerWidth < 768) {
            camera.position.z = 7; // Further back for mobile
        } else {
            camera.position.z = 5; // Default for desktop
        }

        renderer = new THREE.WebGLRenderer({ canvas: canvas, alpha: true });
        renderer.setClearColor(0xffffff, 0);
        renderer.setSize(window.innerWidth, window.innerHeight);
        renderer.setPixelRatio(Math.min(window.devicePixelRatio, 2));

        const particleCount = 1500; // Reduced from 5000 for TBT/Performance
        const positions = new Float32Array(particleCount * 3);
        const geometry = new THREE.BufferGeometry();
        const material = new THREE.PointsMaterial({
            color: 0x2563EB,
            size: 0.015,
            transparent: true,
            blending: THREE.AdditiveBlending,
            depthWrite: false
        });

        for (let i = 0; i < particleCount; i++) {
            const i3 = i * 3;
            const phi = Math.acos(-1 + (2 * i) / particleCount);
            const theta = Math.sqrt(particleCount * Math.PI) * phi;
            positions[i3] = 2.5 * Math.cos(theta) * Math.sin(phi);
            positions[i3 + 1] = 2.5 * Math.sin(theta) * Math.sin(phi);
            positions[i3 + 2] = 2.5 * Math.cos(phi);
        }
        geometry.setAttribute('position', new THREE.BufferAttribute(positions, 3));

        particleSystem = new THREE.Points(geometry, material);
        scene.add(particleSystem);

        window.addEventListener('resize', onWindowResize);
        window.addEventListener('mousemove', onMouseMove);
        animateThree();
    }

    function onWindowResize() {
        camera.aspect = window.innerWidth / window.innerHeight;
        camera.updateProjectionMatrix();

        // Update camera position on resize
        if (window.innerWidth < 768) {
            camera.position.z = 7;
        } else {
            camera.position.z = 5;
        }

        renderer.setSize(window.innerWidth, window.innerHeight);
        renderer.setPixelRatio(Math.min(window.devicePixelRatio, 2));
    }

    function onMouseMove(event) {
        mouse.x = (event.clientX / window.innerWidth) * 2 - 1;
        mouse.y = -(event.clientY / window.innerHeight) * 2 + 1;
    }

    function animateThree() {
        requestAnimationFrame(animateThree);

        particleSystem.rotation.y += 0.0005;
        particleSystem.rotation.x += 0.0005;

        camera.position.x += (mouse.x * 0.5 - camera.position.x) * 0.02;
        camera.position.y += (mouse.y * 0.5 - camera.position.y) * 0.02;
        camera.lookAt(scene.position);

        renderer.render(scene, camera);
    }

    if (canvas) {
        initThree();
    }

    // --- 5. Intersection Observer for Reveals ---
    const revealElements = document.querySelectorAll('.reveal');
    const revealObserver = new IntersectionObserver((entries, observer) => {
        entries.forEach(entry => {
            if (entry.isIntersecting) {
                entry.target.classList.add('reveal-visible');
                const textElements = entry.target.querySelectorAll('.reveal-text');
                textElements.forEach(textEl => {
                    // Check if already split (has span children)
                    if (textEl.children.length === 0) {
                        // Check if we should split by word or just reveal
                        if (textEl.parentElement.classList.contains('reveal-text')) {
                            const originalText = textEl.innerText;
                            const words = originalText.split(' ');
                            textEl.innerHTML = words.map((word, i) => `<span style="--i: ${i}; margin-left: ${i > 0 ? '0.2em' : '0'};">${word}</span>`).join('');
                        }
                    }
                });
            }
        });
    }, { threshold: 0.1 });

    // IMMEDIATE HERO REVEAL (Fix LCP)
    // Don't wait for observer for the visible hero content
    setTimeout(() => {
        const heroSection = document.getElementById('home');
        if (heroSection) {
            heroSection.querySelectorAll('.reveal-text').forEach(el => {
                el.closest('.reveal')?.classList.add('reveal-visible');
                // Manually trigger the text split if needed, or rely on CSS
                el.style.transform = 'translateY(0)'; // Force visible
                el.style.opacity = '1';
            });
            // Trigger typing effect earlier
            if (typingEl) {
                type();
            }
        }
    }, 100);

    revealElements.forEach(el => {
        // Special handling for hero text - removed as it's now hardcoded in HTML
        revealObserver.observe(el);
    });

    // --- 6. Projects Data & Rendering ---
    const projectsData = [
        {
            id: "clean-africa",
            title: "Clean Africa NGO",
            image: "https://images.unsplash.com/photo-1542601906990-b4d3fb778b09?q=80&w=1200", // Clean Africa NGO
            tags: ["Non-Profit", "Eco", "HTML", "CSS"],
            description: "A comprehensive multi-page website for an environmental NGO, featuring donation flows, project galleries, and blog.",
            category: "Web",
            link: "Projects/CleanAfrica/CleanAfrica.html",
            hasCaseStudy: true
        },
        {
            id: "lars-petters",
            title: "Lars Petters Education",
            image: "https://images.unsplash.com/photo-1524178232363-1fb2b075b655?q=80&w=1200", // Lars Petters Education
            tags: ["HTML", "CS", "SwiperJS", "EdTech"],
            description: "A comprehensive education platform landing page featuring course categories, instructor carousels, and student testimonials.",
            category: "Web",
            link: "Projects/Education landing page/index.html",
            hasCaseStudy: true
        },
        {
            id: "dartar-ai",
            title: "Dartar.ai Tech Landing",
            image: "https://images.unsplash.com/photo-1550751827-4bd374c3f58b?q=80&w=1200", // Dartar.ai Tech Landing
            tags: ["HTML", "Tailwind", "SaaS", "Tech"],
            description: "A modern B2B landing page for an AI logistics startup. Features clean corporate design, feature grids, and pricing tables.",
            category: "Web",
            link: "Projects/Dartar.Ai/darterAi.html",
            hasCaseStudy: true
        },
        {
            id: "zenith",
            title: "Zenith Architecture",
            image: "https://images.unsplash.com/photo-1486406146926-c627a92ad1ab?q=80&w=1200", // Zenith Architecture
            tags: ["Design", "Minimalist", "Tailwind", "Animation"],
            description: "A premium, minimalist portfolio for an architecture studio. Focuses on whitespace, elegant typography, and micro-interactions.",
            category: "Design",
            link: "Projects/Zenith/index.html",
            hasCaseStudy: true
        },
        {
            id: "gourmet",
            title: "Gourmet Recipe AI",
            image: "https://images.unsplash.com/photo-1495521821757-a1efb6729352?q=80&w=1200", // Gourmet Recipe AI
            tags: ["API", "AI Search", "Logic", "Utility"],
            description: "A smart culinary assistant that fetches 5000+ real-world recipes. Features an 'Ingredient Scaler' that mathematically adjust portions and a 'Feeling Lucky' randomizer.",
            category: "Web",
            link: "Projects/Gourmet/index.html",
            hasCaseStudy: true
        },
        {
            id: "atlas-explorer",
            title: "Atlas Explorer",
            image: "https://images.unsplash.com/photo-1451187580459-43490279c0fa?q=80&w=1200", // Atlas Explorer
            tags: ["API", "Data", "Dashboard"],
            description: "An interactive world data explorer using the RestCountries API. Features real-time search, stats, and a country comparator tool.",
            category: "Web",
            link: "Projects/Atlas/index.html",
            hasCaseStudy: true
        },
        {
            id: "syntax",
            title: "Syntax Code Snaps",
            image: "https://images.unsplash.com/photo-1542831371-29b0f74f9713?q=80&w=1200", // Syntax Code Snaps
            tags: ["JS", "Canvas", "Tool", "SaaS"],
            description: "A developer tool to create aesthetic code screenshots. Features live customization, multiple themes, and client-side image generation.",
            category: "Web",
            link: "Projects/Syntax/index.html",
            hasCaseStudy: true
        },
        {
            id: "velvet",
            title: "Velvet Real Estate",
            image: "https://images.unsplash.com/photo-1600585154340-be6161a56a0c?q=80&w=1200", // Velvet Real Estate
            tags: ["HTML", "CSS", "JS", "Luxury"],
            description: "A premium real estate showcase featuring a 'Ken Burns' slider, elegant serif typography, and a hover-reveal property grid.",
            category: "Web",
            link: "Projects/Velvet/index.html",
            hasCaseStudy: true
        },
        {
            id: "orbit",
            title: "Orbit Task Manager",
            image: "https://images.unsplash.com/photo-1484480974693-6ca0a78fb36b?q=80&w=1200", // Orbit Task Manager
            tags: ["JS", "Kanban", "Drag & Drop", "Productivity"],
            description: "A calm, pastel-themed productivity tool featuring a drag-and-drop Kanban board, local storage persistence, and light/dark modes.",
            category: "Web",
            link: "Projects/Orbit/index.html",
            hasCaseStudy: true
        },
        {
            id: "flux",
            title: "Flux Fintech",
            image: "https://images.unsplash.com/photo-1460925895917-afdab827c52f?q=80&w=1200", // Flux Fintech
            tags: ["JS", "Chart.js", "Glassmorphism", "Fintech"],
            description: "A modern fintech dashboard featuring a glassmorphism aesthetic, interactive Chart.js analytics, and dynamic transaction tracking.",
            category: "Web",
            link: "Projects/Flux/index.html",
            hasCaseStudy: true
        },
        {
            id: "hostel-haven",
            title: "The Nook Hostel",
            image: "https://images.unsplash.com/photo-1596250410216-1ac77dc208e3?q=80&w=1200", // Hostel Haven
            tags: ["HTML", "CSS", "Boho Design", "Travel"],
            description: "A reimagined hostel booking platform with a warm, boho-rustic aesthetic. Features a split-hero layout, floating booking widgets, and specialty amenity showcases.",
            category: "Web",
            link: "Projects/HostelHaven/index.html",
            hasCaseStudy: true
        },
        {
            id: "decora",
            title: "Decora Interior Design",
            image: "https://images.unsplash.com/photo-1618221195710-dd6b41faaea6?q=80&w=1200", // Decora Interior Design
            tags: ["HTML", "CSS", "E-Commerce", "Design"],
            description: "An elegant interior design and e-commerce platform. Features product listings, services page, and a polished dark-themed footer.",
            category: "Design",
            link: "Projects/Decora Interior Design/DecoraInteriorDesign.html",
            hasCaseStudy: true
        },
        {
            id: "code-maze",
            title: "Code Maze - Mobile Game",
            image: "https://images.unsplash.com/photo-1550745165-9bc0b252726f?q=80&w=1200", // Code Maze
            tags: ["Flutter", "Dart", "Firebase", "Game Dev"],
            description: "An interactive mobile puzzle game built with Flutter. Features complex algorithms for maze generation and a sleek, native UI.",
            category: "Mobile",
            link: "https://github.com/openaifyp-prog/NyxCodes/tree/main/codemaze",
            hasCaseStudy: true
        },
        {
            id: "coin-pulse",
            title: "CoinPulse - Crypto Dashboard",
            image: "https://images.unsplash.com/photo-1518546305927-5a555bb7020d?q=80&w=1200", // Coin Pulse
            tags: ["JS", "Chart.js", "API", "Fintech"],
            description: "A professional crypto dashboard featuring live Bitcoin prices, interactive Chart.js graphs, and market trending data fetched from CoinGecko.",
            category: "Web",
            link: "Projects/CoinPulse/index.html",
            hasCaseStudy: true
        },
        {
            id: "nexus-news",
            title: "Nexus News Aggregator",
            image: "https://images.unsplash.com/photo-1504711434969-e33886168f5c?q=80&w=1200", // Nexus News
            tags: ["JS", "News API", "Tailwind", "Editorial"],
            description: "A daily auto-updating news blog. Features category filtering, instant search, and a curated editorial layout powered by live data.",
            category: "Web",
            link: "Projects/NexusNews/index.html",
            hasCaseStudy: true
        },
        {
            id: "weather-nova",
            title: "WeatherNova 3D",
            image: "https://images.unsplash.com/photo-1534088568595-a066f410bcda?q=80&w=1200", // Weather Nova
            tags: ["Three.js", "WebGL", "API", "Glassmorphism"],
            description: "A futuristic 3D weather dashboard featuring real-time particle effects (rain, snow, clouds) and a glassmorphism UI.",
            category: "Web",
            link: "Projects/WeatherNova/index.html",
            hasCaseStudy: true
        },
    ];

    const homeProjectsGrid = document.getElementById('projects-grid');
    const allProjectsGrid = document.getElementById('all-projects-grid');

    // Helper to generate Card HTML (Updated to Premium White Design)
    const generateCardHTML = (project) => {
        // Tag Logic: Map specific tags to colors or use defaults
        const getTagColor = (tag) => {
            const lowerTag = tag.toLowerCase();
            if (['html', 'css', 'js', 'react', 'web'].some(t => lowerTag.includes(t))) return 'bg-blue-100 text-blue-800';
            if (['design', 'ui', 'ux', 'minimalist'].some(t => lowerTag.includes(t))) return 'bg-purple-100 text-purple-800';
            if (['mobile', 'flutter', 'dart'].some(t => lowerTag.includes(t))) return 'bg-orange-100 text-orange-800';
            if (['crypto', 'fintech', 'api'].some(t => lowerTag.includes(t))) return 'bg-yellow-100 text-yellow-800';
            if (['three.js', 'webgl', '3d'].some(t => lowerTag.includes(t))) return 'bg-indigo-100 text-indigo-800';
            if (['eco', 'ngo', 'non-profit'].some(t => lowerTag.includes(t))) return 'bg-green-100 text-green-800';
            return 'bg-gray-100 text-gray-800';
        };

        const tagHTML = project.tags.map(tag =>
            `<span class="px-3 py-1 rounded-full text-xs font-bold uppercase tracking-wide ${getTagColor(tag)}">${tag}</span>`
        ).join('');

        return `
            <div class="bg-white rounded-2xl overflow-hidden shadow-xl hover:-translate-y-2 transition-transform duration-300 border border-gray-100 group project-card cursor-hover reveal"
                 data-title="${project.title}" 
                 data-image="${project.image}" 
                 data-tags="${project.tags.join(',')}" 
                 data-description="${project.description}"
                 data-link="${project.link}"
                 data-category="${project.category}">

                <div class="h-64 overflow-hidden relative">
                    <img src="${project.image}" alt="${project.title}" loading="lazy"
                        class="w-full h-full object-cover group-hover:scale-110 transition-transform duration-700">
                </div>
                
                <div class="p-8">
                    <div class="flex flex-wrap gap-2 mb-4">
                        ${tagHTML}
                    </div>
                    <h3 class="text-2xl font-bold mb-3 text-gray-900">${project.title}</h3>
                    <p class="text-gray-600 leading-relaxed mb-6 line-clamp-3">${project.description}</p>
                    <div class="flex justify-between items-center">
                        <a href="${project.link}" class="inline-flex items-center text-blue-600 font-semibold hover:text-blue-700 transition-colors">
                            <svg class="w-4 h-4 mr-2" fill="none" stroke="currentColor" viewBox="0 0 24 24"><path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M10 19l-7-7m0 0l7-7m-7 7h18"></path></svg>
                            View Live
                        </a>
                        ${project.hasCaseStudy ? `
                        <a href="case-study.html?project=${project.id}" class="text-gray-400 hover:text-blue-600 transition-colors" title="View Case Study">
                            <svg class="w-6 h-6" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                                <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M9 12h6m-6 4h6m2 5H7a2 2 0 01-2-2V5a2 2 0 012-2h5.586a1 1 0 01.707.293l5.414 5.414a1 1 0 01.293.707V19a2 2 0 01-2 2z"></path>
                            </svg>
                        </a>` : ''}
                    </div>
                </div>
            </div>
        `;
    };

    // --- Refined Rendering & Filtering ---
    function displayProjects(category = 'all') {
        if (!homeProjectsGrid) return; // Only run on Home Page

        let filtered = projectsData;

        if (category !== 'all') {
            filtered = projectsData.filter(project => {
                // Match logic
                if (project.category === category) return true;
                // Fallback tag matching
                if (category === 'Web' && (project.tags.includes('React') || project.tags.includes('JS') || project.tags.includes('HTML'))) return true;
                if (category === 'Mobile' && project.tags.includes('Flutter')) return true;
                return false;
            });
        }

        // Render Top 4 of the filtered results
        // If filtering, we might want to show up to 4 matches, or all? 
        // "Recent Work" usually implies limited count. let's stick to 4 to maintain layout.
        homeProjectsGrid.innerHTML = filtered.slice(0, 4).map(generateCardHTML).join('');

        // Force opacity for immediate feedback if replacing content
        // But we rely on observers for animation usually. 
        // Since we are replacing content, observers need to re-run.

        initObserversAndListeners(homeProjectsGrid);

        // Also Init Panel for the new cards
        initDetailPanel();
    }

    function initObserversAndListeners(container) {
        // Re-initialize observers for new elements
        const newReveals = container.querySelectorAll('.reveal');
        newReveals.forEach(el => revealObserver.observe(el));

        // RE-INITIALIZE INTERACTIVITY
        initHoverLinks();
        initMagneticLinks();
    }

    // --- 7. Project Detail Panel Logic ---
    const panel = document.getElementById('project-detail-panel');
    const closeButton = document.getElementById('close-panel');
    const detailImage = document.getElementById('detail-image');
    const detailTitle = document.getElementById('detail-title');
    const detailTags = document.getElementById('detail-tags');
    const detailDescription = document.getElementById('detail-description');

    function initDetailPanel() {
        const projectCards = document.querySelectorAll('.project-card[data-title]');
        projectCards.forEach(card => {
            // Remove old listeners (cloning is a clean way to wipe listeners, but here we just re-add which is safe enough if init only once per render)
            card.onclick = () => { // using onclick property to prevent stacking listeners
                const title = card.dataset.title;
                const imageSrc = card.dataset.image;
                const tags = card.dataset.tags.split(',');
                const description = card.dataset.description;
                const link = card.dataset.link;
                const viewBtn = document.getElementById('view-project-btn');

                detailImage.src = imageSrc;
                detailTitle.textContent = title;
                detailDescription.textContent = description;

                // Update Button
                if (link && link !== 'undefined' && link !== '') {
                    viewBtn.href = link;
                    viewBtn.classList.remove('hidden');
                    viewBtn.classList.add('inline-block');

                    // Change text/style for GitHub links
                    if (link.includes('github.com')) {
                        viewBtn.textContent = 'View Source on GitHub';
                        viewBtn.classList.remove('bg-blue-600', 'hover:bg-blue-700');
                        viewBtn.classList.add('bg-gray-800', 'hover:bg-gray-900');
                    } else {
                        viewBtn.textContent = 'View Project Live';
                        viewBtn.classList.add('bg-blue-600', 'hover:bg-blue-700');
                        viewBtn.classList.remove('bg-gray-800', 'hover:bg-gray-900');
                    }
                } else {
                    viewBtn.classList.add('hidden');
                    viewBtn.classList.remove('inline-block');
                }

                detailTags.innerHTML = '';
                tags.forEach(tag => {
                    const tagEl = document.createElement('span');
                    tagEl.className = 'bg-blue-100 text-blue-800 text-sm font-medium px-3 py-1 rounded-full';
                    tagEl.textContent = tag;
                    detailTags.appendChild(tagEl);
                });

                panel.classList.add('open');
                body.classList.add('panel-open');
            };
        });
    }

    // --- 8. Project Filtering (Updated for Dynamic Home Grid) ---
    const filterBtns = document.querySelectorAll('.filter-btn');

    filterBtns.forEach(btn => {
        btn.addEventListener('click', () => {
            // Remove active class from all
            filterBtns.forEach(b => b.classList.remove('active'));
            // Add active to clicked
            btn.classList.add('active');

            const filterValue = btn.getAttribute('data-filter');
            displayProjects(filterValue);
        });
    });

    // Initial Render
    displayProjects('all');

    // --- NEW: Scroll Spy ---
    const sections = document.querySelectorAll('section[id]');

    function scrollSpy() {
        const scrollY = window.pageYOffset;

        sections.forEach(current => {
            const sectionHeight = current.offsetHeight;
            const sectionTop = current.offsetTop - 100; // Offset for navbar
            const sectionId = current.getAttribute('id');
            const navLink = document.querySelector(`nav a[href*=${sectionId}]`);

            if (navLink) {
                if (scrollY > sectionTop && scrollY <= sectionTop + sectionHeight) {
                    document.querySelectorAll('nav a').forEach(a => a.classList.remove('text-blue-600'));
                    navLink.classList.add('text-blue-600');
                    // Also for mobile menu if needed
                    // document.querySelector(`.mobile-menu-link[href*=${sectionId}]`).classList.add('text-blue-600');
                } else {
                    navLink.classList.remove('text-blue-600');
                }
            }
        });
    }

    window.addEventListener('scroll', scrollSpy);

    closeButton.addEventListener('click', (e) => {
        e.stopPropagation(); // <-- FIX: This stops the click from "falling through"
        panel.classList.remove('open');
        body.classList.remove('panel-open');
    });

    // --- 7. Mobile Menu Logic ---
    const menuToggleBtn = document.getElementById('menu-toggle-btn');
    const mobileMenu = document.getElementById('mobile-menu');
    const closeMenuBtn = document.getElementById('close-menu-btn');
    const mobileMenuLinks = document.querySelectorAll('.mobile-menu-link');

    if (menuToggleBtn && mobileMenu && closeMenuBtn) {
        menuToggleBtn.addEventListener('click', () => {
            mobileMenu.classList.remove('invisible');
            mobileMenu.classList.add('opacity-100');
            body.classList.add('panel-open'); // Re-use panel-open to stop scrolling
        });

        const closeMenu = () => {
            mobileMenu.classList.add('invisible');
            mobileMenu.classList.remove('opacity-100');
            body.classList.remove('panel-open');
        };

        closeMenuBtn.addEventListener('click', closeMenu);
        mobileMenuLinks.forEach(link => {
            link.addEventListener('click', closeMenu);
        });
    }

    // --- 9. Scroll Progress & Back to Top ---
    const scrollProgressBar = document.getElementById('scroll-progress-bar');
    const backToTopBtn = document.getElementById('back-to-top');

    window.addEventListener('scroll', () => {
        // Progress Bar
        const scrollTop = document.documentElement.scrollTop || document.body.scrollTop;
        const scrollHeight = document.documentElement.scrollHeight - document.documentElement.clientHeight;
        const scrolled = (scrollTop / scrollHeight) * 100;
        if (scrollProgressBar) {
            scrollProgressBar.style.width = `${scrolled}%`;
        }

        // Back to Top Button
        if (backToTopBtn) {
            if (window.scrollY > 500) {
                backToTopBtn.classList.add('visible');
            } else {
                backToTopBtn.classList.remove('visible');
            }
        }
    });

    if (backToTopBtn) {
        backToTopBtn.addEventListener('click', () => {
            window.scrollTo({
                top: 0,
                behavior: 'smooth'
            });
        });
    }

    // renderProjects(); // Replaced by displayProjects('all') above
});
