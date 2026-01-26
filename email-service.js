// EmailJS Service Wrapper
// Step 1: Initialize EmailJS
// Replace 'YOUR_PUBLIC_KEY' with your actual EmailJS Public Key
(function () {
    // We need to load the SDK first via CDN in HTML, checking if it exists
    if (typeof emailjs !== 'undefined') {
        emailjs.init("YOUR_PUBLIC_KEY"); // TODO: User to replace this
    } else {
        console.warn("EmailJS SDK not loaded. Forms will not work.");
    }
})();

/**
 * Handles form submission using EmailJS
 * @param {string} formId - The ID of the HTML form element
 * @param {string} serviceId - EmailJS Service ID
 * @param {string} templateId - EmailJS Template ID
 * @param {HTMLElement} btnElement - The submit button element (to toggle loading state)
 */
function handleContactForm(formId, serviceId = "service_default", templateId = "template_default", btnElement) {
    const form = document.getElementById(formId);
    if (!form) return;

    form.addEventListener('submit', function (event) {
        event.preventDefault();

        const originalBtnText = btnElement.innerText;
        btnElement.innerText = 'Sending...';
        btnElement.disabled = true;

        // Collect parameters (assuming standarized names: user_name, user_email, message)
        // Or send the form directly
        emailjs.sendForm(serviceId, templateId, this)
            .then(function () {
                alert('Message Sent Successfully!');
                form.reset();
                btnElement.innerText = 'Sent!';
                setTimeout(() => {
                    btnElement.innerText = originalBtnText;
                    btnElement.disabled = false;
                }, 3000);
            }, function (error) {
                console.error("EmailJS Error:", error);
                alert('Failed to send message. Please try again later or email directly.');
                btnElement.innerText = originalBtnText;
                btnElement.disabled = false;
            });
    });
}
