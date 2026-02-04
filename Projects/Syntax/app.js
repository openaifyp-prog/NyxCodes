// DOM Elements
const captureContainer = document.getElementById('capture-container');
const codeWindow = document.getElementById('code-window');
const codeArea = document.querySelector('.code-area');
const paddingSlider = document.getElementById('padding-slider');
const paddingVal = document.getElementById('padding-val');
const shadowSlider = document.getElementById('shadow-slider');
const shadowVal = document.getElementById('shadow-val');
const exportBtn = document.getElementById('export-btn');

// Theme Data
const themes = {
    midnight: {
        '--code-bg': '#0f172a',
        '--code-text': '#e2e8f0',
        '--token-keyword': '#c678dd', // Purple
        '--token-string': '#98c379',  // Green
    },
    dracula: {
        '--code-bg': '#282a36',
        '--code-text': '#f8f8f2',
        '--token-keyword': '#ff79c6', // Pink
        '--token-string': '#f1fa8c',  // Yellow
    },
    sunset: {
        '--code-bg': '#2d1b2e',
        '--code-text': '#fff1f2',
        '--token-keyword': '#ff9e64', // Orange
        '--token-string': '#dbd7ca',  // Beige
    },
    ocean: {
        '--code-bg': '#0f4c75',
        '--code-text': '#bbe1fa',
        '--token-keyword': '#3282b8', // Blue-ish
        '--token-string': '#0f9b0f',  // Green-ish
    }
};

/* --- Event Listeners --- */

// Padding Control
paddingSlider.addEventListener('input', (e) => {
    const val = e.target.value;
    paddingVal.textContent = `${val}px`;
    captureContainer.style.padding = `${val}px`;
});

// Shadow Control
shadowSlider.addEventListener('input', (e) => {
    const val = e.target.value;
    const intensity = val * 20;
    const spread = val * 10;
    shadowVal.textContent = ['Soft', 'Medium', 'Hard', 'Deep'][val - 1] || 'Custom';
    codeWindow.style.boxShadow = `0 ${intensity}px ${intensity + 20}px -${spread}px rgba(0,0,0,0.4)`;
});

// Background Gradient Control
document.querySelectorAll('.gradient-btn').forEach(btn => {
    btn.addEventListener('click', () => {
        document.querySelectorAll('.gradient-btn').forEach(b => b.classList.remove('active'));
        btn.classList.add('active');
        captureContainer.style.background = btn.dataset.gradient;
    });
});

// Background Solid Color Control
const colorPicker = document.getElementById('bg-color');
colorPicker.addEventListener('input', (e) => {
    const color = e.target.value;
    document.getElementById('bg-value').textContent = color;
    // Remove active state from gradients if custom color is picked
    document.querySelectorAll('.gradient-btn').forEach(b => b.classList.remove('active'));
    captureContainer.style.background = color;
});

// Theme Logic
document.querySelectorAll('.theme-btn').forEach(btn => {
    btn.addEventListener('click', () => {
        document.querySelectorAll('.theme-btn').forEach(b => b.classList.remove('active'));
        btn.classList.add('active');

        const themeName = btn.dataset.theme;
        const themeColors = themes[themeName];

        // Apply Variables
        const root = document.documentElement;
        for (const [key, value] of Object.entries(themeColors)) {
            root.style.setProperty(key, value);
        }
    });
});

/* --- Simple Syntax Function (Manual) --- */
// Note: A full tokenizer is heavy, so we'll use a simple regex replacer for demonstration.
// In a real production app, we'd use Prism.js or Highlight.js

