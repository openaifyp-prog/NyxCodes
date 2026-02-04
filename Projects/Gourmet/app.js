const API_URL = "https://www.themealdb.com/api/json/v1/1/";
let currentRecipes = [];
let currentServings = 4;
let originalServings = 4;
let activeRecipe = null;

// DOM Elements
const searchInput = document.getElementById('search-input');
const recipeGrid = document.getElementById('recipe-grid');
const categoriesContainer = document.getElementById('categories-container');
const resultsTitle = document.getElementById('results-title');
const recipeCount = document.getElementById('recipe-count');
const recipeModal = document.getElementById('recipe-modal');
const modalBody = document.getElementById('modal-body');
const closeModalBtn = document.getElementById('close-modal');

/* --- Initialization --- */
async function init() {
    await fetchCategories();
    await fetchRecipes('Chicken'); // Default search
}

/* --- API Functions --- */
async function fetchCategories() {
    try {
        const res = await fetch(`${API_URL}categories.php`);
        const data = await res.json();
        renderCategories(data.categories);
    } catch (err) {
        console.error("Error fetching categories:", err);
    }
}

async function fetchRecipes(query) {
    recipeGrid.innerHTML = '<div class="loading">Sizzling it up...</div>';
    resultsTitle.innerText = `Recipes for "${query}"`;

    try {
        const res = await fetch(`${API_URL}search.php?s=${query}`);
        const data = await res.json();
        currentRecipes = data.meals || [];
        renderRecipes(currentRecipes);
    } catch (err) {
        console.error("Error fetching recipes:", err);
        recipeGrid.innerHTML = '<div class="error">Failed to load recipes.</div>';
    }
}

async function fetchByCategory(category) {
    recipeGrid.innerHTML = '<div class="loading">Fetching flavors...</div>';
    resultsTitle.innerText = `${category} Recipes`;

    try {
        const res = await fetch(`${API_URL}filter.php?c=${category}`);
        const data = await res.json();
        currentRecipes = data.meals || [];
        renderRecipes(currentRecipes);
    } catch (err) {
        console.error("Error fetching recipes by category:", err);
    }
}

async function fetchRecipeDetails(id) {
    try {
        const res = await fetch(`${API_URL}lookup.php?i=${id}`);
        const data = await res.json();
        return data.meals[0];
    } catch (err) {
        console.error("Error fetching recipe details:", err);
    }
}

/* --- Rendering Functions --- */
function renderCategories(categories) {
    categoriesContainer.innerHTML = categories.map(cat => `
        <div class="category-chip" onclick="fetchByCategory('${cat.strCategory}')">
            ${cat.strCategory}
        </div>
    `).join('');
}

function renderRecipes(recipes) {
    recipeCount.innerText = recipes.length;

    if (recipes.length === 0) {
        recipeGrid.innerHTML = '<p class="error">No recipes found. Try another search!</p>';
        return;
    }

    recipeGrid.innerHTML = recipes.map(meal => `
        <div class="recipe-card" onclick="openRecipe('${meal.idMeal}')">
            <div class="card-img-container">
                <img src="${meal.strMealThumb}" class="card-img" alt="${meal.strMeal}">
                <span class="category-tag">${meal.strCategory || 'Recipe'}</span>
            </div>
            <div class="card-content">
                <h3>${meal.strMeal}</h3>
                <p class="area">${meal.strArea || ''}</p>
            </div>
        </div>
    `).join('');
}

async function openRecipe(id) {
    const meal = await fetchRecipeDetails(id);
    activeRecipe = meal;
    currentServings = 4; // Default
    renderModalContent();
    recipeModal.classList.add('active');
    document.body.style.overflow = 'hidden';
}

