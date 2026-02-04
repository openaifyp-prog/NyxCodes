// WeatherNova Logic
// Integrates Three.js for background effects + Real Data

// --- CONFIG ---
const API_KEY = ""; // User can add OpenWeatherMap Key here

// --- THREE.JS SETUP ---
const canvas = document.getElementById('weather-canvas');
const scene = new THREE.Scene();
const camera = new THREE.PerspectiveCamera(75, window.innerWidth / window.innerHeight, 0.1, 1000);
const renderer = new THREE.WebGLRenderer({ canvas: canvas, alpha: true });

renderer.setSize(window.innerWidth, window.innerHeight);
renderer.setPixelRatio(Math.min(window.devicePixelRatio, 2));
camera.position.z = 5;

// Bodies (Rain/Snow/Clouds/Stars/ShootingStars)
let particleSystem, starSystem, shootingStarSystem;
const particleCount = 2000;
const starCount = 1000;
const shootingStarCount = 20; // Pool of potential shooting stars

const particles = new Float32Array(particleCount * 3);
const stars = new Float32Array(starCount * 3);
const shootingStars = new Float32Array(shootingStarCount * 3);

// Materials
const particleMaterial = new THREE.PointsMaterial({
    color: 0xffffff,
    size: 0.05,
    transparent: true,
    opacity: 0.8,
    blending: THREE.AdditiveBlending
});

const starMaterial = new THREE.PointsMaterial({
    color: 0xffffff,
    size: 0.03,
    transparent: true,
    opacity: 0,
    blending: THREE.AdditiveBlending
});

const shootingStarMaterial = new THREE.PointsMaterial({
    color: 0xaec6cf, // Pastel blue-ish white
    size: 0.3,
    transparent: true,
    opacity: 0,
    blending: THREE.AdditiveBlending,
    map: null // Could add a streak texture here if needed
});

// Init Particles
for (let i = 0; i < particleCount * 3; i++) {
    particles[i] = (Math.random() - 0.5) * 20;
}

// Init Stars
for (let i = 0; i < starCount * 3; i++) {
    stars[i] = (Math.random() - 0.5) * 30;
}

// Init Shooting Stars (Hide them initially)
for (let i = 0; i < shootingStarCount * 3; i++) {
    shootingStars[i] = 100; // Off screen
}

const particleGeo = new THREE.BufferGeometry();
particleGeo.setAttribute('position', new THREE.BufferAttribute(particles, 3));
particleSystem = new THREE.Points(particleGeo, particleMaterial);
scene.add(particleSystem);

const starGeo = new THREE.BufferGeometry();
starGeo.setAttribute('position', new THREE.BufferAttribute(stars, 3));
starSystem = new THREE.Points(starGeo, starMaterial);
scene.add(starSystem);

const shootingStarGeo = new THREE.BufferGeometry();
shootingStarGeo.setAttribute('position', new THREE.BufferAttribute(shootingStars, 3));
shootingStarSystem = new THREE.Points(shootingStarGeo, shootingStarMaterial);
scene.add(shootingStarSystem);


// Weather State & Globals
let weatherState = 'Clear';
let activeWindSpeed = 0; // 0 to 100+
let isNight = false;

// Helpers for Shooting Stars
let activeShootingStars = []; // List of indices currently animating

function triggerShootingStar() {
    if (activeShootingStars.length > 3) return; // Limit active ones

    const idx = Math.floor(Math.random() * shootingStarCount);
    // Reset pos
    const positions = shootingStarSystem.geometry.attributes.position.array;
    positions[idx * 3] = (Math.random() - 0.5) * 20; // X
    positions[idx * 3 + 1] = 10; // Y (Top)
    positions[idx * 3 + 2] = (Math.random() - 0.5) * 5; // Z

    activeShootingStars.push({ id: idx, speed: 0.2 + Math.random() * 0.3 });
}

function triggerLightning() {
    const flashDiv = document.createElement('div');
    flashDiv.className = 'lightning-flash';
    document.body.appendChild(flashDiv);
    // Remove after animation (0.2s)
    setTimeout(() => { document.body.removeChild(flashDiv) }, 300);
}