// Language Config
const languages = {
    javascript: {
        extension: 'js',
        keywords: /\b(const|let|var|function|return|if|else|for|while|class|import|from|async|await|console|new|this)\b/g,
        strings: /(".*?"|'.*?'|`.*?`)/g,
        comments: /(\/\/.*|\/\*[\s\S]*?\*\/)/g,
        defaultCode: `const hello = "World";

function welcome(name) {
  return \`Hello, \${name}!\`;
}

console.log(welcome("Syntax"));`
    },
    python: {
        extension: 'py',
        keywords: /\b(def|return|if|else|elif|for|while|class|import|from|print|None|True|False|self|async|await)\b/g,
        strings: /(".*?"|'.*?'|`.*?`)/g,
        comments: /(#.*)/g,
        defaultCode: `def greet(name):
    """Greets the user"""
    return f"Hello, {name}!"

# Main execution
if __name__ == "__main__":
    print(greet("Syntax"))`
    },
    html: {
        extension: 'html',
        keywords: /(&lt;\/?[a-z0-9]+|&gt;)/gi,
        strings: /(".*?")/g,
        comments: /(&lt;!--[\sS]*?--&gt;)/g,
        defaultCode: `<!-- Syntax UI -->
<div class="card">
  <h1>Hello World</h1>
  <button>Click Me</button>
</div>`
    },
    css: {
        extension: 'css',
        keywords: /([a-z-]+)(?=:)/gi,
        strings: /(:[^;]+;)/g,
        comments: /(\/\*[\sS]*?\*\/)/g,
        defaultCode: `/* Container Styles */
.card {
  background: #fff;
  padding: 2rem;
  border-radius: 8px;
  box-shadow: 0 4px 6px rgba(0,0,0,0.1);
}`
    }
};

let currentLang = 'javascript';

function highlightSyntax() {
    let text = codeArea.innerText;

    // 1. Basic HTML Escaping
    text = text.replace(/&/g, "&amp;").replace(/</g, "&lt;").replace(/>/g, "&gt;");

    const rules = languages[currentLang];

    // Placeholder Storage
    const placeholders = [];
    const createPlaceholder = (content, type) => {
        placeholders.push({ content, type });
        return `%%%TOKEN${placeholders.length - 1}%%%`;
    };

    // 2. Extract Comments (Highest priority)
    text = text.replace(rules.comments, (match) => {
        return createPlaceholder(match, 'token-comment');
    });

    // 3. Extract Strings
    text = text.replace(rules.strings, (match) => {
        return createPlaceholder(match, 'token-string');
    });

    // 4. Highlight Keywords
    // Now text is safe from strings/comments collisions
    text = text.replace(rules.keywords, '<span class="token-keyword">$1</span>');

    // 5. Restore Placeholders
    text = text.replace(/%%%TOKEN(\d+)%%%/g, (match, id) => {
        const token = placeholders[id];
        return `<span class="${token.type}">${token.content}</span>`;
    });

    codeArea.innerHTML = text;
}

// Logic to handle cursor position is complex for standard contenteditable.
// We stick to "Highlight on Blur" for usability.
codeArea.addEventListener('blur', highlightSyntax);

// Language Selector Logic
const langSelect = document.getElementById('language-select');
const fileNameInput = document.querySelector('.file-name');

langSelect.addEventListener('change', (e) => {
    currentLang = e.target.value;
    const config = languages[currentLang];

    // Update Filename Extension
    const currentName = fileNameInput.value.split('.')[0] || 'untitled';
    fileNameInput.value = `${currentName}.${config.extension}`;

    // Update Code Template
    codeArea.innerText = config.defaultCode;

    // Re-highlight
    highlightSyntax();
});

// Run once
highlightSyntax();

/* --- Export Logic --- */
exportBtn.addEventListener('click', () => {
    exportBtn.innerHTML = '<i class="ph ph-spinner ph-spin"></i> Generating...';

    html2canvas(captureContainer, {
        scale: 2, // Retina quality
        backgroundColor: null, // Transparent wrapper
        useCORS: true
    }).then(canvas => {
        const link = document.createElement('a');
        link.download = 'syntax-export.png';
        link.href = canvas.toDataURL('image/png');
        link.click();

        exportBtn.innerHTML = '<i class="ph ph-download-simple"></i> Export PNG';
    });
});