function renderModalContent() {
    const meal = activeRecipe;
    const ingredients = getParsedIngredients(meal);

    modalBody.innerHTML = `
        <div class="modal-hero">
            <img src="${meal.strMealThumb}" alt="${meal.strMeal}">
            <div class="hero-overlay">
                <span class="category-badge">${meal.strCategory}</span>
                <h2>${meal.strMeal}</h2>
                <div class="hero-meta">
                    <span><i class="ph ph-map-pin"></i> ${meal.strArea}</span>
                    <span><i class="ph ph-clock"></i> 45 Mins</span>
                    ${meal.strYoutube ? `<a href="${meal.strYoutube}" target="_blank" class="video-link"><i class="ph ph-play-circle"></i> Watch Masterclass</a>` : ''}
                </div>
            </div>
        </div>

        <div class="recipe-content-wrapper">
            <!-- Nutritional Bar -->
            <div class="nutrition-bar">
                <div class="nutri-item"><span>Calories</span><strong>520</strong></div>
                <div class="nutri-item"><span>Protein</span><strong>24g</strong></div>
                <div class="nutri-item"><span>Carbs</span><strong>65g</strong></div>
                <div class="nutri-item"><span>Fat</span><strong>12g</strong></div>
            </div>

            <div class="recipe-main-grid">
                <div class="sidebar">
                    <div class="scaler-card">
                        <label>Adjust Servings</label>
                        <div class="scaler-controls">
                            <button class="scaler-btn" onclick="updateServings(-1)"><i class="ph ph-minus"></i></button>
                            <span id="servings-count">${currentServings}</span>
                            <button class="scaler-btn" onclick="updateServings(1)"><i class="ph ph-plus"></i></button>
                        </div>
                    </div>

                    <div class="ingredients-box">
                        <h3>Ingredients</h3>
                        <p class="section-hint">Check items as you shop</p>
                        <ul class="ingredient-list">
                            ${ingredients.map((ing, i) => `
                                <li class="ingredient-item">
                                    <label class="check-container">
                                        <input type="checkbox">
                                        <span class="checkmark"></span>
                                        <span class="ing-name">${ing.name}</span>
                                    </label>
                                    <span class="ing-measure">${scaleMeasure(ing.measure, currentServings)}</span>
                                </li>
                            `).join('')}
                        </ul>
                    </div>
                </div>

                <div class="instructions-box">
                    <h3>Cooking Method</h3>
                    <div class="instructions-text">
                        ${meal.strInstructions.split('\r\n').filter(line => line.trim()).map((step, idx) => `
                            <div class="step-row">
                                <span class="step-num">${idx + 1}</span>
                                <p>${step}</p>
                            </div>
                        `).join('')}
                    </div>
                </div>
            </div>
        </div>
    `;
}

/* --- Logic --- */
function getParsedIngredients(meal) {
    const ingredients = [];
    for (let i = 1; i <= 20; i++) {
        if (meal[`strIngredient${i}`]) {
            ingredients.push({
                name: meal[`strIngredient${i}`],
                measure: meal[`strMeasure${i}`]
            });
        }
    }
    return ingredients;
}

function updateServings(delta) {
    const newVal = currentServings + delta;
    if (newVal >= 1 && newVal <= 20) {
        currentServings = newVal;
        renderModalContent();
    }
}

function scaleMeasure(measure, targetServings) {
    const ratio = targetServings / originalServings;

    // Regex to find numbers (fractions like 1/2 or decimals like 1.5)
    // Matches 1 1/2, 1/2, 1.5, 1
    const numRegex = /(\d+(\.\d+)?)|(\d+\/\d+)/g;

    return measure.replace(numRegex, match => {
        let value;
        if (match.includes('/')) {
            const [num, den] = match.split('/');
            value = parseFloat(num) / parseFloat(den);
        } else {
            value = parseFloat(match);
        }

        const scaled = value * ratio;

        // Clean up the output
        if (Number.isInteger(scaled)) return scaled;
        return scaled.toFixed(1).replace(/\.0$/, '');
    });
}

async function fetchRandomRecipe() {
    try {
        const res = await fetch(`${API_URL}random.php`);
        const data = await res.json();
        const meal = data.meals[0];
        openRecipe(meal.idMeal);
    } catch (err) {
        console.error("Error fetching random recipe:", err);
    }
}

// Event Listeners
const randomBtn = document.getElementById('random-btn');
randomBtn.addEventListener('click', fetchRandomRecipe);

searchInput.addEventListener('keypress', (e) => {
    if (e.key === 'Enter') {
        fetchRecipes(searchInput.value);
    }
});

closeModalBtn.addEventListener('click', () => {
    recipeModal.classList.remove('active');
    document.body.style.overflow = 'auto';
});

init();