// Helper: Generate Rain Streak Texture
function createRainTexture() {
    const canvas = document.createElement('canvas');
    canvas.width = 32;
    canvas.height = 128;
    const ctx = canvas.getContext('2d');

    // Gradient Streak
    const gradient = ctx.createLinearGradient(0, 0, 0, 128);
    gradient.addColorStop(0, 'rgba(255, 255, 255, 0)');
    gradient.addColorStop(0.5, 'rgba(255, 255, 255, 0.8)');
    gradient.addColorStop(1, 'rgba(255, 255, 255, 0)');

    ctx.fillStyle = gradient;
    ctx.fillRect(0, 0, 32, 128);

    const texture = new THREE.CanvasTexture(canvas);
    return texture;
}

const rainTexture = createRainTexture();

function animateThree() {
    requestAnimationFrame(animateThree);

    const pPos = particleSystem.geometry.attributes.position.array;
    const sPos = shootingStarSystem.geometry.attributes.position.array;

    // --- Material Swapping Logic ---
    if (weatherState === 'Rain' || weatherState === 'Storm') {
        particleMaterial.map = rainTexture;
        particleMaterial.size = 0.8; // Larger for streaks
        particleMaterial.transparent = true;
        particleMaterial.opacity = 0.7;
    } else {
        particleMaterial.map = null; // Reset to blocks/dots
        particleMaterial.size = 0.05; // Standard size
    }

    // --- Star Logic ---
    if (weatherState === 'ClearNight') {
        starMaterial.opacity = THREE.MathUtils.lerp(starMaterial.opacity, 0.9, 0.02);
        particleMaterial.opacity = THREE.MathUtils.lerp(particleMaterial.opacity, 0, 0.1);
        starSystem.rotation.y += 0.0001;

        // Shooting Star Trigger
        if (Math.random() < 0.005) triggerShootingStar();

    } else {
        starMaterial.opacity = THREE.MathUtils.lerp(starMaterial.opacity, 0, 0.1);
    }

    // --- Shooting Star Animation ---
    if (activeShootingStars.length > 0) {
        shootingStarMaterial.opacity = 0.8;
        for (let i = activeShootingStars.length - 1; i >= 0; i--) {
            const star = activeShootingStars[i];
            const i3 = star.id * 3;

            sPos[i3] -= star.speed; // Move Left
            sPos[i3 + 1] -= star.speed; // Move Down

            if (sPos[i3 + 1] < -5) {
                activeShootingStars.splice(i, 1); // Remove when out of view
            }
        }
    } else {
        shootingStarMaterial.opacity = 0;
    }
    shootingStarSystem.geometry.attributes.position.needsUpdate = true;

    // --- Storm Lightning Logic ---
    if (weatherState === 'Storm') {
        if (Math.random() < 0.003) triggerLightning();
    }

    // --- Standard Particle Logic (Rain/Snow) ---
    // Wind factor: activeWindSpeed is mph.
    // Map 0-50mph to 0.0-0.2 X drift
    const windDrift = (activeWindSpeed / 50) * 0.2;

    for (let i = 0; i < particleCount; i++) {
        const i3 = i * 3;

        if (weatherState === 'Rain' || weatherState === 'Storm') {
            const speed = weatherState === 'Storm' ? 0.8 : 0.5; // Faster Fall
            pPos[i3 + 1] -= speed; // Gravity
            pPos[i3] -= (0.01 + windDrift); // Wind

            // Simpler Reset for Rain (Streak needs height)
            if (pPos[i3 + 1] < -5) {
                pPos[i3 + 1] = 5;
                pPos[i3] = (Math.random() - 0.5) * 20;
            }
            // Opacity managed by material swap above
        }
        else if (weatherState === 'Snow') {
            pPos[i3 + 1] -= 0.02;
            pPos[i3] += Math.sin(Date.now() * 0.001 + i) * 0.005 - (windDrift * 0.5);
            if (pPos[i3 + 1] < -5) {
                pPos[i3 + 1] = 5;
                pPos[i3] = (Math.random() - 0.5) * 20;
            }
            particleMaterial.size = 0.06;
            particleMaterial.opacity = 0.8;
        }
        else if (weatherState === 'Clouds') {
            pPos[i3] += 0.002 + (windDrift * 0.1);
            if (pPos[i3] > 10) pPos[i3] = -10;
            particleMaterial.size = 0.2;
            particleMaterial.opacity = 0.3;
        }
    }

    particleSystem.geometry.attributes.position.needsUpdate = true;
    renderer.render(scene, camera);
}
animateThree();

