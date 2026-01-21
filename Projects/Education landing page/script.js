// Wait for the DOM (all HTML) to be loaded
document.addEventListener('DOMContentLoaded', () => {

    // === Mobile Menu Toggle ===
    const menuToggle = document.querySelector('.menu-toggle');
    const navLinks = document.querySelector('.nav-links');

    if (menuToggle && navLinks) {
        menuToggle.addEventListener('click', () => {
            navLinks.classList.toggle('active');
        });
    }

    // === Sliders (Swiper.js) ===
    if (typeof Swiper !== 'undefined') {
        
        // --- Category Slider ---
        new Swiper('.category-slider', {
            slidesPerView: 1,
            slidesPerGroup: 1,
            spaceBetween: 25,
            breakpoints: {
                768: {
                    slidesPerView: 2,
                    slidesPerGroup: 2,
                },
                992: {
                    slidesPerView: 4,
                    slidesPerGroup: 4,
                }
            },
            pagination: {
                el: '.category-pagination-dots',
                clickable: true,
                bulletClass: 'dot', 
                bulletActiveClass: 'swiper-pagination-bullet-active', 
            },
        });
        
        // --- Instructor Slider ---
        new Swiper('.instructor-slider', {
            slidesPerView: 1, // Default for mobile
            spaceBetween: 25,
            navigation: {
                nextEl: '.instructor-arrow-next',
                prevEl: '.instructor-arrow-prev',
            },
            breakpoints: {
                // Show 3 slides on tablet (768px) and up
                768: {
                    slidesPerView: 3, 
                }
            },
        });

        // --- Testimonial Slider ---
        new Swiper('.testimonial-slider', {
            slidesPerView: 1, // Default for mobile
            spaceBetween: 25,
            navigation: {
                nextEl: '.testimonial-arrow-next',
                prevEl: '.testimonial-arrow-prev',
            },
            breakpoints: {
                // Show 2 slides on tablet (768px) and up
                768: {
                    slidesPerView: 2,
                }
            },
        });
    }
});