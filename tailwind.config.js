/** @type {import('tailwindcss').Config} */
module.exports = {
    content: ["./*.{html,js}"],
    theme: {
        extend: {
            colors: {
                theme: {
                    primary: '#2563EB', // Manually extracting custom colors if needed, but defaults are fine
                }
            }
        },
    },
    plugins: [],
}