// Resize
window.addEventListener('resize', () => {
    camera.aspect = window.innerWidth / window.innerHeight;
    camera.updateProjectionMatrix();
    renderer.setSize(window.innerWidth, window.innerHeight);
});

// --- APP DATA ---

const dom = {
    city: document.getElementById('city-display'),
    temp: document.getElementById('temp-display'),
    condition: document.getElementById('condition-display'),
    icon: document.getElementById('weather-icon'),
    humidity: document.getElementById('humidity-display'),
    wind: document.getElementById('wind-display'),
    pressure: document.getElementById('pressure-display'),
    visibility: document.getElementById('visibility-display'),
    input: document.getElementById('city-search'),
    date: document.getElementById('date-display'),
    forecastContainer: document.getElementById('forecast-container')
};

const options = { weekday: 'long', day: 'numeric', month: 'short' };
dom.date.textContent = new Date().toLocaleDateString('en-US', options);

const wmoCodes = {
    0: { desc: 'Clear Sky', icon: '☀️', state: 'Clear' },
    1: { desc: 'Mainly Clear', icon: '🌤️', state: 'Clear' },
    2: { desc: 'Partly Cloudy', icon: '⛅', state: 'Clouds' },
    3: { desc: 'Overcast', icon: '☁️', state: 'Clouds' },
    45: { desc: 'Fog', icon: '🌫️', state: 'Clouds' },
    48: { desc: 'Rime Fog', icon: '🌫️', state: 'Clouds' },
    51: { desc: 'Drizzle', icon: '🌦️', state: 'Rain' },
    53: { desc: 'Drizzle', icon: '🌦️', state: 'Rain' },
    55: { desc: 'Heavy Drizzle', icon: '🌧️', state: 'Rain' },
    61: { desc: 'Rain', icon: '🌦️', state: 'Rain' },
    63: { desc: 'Rain', icon: '🌧️', state: 'Rain' },
    65: { desc: 'Heavy Rain', icon: '🌧️', state: 'Rain' },
    71: { desc: 'Snow', icon: '🌨️', state: 'Snow' },
    73: { desc: 'Snow', icon: '🌨️', state: 'Snow' },
    75: { desc: 'Heavy Snow', icon: '❄️', state: 'Snow' },
    77: { desc: 'Snow Grains', icon: '❄️', state: 'Snow' },
    80: { desc: 'Showers', icon: '🌦️', state: 'Rain' },
    81: { desc: 'Heavy Showers', icon: '🌧️', state: 'Rain' },
    82: { desc: 'Violent Showers', icon: '⛈️', state: 'Storm' },
    85: { desc: 'Snow Showers', icon: '🌨️', state: 'Snow' },
    86: { desc: 'Heavy Snow Showers', icon: '❄️', state: 'Snow' },
    95: { desc: 'Thunderstorm', icon: '⚡', state: 'Storm' },
    96: { desc: 'Thunderstorm Hail', icon: '⛈️', state: 'Storm' },
    99: { desc: 'Thunderstorm Hail', icon: '⛈️', state: 'Storm' }
};

