document.addEventListener('DOMContentLoaded', () => {

    // Smooth scroll for anchor links
    document.querySelectorAll('a[href^="#"]').forEach(anchor => {
        anchor.addEventListener('click', function (e) {
            e.preventDefault();
            const target = document.querySelector(this.getAttribute('href'));
            if (target) {
                target.scrollIntoView({
                    behavior: 'smooth'
                });
            }
        });
    });

    // Booking Widget Animation
    const btnSearch = document.querySelector('.btn-search');
    if (btnSearch) {
        btnSearch.addEventListener('click', () => {
            btnSearch.innerHTML = '✓';
            setTimeout(() => {
                alert('Searching availability at The Nook...');
                btnSearch.innerHTML = '&#8594;';
            }, 500);
        });
    }

    // Scroll Effect for Header
    const header = document.querySelector('header');
    window.addEventListener('scroll', () => {
        if (window.scrollY > 50) {
            header.style.backgroundColor = 'rgba(250, 249, 246, 0.95)';
            header.style.backdropFilter = 'blur(10px)';
            header.style.padding = '15px 0';
            header.style.transition = 'all 0.3s ease';
        } else {
            header.style.backgroundColor = 'transparent';
            header.style.backdropFilter = 'none';
            header.style.padding = '24px 0';
        }
    });
});
