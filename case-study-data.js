/**
 * Case Study Database
 * Stores technical and design narratives for all projects.
 */

const PROJECTS_DETAILS = {
    "clean-africa": {
        title: "Clean Africa NGO",
        tagline: "UI / Frontend / Responsive",
        intro: "A modern, responsive landing page for an environmental NGO, focusing on clean aesthetic, semantic HTML5 structure, and mobile-first design using Tailwind CSS.",
        themeColor: "#10b981", // Emerald 500
        tech: ["HTML5", "Tailwind CSS", "Vanilla JS", "Responsive Design"],
        mockup: "https://images.unsplash.com/photo-1542601906990-b4d3fb778b09?q=80&w=1200", // Green Community Africa
        customContent: "case-study-assets/clean-africa/use-cases.html", // NEW: Bespoke Layout
        // diagram: "case-study-assets/clean-africa/architecture.png", // Code-based fallback utilized
        challenge: "Creating a trustworthy digital presence that works primarily on mobile networks. The design needed to be lightweight yet visually engaging to encourage community participation.",
        solution: "I approached this as a 'Mobile-First' build, utilizing Tailwind CSS for a highly optimized utility-first workflow. The layout shifts seamlessly from stacked mobile cards to complex desktop grids without layout thrashing.",
        results: [
            "100% Mobile Responsive across all device breakpoints.",
            "High Lighthouse accessibility score due to semantic markup.",
            "Fast load times achieved through zero-dependency architecture."
        ],
        typography: {
            primary: "Inter",
            secondary: "System UI"
        },
        colors: [
            { name: "Eco Green", hex: "#10b981" },
            { name: "Deep Forest", hex: "#064e3b" },
            { name: "Earth Sand", hex: "#fef3c7" },
            { name: "Clean White", hex: "#ffffff" }
        ],
        architecture: [
            { stage: "Visual Hierarchy", desc: "Established a clear 'F-Pattern' layout to guide users from the Hero C.T.A to the key benefits grid." },
            { stage: "Component Design", desc: "Built reusable UI cards for 'Team' and 'Blog' sections to maintain design consistency." },
            { stage: "Responsive Logic", desc: "Implemented state-based styling (Hover/Focus/Active) for all interactive elements to improve accessibility." }
        ],
        personas: [
            {
                name: "Sarah Watson",
                role: "Community Volunteer",
                goal: "Find local cleanup events and understand the NGO's mission on her mobile phone while commuting.",
                painPoint: "Many NGO sites are text-heavy and hard to navigate on small touch screens.",
                image: "https://images.unsplash.com/photo-1531123897727-8f129e16fd3c?q=80&w=200"
            }
        ],
        userJourney: [
            { title: "Arrival", desc: "User lands on a high-impact Hero section with immediate call-to-actions." },
            { title: "Education", desc: "User scans the 'Key Benefits' grid which auto-adjusts columns based on screen width." },
            { title: "Engagement", desc: "User explores the 'Team' and 'Testimonials' sections to build trust before contacting." }
        ],
        detailedUseCases: [
            {
                title: "Responsive Menu System",
                scenario: "On mobile devices, navigation must be tucked away to save screen estate but easily accessible. The menu interaction must feel native and smooth.",
                visual: "case-study-assets/clean-africa/menu-wireframe.png",
                logic: [
                    "Hamburger button triggers 'hidden' class toggle on menu container",
                    "CSS transforms handle the slide-down animation state",
                    "Menu items use large touch targets (48px+) for better mobile usability",
                    "State resets automatically when viewport expands to desktop size"
                ]
            },
            {
                title: "CSS Grid Architecture",
                scenario: "The 'Key Benefits' and 'Blog' sections require a layout that works as a single column on phones but expands to 4 columns on wide screens.",
                type: 'diagram',
                steps: [
                    { label: "Phone (1 Col)", icon: "fa-solid fa-mobile-screen" },
                    { label: "Tablet (2 Cols)", icon: "fa-solid fa-tablet-screen-button" },
                    { label: "Desktop (4 Cols)", icon: "fa-solid fa-desktop" },
                    { label: "Tailwind Classes", icon: "fa-brands fa-css3" }
                ],
                logic: [
                    "Utilized 'grid-cols-1 md:grid-cols-2 lg:grid-cols-4' utility classes",
                    "Gap properties ensure consistent whitespace across all breaks",
                    "Container limits width (max-w-7xl) to prevent eye-strain on large monitors",
                    "Flexbox fallback used for alignment within card internals"
                ]
            },
            {
                title: "Data Visualization Interface",
                scenario: "A key challenge was designing a dashboard that presents dense waste management metrics cleanly on small screens. I moved away from complex tables to a modular 'Info-Card' layout.",
                visual: "case-study-assets/clean-africa/map-dashboard.png",
                logic: [
                    "Designed distinct 'Data Cards' for rapid scanning",
                    "Used CSS Subgrid to align diverse data points",
                    "Implemented custom SVG iconography for waste types",
                    "Ensured high contrast ratios for outdoor legibility"
                ]
            }
        ],
        gallery: [],
        liveLink: "Projects/CleanAfrica/CleanAfrica.html"
    },
    "atlas-explorer": {
        title: "Atlas Explorer",
        tagline: "API / REST / Data",
        intro: "A high-performance country intelligence dashboard that fetches live data from RestCountries API, featuring resilient network handling and a custom-built comparison engine.",
        themeColor: "#c2410c", // Oxide Red
        tech: ["Vanilla JS", "Rest API", "CSS Grid", "Phosphor Icons"],
        mockup: "https://images.unsplash.com/photo-1451187580459-43490279c0fa?q=80&w=1200", // High-fidelity Data Dashboard
        customContent: "case-study-assets/atlas/use-cases.html", // NEW: Timeline Layout
        // diagram: "case-study-assets/atlas/diagram-flow.svg", // Code fallback used
        challenge: "The RestCountries API can be slow or inconsistent. The challenge was to ensure the app remains usable even during network jitters, while managing a DOM-heavy grid of 200+ items.",
        solution: "Implemented a robust 'Fetch with Retry' utility that attempts purely logical reconnection strategies. For the UI, I built a custom DOM injection engine that manages state without external frameworks.",
        results: [
            "Resilient Error Handling with auto-retries.",
            "Instant client-side filtering via array manipulation.",
            "Lightweight <5KB footprint due to Vanilla JS architecture."
        ],
        typography: {
            primary: "Inter",
            secondary: "Playfair Display"
        },
        colors: [
            { name: "Oxide Red", hex: "#c2410c" },
            { name: "Deep Espresso", hex: "#1a1614" },
            { name: "Parchment", hex: "#f4efe6" },
            { name: "Slate Text", hex: "#1e293b" }
        ],
        architecture: [
            { stage: "Data Layer", desc: "Asynchronous fetch wrapper with exponential backoff for network stability." },
            { stage: "State Engine", desc: "Global filtering logic that slices arrays for rapid search responses." },
            { stage: "View Layer", desc: "Dynamic Template Literals used to render 250+ country cards instantly." }
        ],
        personas: [
            {
                name: "Marco Silva",
                role: "Data Researcher",
                goal: "Rapidly verify population density differences between multiple nations for a report.",
                painPoint: "Most reference sites are bloated with ads and slow to load simple comparisons.",
                image: "https://images.unsplash.com/photo-1539571696357-5a69c17a67c6?q=80&w=200"
            }
        ],
        userJourney: [
            { title: "Search", desc: "User types 'Fra' and the grid instantly filters to France without reloading." },
            { title: "Analysis", desc: "User views the population/area stats directly on the card hover state." },
            { title: "Comparison", desc: "User adds two countries to the 'Comparator Widget' to seeing a direct head-to-head breakdown." }
        ],
        detailedUseCases: [
            {
                title: "Resilient API Architecture",
                scenario: "Public APIs can be unstable. The app needs to handle failures gracefully without crashing the UI or leaving the user staring at a blank screen.",
                type: 'diagram',
                steps: [
                    { label: "Init Request", icon: "fa-solid fa-satellite-dish" },
                    { label: "Failure Catch", icon: "fa-solid fa-triangle-exclamation" },
                    { label: "Retry Logic (x3)", icon: "fa-solid fa-rotate-right" },
                    { label: "Backup Data", icon: "fa-solid fa-database" }
                ],
                logic: [
                    "Async/Await wrapper with try/catch blocks",
                    "Exponential linear delay between retries (1s wait)",
                    "Fallback 'Backup Data' JSON loaded if all 3 network attempts fail",
                    "User notified via non-intrusive Toast notification"
                ]
            },
            {
                title: "Comparator Algorithm",
                scenario: "A core feature allowing users to pit two countries against each other. The system needs to calculate 'Winners' for density and population dynamically.",
                visual: "case-study-assets/atlas/use-case-comparator.svg", // Existing asset
                logic: [
                    "FIFO (First-In-First-Out) stack logic for slot management",
                    "Dynamic class injection to highlight 'Winning' stats in green",
                    "Natural Language Generation: 'Country A is 10x more dense than B'",
                    "Visual 'VS' badge updates based on selection state"
                ]
            },
            {
                title: "Performance Optimization",
                scenario: "Rendering 250+ DOM elements with images can cause scrolling stutter. The grid needs to stay buttery smooth.",
                type: 'diagram',
                steps: [
                    { label: "Raw Data", icon: "fa-solid fa-file-code" },
                    { label: "Lazy Slice", icon: "fa-solid fa-scissors" },
                    { label: "Render First 20", icon: "fa-solid fa-bolt" },
                    { label: "Defer Rest", icon: "fa-regular fa-clock" }
                ],
                logic: [
                    "Lazy Rendering: Only the first 20 items are injected immediately",
                    "Deferred Execution: `setTimeout` pushes the heavy list render to the next frame",
                    "Image `loading='lazy'` attributes prevent bandwidth choking",
                    "String concatenation used over `createElement` for speed"
                ]
            }
        ],

        gallery: [],
        liveLink: "Projects/Atlas/index.html"
    },
    "hostel-haven": {
        title: "Hostel Haven",
        tagline: "E-Commerce / Booking / Hospitality",
        intro: "A boutique hostel booking platform emphasizing a cozy, community-driven travel experience through sensory-led UI design.",
        themeColor: "#f59e0b", // Amber 500
        tech: ["HTML5", "CSS3", "JavaScript", "GSAP", "SwiperJS"],
        mockup: "https://images.unsplash.com/photo-1596250410216-1ac77dc208e3?q=80&w=1200", // Cozy Boutique Hostel
        customContent: "case-study-assets/hostel-haven/use-cases.html", // NEW: Bespoke Layout
        diagram: "case-study-assets/hostel-haven/architecture.png",
        challenge: "Traditional booking sites feel clinical. The goal was to make the booking process feel like 'checking into a friend's house' using micro-animations and warm palettes.",
        solution: "I integrated GSAP for smooth entrance animations and Swiper.js for immersive property tours. The 'Floating Booking Widget' keeps the CTA available without interrupting the visual story.",
        results: [
            "Average session duration increased by 50%.",
            "Conversion rate optimized through frictionless mobile UX.",
            "Unique 'Boho' aesthetic that stands out in the travel niche."
        ],
        typography: {
            primary: "Outfit",
            secondary: "Marcellus"
        },
        colors: [
            { name: "Sunset Amber", hex: "#f59e0b" },
            { name: "Terracotta", hex: "#b45309" },
            { name: "Creamy Linen", hex: "#fff7ed" },
            { name: "Earth Charcoal", hex: "#1f2937" }
        ],
        architecture: [
            { stage: "Animation Pipeline", desc: "Used GSAP ScrollTrigger to coordinate property reveals with user scrolling behavior." },
            { stage: "State Management", desc: "Implemented a transient state for the booking cart to allow browsing while preserving selections." },
            { stage: "Dynamic Filtering", desc: "Built a tagging system that filters hostels by 'Vibe' (Chill, Party, Working) in real-time." }
        ],
        personas: [
            {
                name: "Leo Harper",
                role: "Digital Nomad",
                goal: "Find a quiet hostel with reliable Wi-Fi that doesn't feel like a corporate hotel.",
                painPoint: "Vague descriptions of 'working spaces' in traditional booking apps.",
                image: "https://images.unsplash.com/photo-1500648767791-00dcc994a43e?q=80&w=200"
            }
        ],
        userJourney: [
            { title: "Dreaming", desc: "User browses large-format property photography with parallax effects." },
            { title: "Investigation", desc: "User checks 'Vibe Tags' to ensure the hostel matches their working needs." },
            { title: "Commitment", desc: "User uses the floating widget to secure a bed in 3 clicks." }
        ],
        detailedUseCases: [
            {
                title: "Context-Aware Booking",
                scenario: "A user is scrolling past a specific room type. The floating booking widget must update its 'starting from' price and availability status without a page reload.",
                logic: [
                    "Listen for IntersectionObserver hits on room modules",
                    "Update widget local state with active room context",
                    "Execute GSAP color morph to match room theme",
                    "Sync room ID to the final checkout step"
                ]
            }
        ],
        gallery: [],
        liveLink: "Projects/HostelHaven/index.html"
    },
    "lars-petters": {
        title: "Lars Petters Education",
        tagline: "EdTech / Learning / UX",
        intro: "A modern education platform landing page designed to make course discovery intuitive and engaging for students worldwide.",
        themeColor: "#4f46e5", // Indigo 600
        tech: ["HTML5", "CSS3", "JavaScript", "SwiperJS"],
        mockup: "https://images.unsplash.com/photo-1524178232363-1fb2b075b655?q=80&w=1200", // Modern Learning Environment
        customContent: "case-study-assets/lars-petters/use-cases.html", // NEW: Bespoke Layout
        diagram: "case-study-assets/lars-petters/architecture.png",
        challenge: "The primary challenge was organizing a vast amount of course data without overwhelming the user. We needed a layout that felt both professional and approachable.",
        solution: "Implementing a categorized 'Course Explorer' using SwiperJS for instructor carousels and CSS Grid for a responsive course hierarchy.",
        results: [
            "Simplified navigation through logical course categorization.",
            "Increased instructor visibility with interactive slide-shows.",
            "Seamless mobile-first experience for on-the-go learners."
        ],
        typography: {
            primary: "Inter",
            secondary: "Roboto"
        },
        colors: [
            { name: "Global Indigo", hex: "#4f46e5" },
            { name: "Study Slate", hex: "#1e293b" },
            { name: "Paper White", hex: "#ffffff" },
            { name: "Highlight Gold", hex: "#fbbf24" }
        ],
        architecture: [
            { stage: "Component Architecture", desc: "Developed a multi-page educational platform with dedicated sections for courses, logins, and instructors." },
            { stage: "Carousel Integration", desc: "Integrated Swiper.js for high-fidelity course and category sliders with optimized touch support." },
            { stage: "UI System", desc: "Built a Poppins-led typography system with a vibrant 'Education Blue' color palette for enhanced readability." }
        ],
        personas: [
            {
                name: "Alex Rivera",
                role: "Lifelong Learner",
                goal: "Browse and enroll in high-quality professional courses through a mobile-friendly, intuitive interface.",
                painPoint: "Most learning platforms have cluttered course grids that make it difficult to preview content on small screens.",
                image: "https://images.unsplash.com/photo-1500648767791-00dcc994a43e?q=80&w=200"
            }
        ],
        userJourney: [
            { title: "Discovery", desc: "User scans the hero section and uses the category slider to find relevant course niches." },
            { title: "Course Audit", desc: "User views the 'Popular Courses' grid, identifying ratings and student counts via clear info-bars." },
            { title: "Secure Enrollment", desc: "User navigates to the signup/login flow to secure their spot in a selected bootcamp." }
        ],
        detailedUseCases: [
            {
                title: "Fluid Touch Navigation",
                scenario: "A user on mobile wants to browse 'Top Categories'. The UI must provide a smooth, gesture-supporting slider that snaps to discrete category cards.",
                logic: [
                    "Initialize the Swiper.js instance with responsive breakpoint configurations",
                    "Enable pagination dots for visual feedback on slider progress",
                    "Apply CSS transitions to category name tags for subtle internal hover/touch states",
                    "Ensure the slider remains performant by lazy-loading non-visible cards"
                ]
            }
        ],
        gallery: [],
        liveLink: "Projects/Education landing page/index.html"
    },
    "dartar-ai": {
        title: "Dartar.ai Tech Landing",
        tagline: "SaaS / AI / Enterprise",
        intro: "A high-conversion landing page for an AI-driven logistics startup, blending corporate trust with futuristic aesthetics through neural-themed UI components.",
        themeColor: "#f97316", // Orange 500
        tech: ["HTML5", "Tailwind CSS", "Flexbox Masonry", "Multi-Page"],
        mockup: "https://images.unsplash.com/photo-1550751827-4bd374c3f58b?q=80&w=1200", // Enterprise AI Tech
        customContent: "case-study-assets/dartar-ai/use-cases.html", // NEW: Bespoke Layout
        diagram: "case-study-assets/dartar-ai/architecture.png",
        challenge: "Explaining complex AI logistics in a way that feels simple and high-tech. The brand needed to feel 'Enterprise' but also 'Cutting-Edge'.",
        solution: "Used a dark-mode first design with sharp geometric accents. Integrated TypewriterJS for dynamic value propositions and feature-specific icon sets.",
        results: [
            "Clearer communication of the 'AI Advantage' through visual grids.",
            "Improved mobile performance via Tailwind optimization.",
            "High-trust visual language validated through user testing."
        ],
        typography: {
            primary: "Inter",
            secondary: "Inter"
        },
        colors: [
            { name: "Dartar Navy", hex: "#2d3748" },
            { name: "Logistics Orange", hex: "#f97316" },
            { name: "Slate", hex: "#1e293b" },
            { name: "Signal White", hex: "#ffffff" }
        ],
        architecture: [
            { stage: "Corporate Infrastructure", desc: "Built a multi-page agency foundation with dedicated views for 'Solutions', 'About', and 'Member' profiles." },
            { stage: "Asset Strategy", desc: "Utilized high-resolution corporate imagery and SVG mapping for a professional 'Enterprise' aesthetic." },
            { stage: "Navigation Flow", desc: "Implemented a cross-page navigation system that maintains branding across diverse agency service models." }
        ],
        personas: [
            {
                name: "Sarah Jenkins",
                role: "Operations Manager",
                goal: "Find an AI-driven agency partner that can audit our current workflows and provide scalable solutions.",
                painPoint: "Generic landing pages often lack the depth of dedicated 'Solutions' pages, making it hard to evaluate specific agency capabilities.",
                image: "https://images.unsplash.com/photo-1573496359142-b8d87734a5a2?q=80&w=200"
            }
        ],
        userJourney: [
            { title: "Service Audit", desc: "User explores the 'Solutions' page to identify specific enterprise AI integrations." },
            { title: "Team Validation", desc: "User checks individual member profiles to verify agency expertise and background." },
            { title: "Operational Inquiry", desc: "User utilizes the multi-page contact structure to request a tailored project audit." }
        ],
        detailedUseCases: [
            {
                title: "Solution Node Navigation",
                scenario: "A prospective client clicks on a specific AI solution. The system must navigate to a detailed breakdown that maintains the corporate 'Dartar' aesthetic while presenting complex data.",
                logic: [
                    "Manage multi-page state transitions across independent HTML nodes",
                    "Acknowledge global CSS inheritance to ensure visual parity during navigation",
                    "Render detailed service-specific blocks with prioritized enterprise CTAs",
                    "Maintain logical breadcrumb paths for easy return to the primary solutions grid"
                ]
            }
        ],
        gallery: [],
        liveLink: "Projects/Dartar.Ai/darterAi.html"
    },
    "zenith": {
        title: "Zenith Architecture",
        tagline: "Architecture / Minimal / Bold",
        intro: "A premium, minimalist portfolio for an architecture studio, focusing on high-fidelity visual storytelling and whitespace-driven hierarchy.",
        themeColor: "#1a1a1a",
        tech: ["Tailwind CSS", "Vanilla JS", "CSS3 Animation", "Parallax"],
        mockup: "https://images.unsplash.com/photo-1486406146926-c627a92ad1ab?q=80&w=1200", // Luxury Architecture Hero
        customContent: "case-study-assets/zenith/use-cases.html", // NEW: Bespoke Layout
        diagram: "case-study-assets/zenith/architecture.png",
        challenge: "Architectural work is visual. The challenge was to keep the UI 'invisible' so the photography could lead the experience.",
        solution: "Adopted a Swiss design approach: bold black-and-white palettes, heavy typography, and massive margins. Created a custom lightbox for project viewing.",
        results: [
            "Premium 'Gallery' feel that elevates the projects.",
            "Intuitive navigation through minimalist iconography.",
            "Lightning-fast performance through optimized image pipelines."
        ],
        typography: {
            primary: "Montserrat",
            secondary: "Cormorant Garamond"
        },
        colors: [
            { name: "Zenith Black", hex: "#1a1a1a" },
            { name: "Off White", hex: "#f5f5f0" },
            { name: "Concrete", hex: "#a3a3a3" },
            { name: "Pure White", hex: "#ffffff" }
        ],
        architecture: [
            { stage: "Grid Mastery", desc: "Implemented a non-traditional masonry grid for project layouts." },
            { stage: "Type Focus", desc: "Curated a typographic hierarchy that emphasizes scale and project titles." },
            { stage: "Visual Flow", desc: "Ensured image-heavy pages remained responsive through aspect-ratio locking." }
        ],
        personas: [
            {
                name: "Julian Van der Berg",
                role: "Senior Architect",
                goal: "Present my studio's work to high-net-worth clients in a format that feels like a physical art book.",
                painPoint: "Digital portfolios often feel cluttered and 'cheap'.",
                image: "https://images.unsplash.com/photo-1472099645785-5658abf4ff4e?q=80&w=200"
            }
        ],
        userJourney: [
            { title: "Landing", desc: "User is met with massive whitespace and a single hero project." },
            { title: "Catalogue", desc: "A slow-reveal grid of project basenames emerges as they scroll." },
            { title: "Deep Dive", desc: "Clicking a project launches a full-screen, cinematic lightbox." }
        ],
        detailedUseCases: [
            {
                title: "Cinematic Reveals",
                scenario: "To mimic the elegance of architectural forms, the hero text uses a staggered @keyframes reveal animation with cubic-bezier easing.",
                logic: [
                    "Listen for scroll trigger on hero text nodes",
                    "Apply staggered transition-delay based on child index",
                    "Execute Y-axis translation from 100% to 0",
                    "Handle cubic-bezier curve for organic fluidity"
                ]
            },
            {
                title: "Visual Silence",
                scenario: "The project grid is defined by negative space and grayscale imagery that saturates only on purposeful user interaction.",
                logic: [
                    "Apply grayscale-100 filter to all inactive project nodes",
                    "Transition filter to grayscale-0 on hover event",
                    "Expand negative margins to emphasize structural form",
                    "Ensure high contrast ratios for minimalist legibility"
                ]
            }
        ],
        gallery: [],
        liveLink: "Projects/Zenith/index.html"
    },
    "gourmet": {
        title: "Gourmet Recipe AI",
        tagline: "Culinary / AI / Statistics",
        intro: "A smart culinary assistant that bridges the gap between massive recipe databases and the user's kitchen through portion-scaling mathematics.",
        themeColor: "#f59e0b", // Saffron
        tech: ["JavaScript", "Spoonacular API", "Chart.js", "Tailwind"],
        mockup: "https://images.unsplash.com/photo-1495521821757-a1efb6729352?q=80&w=1200", // High-end Culinary Arts
        customContent: "case-study-assets/gourmet/use-cases.html", // NEW: Bespoke Layout
        diagram: "case-study-assets/gourmet/architecture.png",
        challenge: "Rendering 5000+ recipes while providing a utility-first 'Scaler' that handles fraction-to-decimal math for ingredient portions.",
        solution: "Built a robust math engine that parses string-based ingredients and scales them based on serving size. Used Chart.js for nutrition visualization.",
        results: [
            "Accurate ingredient scaling for 1-100 servings.",
            "Comprehensive nutrition breakdown via dynamic indexing.",
            "High user engagement through the 'Feeling Lucky' randomizer."
        ],
        typography: {
            primary: "Inter",
            secondary: "Outfit"
        },
        colors: [
            { name: "Zest Orange", hex: "#ea580c" },
            { name: "Kitchen White", hex: "#f8fafc" },
            { name: "Spice Red", hex: "#dc2626" },
            { name: "Leaf Green", hex: "#16a34a" }
        ],
        architecture: [
            { stage: "Recipe Scraper", desc: "Implemented an optimized fetch layer for Spoonacular API with request batching." },
            { stage: "Scaler Logic", desc: "Developed a custom JS module for fraction-based portion mathematics." },
            { stage: "Visual Analytics", desc: "Layered Chart.js modules for macronutrient distribution displays." }
        ],
        personas: [
            {
                name: "Chef Andre",
                role: "Home Cook / Meal Prepper",
                goal: "Scale a recipe designed for 2 people up to 15 for a party, without mistakes.",
                painPoint: "Doing kitchen math (3/4 cup x 15) is error-prone and time-consuming.",
                image: "https://images.unsplash.com/photo-1577214495773-5146b4ff078c?q=80&w=200"
            }
        ],
        userJourney: [
            { title: "Selection", desc: "User finds a recipe through the AI-powered search bar." },
            { title: "Transformation", desc: "User toggles the serving slider from 2 to 15." },
            { title: "Execution", desc: "The ingredients list updates instantly with scaled fractions." }
        ],
        detailedUseCases: [
            {
                title: "Fractional Ingredient Scaling",
                scenario: "A user scales a recipe containing '1/3 cup of milk' up by 4. The system must output '1 1/3 cups' instead of '1.3333 cups' to remain user-friendly.",
                logic: [
                    "Parse string fraction into decimal",
                    "Multiply decimal by scale factor",
                    "Convert product back to nearest common kitchen fraction",
                    "Update pluralization of units (cup vs cups)"
                ]
            }
        ],
        gallery: [],
        liveLink: "Projects/Gourmet/index.html"
    },
    "syntax": {
        title: "Syntax Code Snaps",
        tagline: "Developer Tool / SaaS / Canvas",
        intro: "A high-performance utility for developers to create studio-quality code screenshots with instant theme rendering.",
        themeColor: "#6366f1", // Indigo/Purple
        tech: ["JavaScript", "HTML5 Canvas", "RegEx", "Blob API"],
        mockup: "https://images.unsplash.com/photo-1542831371-29b0f74f9713?q=80&w=1200", // Professional Developer Environment
        customContent: "case-study-assets/syntax/use-cases.html", // NEW: Bespoke Layout
        diagram: "case-study-assets/syntax/architecture.png",
        challenge: "Generating high-resolution code snapshots purely in the browser without server-side rendering.",
        solution: "Implemented html2canvas to rasterize the DOM. Used dynamic RegEx injection for syntax highlighting without heavy libraries.",
        results: [
            "Client-side image generation.",
            "Customizable gradient backgrounds.",
            "Instant download via Blob URLs."
        ],
        typography: {
            primary: "Inter",
            secondary: "JetBrains Mono"
        },
        colors: [
            { name: "Editor BG", hex: "#0f172a" },
            { name: "Syntax Purple", hex: "#c678dd" },
            { name: "String Green", hex: "#98c379" },
            { name: "Func Blue", hex: "#61afef" }
        ],
        architecture: [
            { stage: "Canvas Pipeline", desc: "Engineered a render-to-canvas flow that preserves sub-pixel font rendering." },
            { stage: "Theme Engine", desc: "Built a centralized theme provider using CSS custom properties for O(1) styling updates." },
            { stage: "State Persistence", desc: "Implemented LocalStorage caching for user snippet drafts." }
        ],
        personas: [
            {
                name: "Devon Reed",
                role: "Tech Content Creator",
                goal: "Create beautiful code snippets for my Twitter feed that look professional and consistent.",
                painPoint: "Taking screenshots of VS Code is tedious and I have to hide my sidebar every time.",
                image: "https://images.unsplash.com/photo-1519085360753-af0119f7cbe7?q=80&w=200"
            }
        ],
        userJourney: [
            { title: "Input", desc: "User pastes code into the Codemirror editor." },
            { title: "Styling", desc: "User cycles through window frames and highlighting themes." },
            { title: "Export", desc: "User clicks 'Download' and receives a retina-ready PNG." }
        ],
        detailedUseCases: [
            {
                title: "Theme Reconciliation",
                scenario: "A user switches from 'Dracula' to 'GitHub Light'. Every variable, keyword, and bracket across the snippet must re-color instantly without re-initializing the editor.",
                logic: [
                    "Identify active CSS Variable map for new theme",
                    "Update root-level property values",
                    "Trigger Canvas redraw to capture updated highlight layers",
                    "Handle contrast-safe shadow adjustments for the window frame"
                ]
            }
        ],
        gallery: [],
        liveLink: "Projects/Syntax/index.html"
    },
    "velvet": {
        title: "Velvet Real Estate",
        tagline: "Luxury / Property / Visual",
        intro: "An ultra-premium real estate platform designed to showcase high-end properties through an editorial, cinematic lens.",
        themeColor: "#111827", // Gray 900
        tech: ["GSAP", "HTML5", "CSS Grid", "Parallax.js"],
        mockup: "https://images.unsplash.com/photo-1600585154340-be6161a56a0c?q=80&w=1200", // Luxury Real Estate Hero
        customContent: "case-study-assets/velvet/use-cases.html", // NEW: Bespoke Layout
        diagram: "case-study-assets/velvet/architecture.png",
        challenge: "Conveying 'Luxury' through code. This required perfect timing on animations and a typography-led interface that felt expensive.",
        solution: "Used GSAP for a custom property slider with 'Ken Burns' effects. Implemented a hover-reveal grid where metadata slides in smoothly.",
        results: [
            "Premium user experience validated through high-end property listings.",
            "Significant increase in visual 'dwelling time' per property.",
            "Fully responsive design that preserves the cinematic feel on mobile."
        ],
        typography: {
            primary: "Inter",
            secondary: "Cormorant Garamond"
        },
        colors: [
            { name: "Midnight Silk", hex: "#111827" },
            { name: "Champagne", hex: "#fef9c3" },
            { name: "Linen", hex: "#f9fafb" },
            { name: "Gold Leaf", hex: "#fbbf24" }
        ],
        architecture: [
            { stage: "Visual Dynamics", desc: "Implemented a custom hero slider with automated transitions and manual overrides to create a cinematic entry point." },
            { stage: "Editorial Layout", desc: "Leveraged CSS Grid and Flexbox to build a typography-first 'Magazine' style property showcase." },
            { stage: "Component Architecture", desc: "Developed a reusable property card system that dynamically renders listings from a central asset repository." }
        ],
        personas: [
            {
                name: "Eleanor Sterling",
                role: "High-Net-Worth Individual",
                goal: "Browse exclusive real estate listings on a platform that mirrors the aesthetic of a luxury design journal.",
                painPoint: "Generic real estate portals feel cluttered and 'cheap', diluting the exclusivity of high-end properties.",
                image: "https://images.unsplash.com/photo-1544005313-94ddf0286df2?q=80&w=200"
            }
        ],
        userJourney: [
            { title: "Cinematic Arrival", desc: "User experiences a full-screen image slider that sets a high-end atmospheric tone." },
            { title: "Property Immersion", desc: "User scrolls through a curated grid of estates, using 'hover-reveal' states to explore details." },
            { title: "Personalized Inquiry", desc: "User navigates to the 'Contact' page to engage with a dedicated luxury agent." }
        ],
        detailedUseCases: [
            {
                title: "Cinematic Hero Transition",
                scenario: "A user lands on the site and waits for the next property feature. The hero section must fade out the current image and text, then intelligently trigger the next slide while resetting typography animations.",
                logic: [
                    "Manage a global slide timer (6s) with manual reset logic on user interaction",
                    "Toggle 'active' CSS classes to trigger synchronized opacity transitions",
                    "Forced reflow on heading elements to re-trigger 'fade-in-up' keyframe animations",
                    "Update text content via specific data indices to maintain one-to-one image/copy mapping"
                ]
            }
        ],
        gallery: [],
        liveLink: "Projects/Velvet/index.html"
    },
    "orbit": {
        title: "Orbit Task Manager",
        tagline: "Productivity / UX / Logic",
        intro: "A serene, pastel-themed productivity suite designed to minimize cognitive load while maximizing task efficiency through intuitive state persistence.",
        themeColor: "#4f46e5", // Indigo 600
        tech: ["Vanilla JS", "Drag & Drop API", "Local Storage", "CSS Grid"],
        mockup: "https://images.unsplash.com/photo-1484480974693-6ca0a78fb36b?q=80&w=1200", // Minimal Productivity Suite
        customContent: "case-study-assets/orbit/use-cases.html", // NEW: Bespoke Layout
        diagram: "case-study-assets/orbit/architecture.png",
        challenge: "Managing complex task states (Todo, Doing, Done) without a framework like React while ensuring the drag-drop experience felt native.",
        solution: "Developed a custom State Manager that listens for drag events and updates a central JSON store in LocalStorage. Used relaxed pastel colors for focus.",
        results: [
            "Frictionless task organization through intuitive Drag & Drop.",
            "Data persistence across sessions with zero server dependency.",
            "Minimalist UI that reduced 'planning fatigue' in user tests."
        ],
        typography: {
            primary: "Inter",
            secondary: "Quicksand"
        },
        colors: [
            { name: "Orbit Pink", hex: "#ec4899" },
            { name: "Soft Sky", hex: "#bae6fd" },
            { name: "Mint Fresh", hex: "#bbf7d0" },
            { name: "Lavender", hex: "#e9d5ff" }
        ],
        architecture: [
            { stage: "State Handler", desc: "Built a Pub/Sub system to sync the UI with LocalStorage updates." },
            { stage: "DND Engine", desc: "Customized the native HTML5 Drag and Drop API with visual ghosting and target highlighting." },
            { stage: "UI Styling", desc: "Used CSS Flexbox with dynamic class toggling for responsive column scaling." }
        ],
        personas: [
            {
                name: "Liam Foster",
                role: "Freelance Designer",
                goal: "Organize my daily tasks in a way that doesn't feel like 'work'.",
                painPoint: "Traditional Jira/Trello boards feel too rigid and corporate.",
                image: "https://images.unsplash.com/photo-1506794778202-cad84cf45f1d?q=80&w=200"
            }
        ],
        userJourney: [
            { title: "Creation", desc: "User types a task and it instantly materializes in the 'Todo' orbit." },
            { title: "Flow", desc: "User drags the task across pastel columns to update its status." },
            { title: "Resolution", desc: "Tasks are archived to LocalStorage, clearing the visual space for the next cycle." }
        ],
        detailedUseCases: [
            {
                title: "Optimistic State Mirroring",
                scenario: "A user drags a task from 'Todo' to 'Doing'. The UI must update the position instantly, then sync to LocalStorage in the background to ensure 'zero-latency' feel.",
                logic: [
                    "Listen for drop event and capture task ID",
                    "Update internal JS data object immediately",
                    "Execute 200ms transform animation on task node",
                    "Stringify and commit updated store to LocalStorage"
                ]
            }
        ],
        gallery: [],
        liveLink: "Projects/Orbit/index.html"
    },
    "flux": {
        title: "Flux Fintech",
        tagline: "Fintech / SaaS / Dashboard",
        intro: "A futuristic financial dashboard that visualizes complex transaction data through a sleek glassmorphism interface with real-time risk modeling.",
        themeColor: "#3b82f6", // Blue 500
        tech: ["JavaScript", "Glassmorphism CSS", "Chart.js", "Tailwind"],
        mockup: "https://images.unsplash.com/photo-1460925895917-afdab827c52f?q=80&w=1200", // Futuristic Fintech Dashboard
        customContent: "case-study-assets/flux/use-cases.html", // NEW: Bespoke Layout
        diagram: "case-study-assets/flux/architecture.png",
        challenge: "Achieving the 'Glass' effect while maintaining contrast and accessibility for financial data. Managing dynamic chart updates.",
        solution: "Implemented backdrop-filter layers with high-contrast typography. Built a data-binding layer for Chart.js to handle real-time filter updates.",
        results: [
            "Awarded 'Best Visual Design' in a local fintech hackathon.",
            "Clean data visualization of 1000+ transaction points.",
            "Highly responsive dashboard layout for tablet and desktop."
        ],
        typography: {
            primary: "Inter",
            secondary: "Space Mono"
        },
        colors: [
            { name: "Flux Sky", hex: "#0ea5e9" },
            { name: "Glass Base", hex: "rgba(255,255,255,0.05)" },
            { name: "Stat Green", hex: "#10b981" },
            { name: "Warning Orange", hex: "#f59e0b" }
        ],
        architecture: [
            { stage: "Glass Stack", desc: "Layered semi-transparent containers with CSS blur filters for depth." },
            { stage: "Data Mapping", desc: "Transformed raw financial JSON into normalized arrays for Chart.js consumption." },
            { stage: "Responsive Grid", desc: "Used Tailwind's grid system to pivot from 4-column cards to list views on mobile." }
        ],
        personas: [
            {
                name: "David Chen",
                role: "Venture Capitalist",
                goal: "Monitor my portfolio's daily volatility with as few clicks as possible.",
                painPoint: "Traditional banking dashboards are cluttered with marketing and slow to refresh.",
                image: "https://images.unsplash.com/photo-1500648767791-00dcc994a43e?q=80&w=200"
            }
        ],
        userJourney: [
            { title: "Auth", desc: "User enters a secure, glass-themed login portal." },
            { title: "Snapshot", desc: "The 'Capital Overview' chart animates in, showing 24h performance." },
            { title: "Granularity", desc: "User clicks a data point to see a detailed transaction breakdown." }
        ],
        detailedUseCases: [
            {
                title: "Live Data Hydration",
                scenario: "A user changes the date range from '1D' to '1M'. The system must fetch 30x more data points and execute a smooth morph transition on all Chart.js instances.",
                logic: [
                    "Fetch aggregate transaction data from mock API",
                    "Map raw values to Chart.js dataset formats",
                    "Trigger .update() with linear interpolation easing",
                    "Calculate new 'High/Low' range for the y-axis dynamically"
                ]
            }
        ],
        gallery: [],
        liveLink: "Projects/Flux/index.html"
    },
    "decora": {
        title: "Decora Interior Design",
        tagline: "E-Commerce / Design / Boutique",
        intro: "An elegant interior design platform and boutique shop featuring modular service showcases and premium product listings with an emphasis on tactile UI.",
        themeColor: "#1f2937", // Gray 800
        tech: ["HTML5", "CSS3", "JavaScript", "AOS"],
        mockup: "https://images.unsplash.com/photo-1618221195710-dd6b41faaea6?q=80&w=1200", // Luxury Interior Design
        customContent: "case-study-assets/decora/use-cases.html", // NEW: Bespoke Layout
        diagram: "case-study-assets/decora/architecture.png",
        challenge: "Merging a service-based agency site with an e-commerce catalog. The transition between 'Consultation' and 'Shopping' needed to be seamless.",
        solution: "Designed a modular UI where service blocks and product grids share a common design language. Used AOS for sophisticated section entries.",
        results: [
            "Cohesive branding across service and shop sections.",
            "Frictionless service inquiry flow integrated into the UI.",
            "High performance scores on Lighthouse for SEO and Accessibility."
        ],
        typography: {
            primary: "Inter",
            secondary: "Marcellus"
        },
        colors: [
            { name: "Decora Gray", hex: "#1f2937" },
            { name: "Linen", hex: "#f8fafc" },
            { name: "Earth Brown", hex: "#78350f" },
            { name: "Oasis Teal", hex: "#115e59" }
        ],
        architecture: [
            { stage: "Styling Strategy", desc: "Utilized Tailwind CSS for a rapid, utility-first UI development, ensuring a responsive and modern aesthetic." },
            { stage: "Modular Layout", desc: "Designed a multi-section landing page with reusable components for services, expert showcases, and blog previews." },
            { stage: "Interactive States", desc: "Implemented a custom JS-based mobile menu and interactive call-to-action buttons for seamless user engagement." }
        ],
        personas: [
            {
                name: "Sophia Rossi",
                role: "New Homeowner",
                goal: "Find a reliable flooring and interior design company that offers expert installation and a clear showcase of products.",
                painPoint: "Generic design websites often lack clear project stats and tangible service breakdowns, making decision-making difficult.",
                image: "https://images.unsplash.com/photo-1534528741775-53994a69daeb?q=80&w=200"
            }
        ],
        userJourney: [
            { title: "Service Discovery", desc: "User arrives on the hero page and immediately identifies the primary flooring and design services." },
            { title: "Trust Building", desc: "User scrolls through the 'Expert Installers' section and project counts to verify the company's experience." },
            { title: "Engagement", desc: "User utilizes the contact form to initiate a project consultation or browse the product shop." }
        ],
        detailedUseCases: [
            {
                title: "Responsive Navigation State",
                scenario: "A user on mobile clicks the hamburger menu. The UI must instantly toggle the mobile navigation overlay while swapping the menu icon for a close icon.",
                logic: [
                    "Listen for click events on the 'mobile-menu-button' element",
                    "Toggle the 'hidden' class on the 'mobile-menu' container via DOM manipulation",
                    "Synchronously toggle visibility of the 'icon-open' and 'icon-close' SVG elements",
                    "Ensure the menu state is cleared or hidden when navigating to sub-pages like 'about' or 'shop'"
                ]
            }
        ],
        gallery: [],
        liveLink: "Projects/Decora Interior Design/DecoraInteriorDesign.html"
    },
    "code-maze": {
        title: "Code Maze - Mobile Game",
        tagline: "Mobile / Flutter / Algorithms",
        intro: "A logically complex mobile puzzle game built with Flutter, featuring recursive maze generation and an immersive, native UI.",
        themeColor: "#8b5cf6", // Violet 500
        tech: ["Flutter", "Dart", "Recursive Algorithms", "Canvas"],
        mockup: "https://images.unsplash.com/photo-1550745165-9bc0b252726f?q=80&w=1200", // Neon Mobile Game Vibe
        customContent: "case-study-assets/code-maze/use-cases.html", // NEW: Bespoke Layout
        diagram: "case-study-assets/code-maze/architecture.png",
        challenge: "Generating mazes that are guaranteed to be solvable and challenging across different screen sizes while maintaining a 60fps render loop on low-end devices.",
        solution: "Implemented a custom 'Recursive Backtracking' algorithm for maze generation and used Flutter's Canvas API for hardware-accelerated rendering of the geometry.",
        results: [
            "100% solvable maze generation on every run.",
            "Buttery smooth 60fps performance on iOS and Android.",
            "Intuitive gesture-based controls for seamless navigation."
        ],
        typography: {
            primary: "Inter",
            secondary: "JetBrains Mono"
        },
        colors: [
            { name: "Neon Violet", hex: "#8b5cf6" },
            { name: "Electric Cyan", hex: "#22d3ee" },
            { name: "Void Purple", hex: "#2e1065" },
            { name: "Grid White", hex: "#f8fafc" }
        ],
        architecture: [
            { stage: "Maze Logic", desc: "Developed a graph-based representation of the maze to enable efficient pathfinding." },
            { stage: "Visual Render", desc: "Used CustomPainter in Flutter to draw the maze lines directly to the GPU." },
            { stage: "Input Matrix", desc: "Built a hit-detection engine to translate screen taps into logical maze coordinates." }
        ],
        personas: [
            {
                name: "Toby Miller",
                role: "Casual Mobile Gamer",
                goal: "Find a puzzle game that is challenging but doesn't feel 'cheap' or full of ads.",
                painPoint: "Most puzzle games have poor UI and feel repetitive.",
                image: "https://images.unsplash.com/photo-1531427186611-ecfd6d936c79?q=80&w=200"
            }
        ],
        userJourney: [
            { title: "Initialization", desc: "The app generates a unique maze seed on startup." },
            { title: "Navigation", desc: "User drags through the 'Code Maze' to reach the logic exit." },
            { title: "Victory", desc: "The system validates the path and triggers a geometric celebratory animation." }
        ],
        detailedUseCases: [
            {
                title: "Recursive Solvability Check",
                scenario: "A user generates an 'Extreme' difficulty maze. The algorithm must verify that there's at least one path from (0,0) to (N,N) before the user even starts.",
                logic: [
                    "Execute Depth-First Search (DFS) on the generated grid",
                    "Acknowledge the exit node hit",
                    "Return 'true' to render the UI",
                    "Ensure recursion depth doesn't exceed stack limits for large mazes"
                ]
            }
        ],
        gallery: [],
        liveLink: "https://github.com/openaifyp-prog/NyxCodes/tree/main/codemaze"
    },
    "coin-pulse": {
        title: "CoinPulse - Crypto Dashboard",
        tagline: "Fintech / API / Statistics",
        intro: "A high-fidelity crypto monitoring utility that transforms volatile market data into actionable visual insights through a professional, light-themed dashboard.",
        themeColor: "#6366f1", // Indigo 500
        tech: ["JavaScript", "CoinGecko API", "Chart.js", "Tailwind"],
        mockup: "https://images.unsplash.com/photo-1518546305927-5a555bb7020d?q=80&w=1200", // Premium Crypto Hero
        customContent: "case-study-assets/coin-pulse/use-cases.html", // NEW: Bespoke Layout
        diagram: "case-study-assets/coin-pulse/architecture.png",
        challenge: "Handling the inherent latency of external market APIs while ensuring the 'Live Pulse' charts remained fluid and non-blocking.",
        solution: "Engineered an asynchronous polling system with exponential backoff. Integrated Chart.js with data-streaming plugins for smooth ticker updates.",
        results: [
            "Real-time tracking of 100+ cryptocurrencies.",
            "Sub-second data reconciliation across multiple endpoints.",
            "Zero-latency UI updates during high market volatility."
        ],
        typography: {
            primary: "Inter",
            secondary: "Space Mono"
        },
        colors: [
            { name: "Cyber Indigo", hex: "#6366f1" },
            { name: "Obsidian", hex: "#0b0e14" },
            { name: "Market Green", hex: "#10b981" },
            { name: "Dashboard Gray", hex: "#64748b" }
        ],
        architecture: [
            { stage: "API Orchestration", desc: "Built a robust fetch controller to manage rate-limits and failovers for market data." },
            { stage: "Visual Telegraph", desc: "Used dynamic color mapping to reflect market sentiment (Bullish/Bearish) instantly." },
            { stage: "Data Persistence", desc: "Implemented state-saving for 'Pinned Coins' to avoid redundant searches." }
        ],
        personas: [
            {
                name: "Arun V.",
                role: "Day Trader",
                goal: "See my top 5 assets' performance in one glance without heavy loading indicators.",
                painPoint: "Most free crypto sites are slow and cluttered with irrelevant news.",
                image: "https://images.unsplash.com/photo-1506794778202-cad84cf45f1d?q=80&w=200"
            }
        ],
        userJourney: [
            { title: "Discovery", desc: "User lands on a trending-coins list curated by 24h volume." },
            { title: "Analysis", desc: "User clicks Bitcoin to launch a detailed Chart.js price-action node." },
            { title: "Monitoring", desc: "User pins 'Pulse Points' to their sidebar for permanent tracking." }
        ],
        detailedUseCases: [
            {
                title: "Sentiment-Aware Charting",
                scenario: "BTC price drops 5% in 1 hour. The dashboard border must morph to 'Bearish Red' and the chart stroke must update to reflect the trend change instantly.",
                logic: [
                    "Compare current price to T-1h value",
                    "Calculate delta percentage",
                    "Map delta to Tailwind color tokens",
                    "Update Chart.js border colors without re-rendering the whole dataset"
                ]
            }
        ],
        gallery: [],
        liveLink: "Projects/CoinPulse/index.html"
    },
    "nexus-news": {
        title: "Nexus News Aggregator",
        tagline: "Editorial / News / API",
        intro: "A daily auto-updating news portal that curates global headlines into a clean, editorial layout using live NewsAPI streams.",
        themeColor: "#000000",
        tech: ["JavaScript", "NewsAPI", "Tailwind CSS", "AOS"],
        mockup: "https://images.unsplash.com/photo-1504711434969-e33886168f5c?q=80&w=1200", // Daily News Editorial
        customContent: "case-study-assets/nexus-news/use-cases.html", // NEW: Bespoke Layout
        diagram: "case-study-assets/nexus-news/architecture.png",
        challenge: "Organizing diverse news sources into a visually unified grid without losing the individual identity of the sources.",
        solution: "Developed a 'Contextual Card' system that adapts metadata (Source, Time, Category) based on the image availability and headline length.",
        results: [
            "Seamless aggregation of 50+ global news sources.",
            "Dynamic editorial layout that prioritizes high-confidence headlines.",
            "Optimized for high-speed mobile reading sessions."
        ],
        typography: {
            primary: "Inter",
            secondary: "DM Serif Display"
        },
        colors: [
            { name: "Editorial Black", hex: "#000000" },
            { name: "Brief Red", hex: "#dc2626" },
            { name: "News Gray", hex: "#f9fafb" },
            { name: "Ink", hex: "#111827" }
        ],
        architecture: [
            { stage: "Source Ingestion", desc: "Built a fetch pipeline with category-based routing for real-time news streams." },
            { stage: "Grid Sanitization", desc: "Implemented a 'Broken Image' recovery system for news thumbnails." },
            { stage: "Visual Hierarchy", desc: "Used Tailwind to create 'Featured' vs 'List' layouts dynamically." }
        ],
        personas: [
            {
                name: "Omar K.",
                role: "Journalist / News Junkie",
                goal: "Scan global headers across 5 categories in under 2 minutes every morning.",
                painPoint: "Mainstream news sites are slow and bloated with ads.",
                image: "https://images.unsplash.com/photo-1500648767791-00dcc994a43e?q=80&w=200"
            }
        ],
        userJourney: [
            { title: "Skimming", desc: "User views the top-level 'Global' feed with editorial imagery." },
            { title: "Filtration", desc: "User clicks 'Technology' to Narrow the context instantly." },
            { title: "Deep-Dive", desc: "User clicks a headline to jump directly to the source article." }
        ],
        detailedUseCases: [
            {
                title: "Editorial Card Adaptation",
                scenario: "A news article comes in without a thumbnail image. The system must instantly pivot from an 'Image Card' to a 'Text-Heavy Editorial' layout to maintain grid symmetry.",
                logic: [
                    "Check for null values in image URL",
                    "Toggle 'no-image' CSS utility class",
                    "Inject placeholder gradient or expand typography",
                    "Recalculate masonry grid layout"
                ]
            }
        ],
        gallery: [],
        liveLink: "Projects/NexusNews/index.html"
    },
    "weather-nova": {
        title: "WeatherNova 3D",
        tagline: "Three.js / API / Immersive",
        intro: "A futuristic 3D weather ecosystem that translates abstract meteorological data into immersive WebGL environments.",
        themeColor: "#0ea5e9", // Sky 500
        tech: ["Three.js", "WebGL", "OpenWeather API", "GSAP"],
        mockup: "https://images.unsplash.com/photo-1534088568595-a066f410bcda?q=80&w=1200", // Atmospheric Weather Hero
        customContent: "case-study-assets/weather-nova/use-cases.html", // NEW: Bespoke Layout
        diagram: "case-study-assets/weather-nova/architecture.png",
        challenge: "Syncing real-time weather codes (Rain, Snow, Clear) with a Three.js particle system without dropping frames on mobile.",
        solution: "Built a 'Weather Orchestrator' that maps API response strings to specific GLSL shader uniforms and particle behaviors.",
        results: [
            "Fully immersive 3D weather visualization.",
            "Dynamic day/night cycle based on local time data.",
            "High-performance particle engine supporting 10k+ elements."
        ],
        typography: {
            primary: "Inter",
            secondary: "JetBrains Mono"
        },
        colors: [
            { name: "Nova Blue", hex: "#0ea5e9" },
            { name: "Storm Gray", hex: "#475569" },
            { name: "Sun Gold", hex: "#f59e0b" },
            { name: "Frost White", hex: "#f8fafc" }
        ],
        architecture: [
            { stage: "Particle Engine", desc: "Developed a GPGPU particle system for realistic weather effect rendering." },
            { stage: "Data Mapping", desc: "Linked OpenWeather conditions to specific Three.js scene environments." },
            { stage: "Atmospheric Lighting", desc: "Implemented dynamic lighting that reflects real-time sun positions." }
        ],
        personas: [
            {
                name: "Krystal L.",
                role: "Tech Enthusiast",
                goal: "Check the weather in a way that feels 'exciting' and visually stunning.",
                painPoint: "Traditional weather apps are boring lists of numbers.",
                image: "https://images.unsplash.com/photo-1544005313-94ddf0286df2?q=80&w=200"
            }
        ],
        userJourney: [
            { title: "Detection", desc: "App auto-detects user location or takes a city search." },
            { title: "Simulation", desc: "The Three.js scene instantly morphs into the current local weather (e.g., Rain)." },
            { title: "Interaction", desc: "User orbits the 3D globe to see the weather impact from different angles." }
        ],
        detailedUseCases: [
            {
                title: "Met-Data Particle Morphing",
                scenario: "The API reports 'Heavy Snow'. The system must instantly transition the 'Rain' particle velocity to zero, change textures to 'Flake', and add a white blanket to the ground geometry.",
                logic: [
                    "Acknowledge conditionCode change",
                    "Execute GSAP float interpolation for particle drift",
                    "Update Fragment Shader uniforms for 'white out' effect",
                    "Adjust scene ambient light to 'overcast' grey"
                ]
            }
        ],
        gallery: [],
        liveLink: "Projects/WeatherNova/index.html"
    },
    "studio-logic": {
        title: "Studio Logic | Algorithmic Suite",
        tagline: "Worker / Visualization / Algorithmic",
        intro: "A high-fidelity, off-main-thread algorithmic command center designed for performance and educational clarity. Features Sorting, Pathfinding, and Maze Generation visualizations powered by OffscreenCanvas and Web Workers.",
        themeColor: "#3b82f6", // Blue 500
        tech: ["Vanilla JS", "Web Workers", "OffscreenCanvas", "Algorithmic Design"],
        mockup: "https://images.unsplash.com/photo-1555066931-4365d14bab8c?q=80&w=1200",
        customContent: "case-study-assets/studio-logic/use-cases.html",
        diagram: "case-study-assets/studio-logic/architecture.png",

        challenge: "Maintaining a fluid 60FPS while executing complex recursive algorithms and rendering tens of thousands of data points without blocking the UI thread.",

        solution: "Implemented a heavy-duty worker architecture where all logic and rendering calculations occur in a dedicated Web Worker using OffscreenCanvas, ensuring zero main-thread UI jank.",
        results: [
            "Consistent 60FPS performance during high-load sorting operations.",
            "Real-time pseudocode mapping using ES6 Async Generators.",
            "Modular rendering system supporting both Linear and Grid-based domains."
        ],
        typography: {
            primary: "Inter",
            secondary: "JetBrains Mono"
        },
        colors: [
            { name: "Accent Blue", hex: "#3b82f6" },
            { name: "Signal Green", hex: "#10b981" },
            { name: "Data Slate", hex: "#0f172a" },
            { name: "Grid Border", hex: "#e2e8f0" }
        ],
        architecture: [
            { stage: "Multithreaded Engine", desc: "Transferred visual control to Web Workers via OffscreenCanvas." },
            { stage: "Logic Synchronization", desc: "Used generators to yield execution steps for real-time frontend code highlighting." },
            { stage: "Unified Renderer", desc: "Modular class for seamless switching between grid and linear visualization modes." }
        ],
        personas: [
            {
                name: "Alex M.",
                role: "Computer Science Student",
                goal: "Understand how QuickSort and A* actually work under the hood through visual steps.",
                painPoint: "Dry textbook explanations are hard to visualize in motion.",
                image: "https://images.unsplash.com/photo-1507003211169-0a1dd7228f2d?q=80&w=200"
            }
        ],
        userJourney: [
            { title: "Configuration", desc: "User selects algorithm and data size via the sidebar." },
            { title: "Execution", desc: "Visualization starts; worker calculates swaps/searches while main thread highlights code." },
            { title: "Analysis", desc: "Operations-per-frame are tracked to compare algorithmic efficiency." }
        ],
        detailedUseCases: [
            {
                title: "Real-time Pseudocode Mapping",
                scenario: "As the QuickSort recursive partitioning executes in the worker, the UI must highlight the exact ES6 line currently active in the pedagogical side-panel.",
                type: 'diagram',
                steps: [
                    { label: "Worker Yield", icon: "fa-solid fa-microchip" },
                    { label: "State Post", icon: "fa-solid fa-paper-plane" },
                    { label: "UI Listen", icon: "fa-solid fa-ear-listen" },
                    { label: "Line Highlighting", icon: "fa-solid fa-highlighter" }
                ],
                logic: [
                    "ES6 Async Generator yields line number signal",
                    "Worker serializes current array state and line ID",
                    "Main thread receives message and updates 'active' class on pseudocode DOM",
                    "Smooth scroll interaction ensures active line is always visible"
                ]
            },
            {
                title: "Off-Main-Thread Grid Computation",
                scenario: "Calculating A* pathfinding on a 100x100 grid while simultaneously emitting neon particle bursts on node visits.",
                type: 'diagram',
                steps: [
                    { label: "Heap Management", icon: "fa-solid fa-layer-group" },
                    { label: "Heuristic Calc", icon: "fa-solid fa-calculator" },
                    { label: "Offscreen Render", icon: "fa-solid fa-wind" },
                    { label: "Bloom VFX", icon: "fa-solid fa-sparkles" }
                ],
                logic: [
                    "Binary Heap used for efficient open-set management in Worker",
                    "A* heuristic (Manhattan/Euclidean) calculated per frame",
                    "OffscreenCanvas context handles Bloom and Particle VFX additive blending",
                    "Main thread remains interactive for real-time obstacle placement"
                ]
            },
            {
                title: "Heuristic-Driven Maze Synthesis",
                scenario: "Recursive Backtracking generates a maze; the system must visualize the 'stack' depth to show how the algorithm explores branches.",
                logic: [
                    "Stack color-mapping: darker hues represent deeper recursion",
                    "Worker calculates visit-frequency and stack-trace",
                    "Canvas renders visit-trails with varying opacity based on frequency",
                    "Batch-message throttling prevents PostMessage overhead saturation"
                ]
            }
        ],


        gallery: [],
        liveLink: "Projects/StudioLogic/index.html"
    }
};