async function getWeatherData(city) {
    try {
        const geoUrl = `https://geocoding-api.open-meteo.com/v1/search?name=${encodeURIComponent(city)}&count=1&language=en&format=json`;
        const geoRes = await fetch(geoUrl);
        const geoData = await geoRes.json();

        if (!geoData.results || geoData.results.length === 0) {
            alert(`City "${city}" not found.`);
            return;
        }

        const { latitude, longitude, name, country } = geoData.results[0];

        const weatherUrl = `https://api.open-meteo.com/v1/forecast?latitude=${latitude}&longitude=${longitude}&current_weather=true&hourly=relativehumidity_2m,surface_pressure,visibility,temperature_2m,weathercode&daily=weathercode,temperature_2m_max,temperature_2m_min&timezone=auto&temperature_unit=fahrenheit&windspeed_unit=mph`;
        const weatherRes = await fetch(weatherUrl);
        const weatherData = await weatherRes.json();

        updateUI(name, country, weatherData);

    } catch (error) {
        console.error("Error:", error);
    }
}

function updateUI(city, country, data) {
    const current = data.current_weather;
    const hourly = data.hourly;
    const timeIndex = new Date().getHours();
    const isDay = current.is_day; // 1 or 0
    isNight = !isDay;

    activeWindSpeed = current.windspeed; // Update global for particles

    const weatherInfo = wmoCodes[current.weathercode] || { desc: 'Unknown', icon: '❓', state: 'Clear' };

    dom.city.textContent = city;
    dom.temp.textContent = Math.round(current.temperature);
    dom.condition.textContent = weatherInfo.desc;

    // Icon Swap
    let icon = weatherInfo.icon;
    if (isNight && weatherInfo.state === 'Clear') icon = '🌙';
    dom.icon.textContent = icon;

    dom.humidity.textContent = `${hourly.relativehumidity_2m[timeIndex]}%`;
    dom.wind.textContent = `${current.windspeed} mph`;
    dom.pressure.textContent = `${hourly.surface_pressure[timeIndex]} hPa`;
    const visKm = hourly.visibility[timeIndex] / 1000;
    dom.visibility.textContent = `${visKm.toFixed(1)} km`;

    // Update 3D State
    updateWeather3D(weatherInfo.state, isNight);

    // Forecast
    updateForecast(hourly);
}

function updateForecast(hourly) {
    const container = dom.forecastContainer;
    container.innerHTML = '';
    const currentHour = new Date().getHours();

    for (let i = 1; i <= 5; i++) {
        const hourIndex = (currentHour + i) % 24;
        const temp = Math.round(hourly.temperature_2m[hourIndex]);
        const code = hourly.weathercode[hourIndex];
        const info = wmoCodes[code] || { icon: '❓' };

        const el = document.createElement('div');
        el.className = 'forecast-item flex flex-col items-center min-w-[60px] p-2 rounded-xl border border-white/10';
        el.innerHTML = `
            <span class="text-xs text-white/60 mb-1">${hourIndex}:00</span>
            <span class="text-xl mb-1">${info.icon}</span>
            <span class="font-bold text-sm bg-clip-text text-transparent bg-gradient-to-b from-white to-white/60">${temp}°</span>
        `;
        container.appendChild(el);
    }
}

function updateWeather3D(state, night) {
    // Logic for State
    if (state === 'Clear' && night) weatherState = 'ClearNight';
    else weatherState = state;

    // Logic for Body Theme
    document.body.className = "overflow-hidden text-white font-['Outfit'] transition-colors duration-1000 ease-in-out";

    if (weatherState === 'Clear') document.body.classList.add('theme-clear');
    else if (weatherState === 'ClearNight') document.body.classList.add('theme-night-clear');
    else if (weatherState === 'Rain') document.body.classList.add('theme-rain');
    else if (weatherState === 'Snow') document.body.classList.add('theme-snow');
    else if (weatherState === 'Storm') document.body.classList.add('theme-storm');
    else if (weatherState === 'Clouds') document.body.classList.add(night ? 'theme-night-cloudy' : 'theme-clouds');
    else document.body.classList.add('theme-clear');
}

// Events
dom.input.addEventListener('keypress', (e) => {
    if (e.key === 'Enter') getWeatherData(dom.input.value);
});
document.querySelectorAll('.demo-btn').forEach(btn => {
    btn.addEventListener('click', () => {
        dom.input.value = btn.dataset.city;
        getWeatherData(btn.dataset.city);
    });
});

// Init
getWeatherData("San Francisco");
