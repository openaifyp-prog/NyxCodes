document.addEventListener('DOMContentLoaded', () => {
    const body = document.body;

    // --- 1. Preloader ---
    const preloader = document.getElementById('preloader');
    // Reduced timeout for better LCP
    setTimeout(() => {
        preloader.classList.add('loaded');
    }, 500);

    // --- 2. Custom Cursor ---
    const cursor = document.querySelector('.cursor');
    // REMOVED: Initial selection here is now handled by functions
    let mouseX = 0, mouseY = 0;
    let cursorX = 0, cursorY = 0;

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

    const onMouseEnter = () => cursor.classList.add('cursor-grow');
    const onMouseLeave = () => cursor.classList.remove('cursor-grow');

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
            title: "Code Maze - Mobile Learning App",
            image: "images/project-codemaze.webp",
            imagePng: "images/project-codemaze.png",
            tags: ["Flutter", "Dart", "Firebase", "AI API"],
            description: "An interactive mobile app for learning to code, built with Flutter. Features lessons, quizzes, puzzles, and games. Also includes an integrated AI assistant and compiler using REST APIs.",
            category: "Mobile",
            link: "https://github.com/openaifyp-prog/codemaze" // Placeholder - Update with actual repo
        },
        {
            title: "Decora Interior Design",
            image: "images/project-news.webp", // Keeping placeholder for card consistency
            imagePng: "images/project-news.png",
            tags: ["HTML", "CSS", "JavaScript", "Design"],
            description: "A modern interior design landing page showcasing elegance and style. Features responsive layouts and a clean aesthetic.",
            category: "Design",
            link: "Projects/Decora Interior Design/DecoraInteriorDesign.html"
        },
        {
            title: "Dartar.ai Tech Website",
            image: "images/project-dartarai.webp",
            imagePng: "images/project-dartarai.png",
            tags: ["HTML", "Tailwind CSS", "JavaScript", "Tech"],
            description: "A modern and cutting-edge website for the tech startup Dartar.ai. This project was built using Tailwind CSS to create a fully responsive, pixel-perfect design that reflects their innovative brand.",
            category: "Web",
            link: "Projects/Dartar.Ai/darterAi.html"
        },
        {
            title: "Clean Africa (NGO) Landing Page",
            image: "images/project-cleanafrica.webp",
            imagePng: "images/project-cleanafrica.png",
            tags: ["HTML", "CSS", "JavaScript", "NGO"],
            description: "A professional landing page built for the Clean Africa NGO. The project focuses on clear communication, user engagement, and responsive design to support their mission and outreach.",
            category: "Web",
            link: "Projects/CleanAfrica/CleanAfrica.html"
        }
    ];

    const projectsGrid = document.getElementById('projects-grid');

    function renderProjects() {
        if (!projectsGrid) return;

        projectsGrid.innerHTML = projectsData.map((project, index) => `
            <div class="project-card magnetic-link cursor-hover reveal" 
                 data-title="${project.title}" 
                 data-image="${project.image}" 
                 data-tags="${project.tags.join(',')}" 
                 data-description="${project.description}"
                 data-link="${project.link}">

                <div class="w-full h-64 md:h-80 rounded-2xl overflow-hidden relative shadow-lg group">
                    <img src="${project.image}" alt="${project.title}" loading="lazy" width="1024" height="1024"
                        class="w-full h-full object-cover transition-transform duration-500">

                    <!-- Smooth Filter -->
                    <div class="absolute inset-0 bg-black/50 opacity-0 group-hover:opacity-100 transition-opacity duration-300 ease-in-out"></div>

                    <!-- Hover Overlay -->
                    <div class="absolute bottom-0 left-0 w-full p-6 bg-gradient-to-t from-black/60 to-transparent transition-all duration-500 ease-in-out transform translate-y-full group-hover:translate-y-0 opacity-0 group-hover:opacity-100">
                        <p class="text-gray-200">${project.tags.join(', ')}</p>
                    </div>
                </div>
                
                <div class="mt-5">
                    <h3 class="text-xl md:text-2xl font-bold text-gray-900">${project.title}</h3>
                    <p class="text-base text-gray-600">Click card for details</p>
                </div>
            </div>
        `).join('');

        // Re-initialize observers for new elements
        const newReveals = projectsGrid.querySelectorAll('.reveal');
        newReveals.forEach(el => revealObserver.observe(el));

        // Re-initialize details panel logic for new elements
        initDetailPanel();

        // RE-INITIALIZE INTERACTIVITY FOR NEW ELEMENTS
        initHoverLinks();
        initMagneticLinks();
    }

    // Call render immediately
    // renderProjects called at the end to ensure all dependencies are init

    // --- 7. Project Detail Panel Logic (Modified to be callable) ---
    const panel = document.getElementById('project-detail-panel');
    const closeButton = document.getElementById('close-panel');
    const detailImage = document.getElementById('detail-image');
    const detailTitle = document.getElementById('detail-title');
    const detailTags = document.getElementById('detail-tags');
    const detailDescription = document.getElementById('detail-description');

    function initDetailPanel() {
        const projectCards = document.querySelectorAll('.project-card[data-title]');
        projectCards.forEach(card => {
            // Remove old listeners to prevent duplicates if re-running (not strictly necessary with innerHTML replace but good practice)
            // simple addEventListener is fine here as elements are fresh
            card.addEventListener('click', () => {
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
            });
        });
    }

    // --- 8. Project Filtering (Updated) ---
    const filterBtns = document.querySelectorAll('.filter-btn');
    // Note: allProjects needs to be queried AFTER render

    filterBtns.forEach(btn => {
        btn.addEventListener('click', () => {
            const allProjects = document.querySelectorAll('.project-card'); // Query fresh elements

            // Remove active class from all
            filterBtns.forEach(b => b.classList.remove('active'));
            // Add active to clicked
            btn.classList.add('active');

            const filterValue = btn.getAttribute('data-filter');

            allProjects.forEach(card => {
                if (filterValue === 'all') {
                    card.style.display = 'block';
                    setTimeout(() => card.style.opacity = '1', 50);
                } else {
                    const tags = card.getAttribute('data-tags');
                    // Check against categories or specific tags.
                    // Data logic: 'Web' matches tags like React, Node, HTML. 'Mobile' matches Flutter. 'Design' matches generic?
                    // Let's refine the logic to match the previous behavior or use explicit categories in data.
                    // For now, simple tag matching:
                    let isMatch = false;
                    if (filterValue === 'Web' && (tags.includes('React') || tags.includes('HTML') || tags.includes('Node'))) isMatch = true;
                    if (filterValue === 'Mobile' && tags.includes('Flutter')) isMatch = true;
                    if (filterValue === 'Design' && tags.includes('Tailwind')) isMatch = true; // Heuristic based on existing content

                    if (isMatch) {
                        card.style.display = 'block';
                        setTimeout(() => card.style.opacity = '1', 50);
                    } else {
                        card.style.opacity = '0';
                        setTimeout(() => card.style.display = 'none', 300); // Wait for transition
                    }
                }
            });
        });
    });

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

    renderProjects();
});
