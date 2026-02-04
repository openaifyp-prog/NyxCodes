// --- DOM Elements ---
const taskModal = document.getElementById('task-modal');
const detailsModal = document.getElementById('details-modal');
const addTaskBtn = document.getElementById('add-task-btn');
const cancelBtn = document.getElementById('cancel-btn');
const saveTaskBtn = document.getElementById('save-task-btn');
const closeDetailsBtn = document.getElementById('close-details-btn');
const searchInput = document.getElementById('search-input');
const themeToggle = document.getElementById('theme-toggle');

// Inputs
const taskTitleInput = document.getElementById('task-title');
const taskDateInput = document.getElementById('task-date');

// Custom Inputs
const filterTagInput = document.getElementById('filter-tag');
const taskTagInput = document.getElementById('task-tag');
const customTagContainer = document.getElementById('custom-tag-container');
const customTagInput = document.getElementById('custom-tag-input');
const sortValueInput = document.getElementById('sort-value');

// Details Elements
const detailTitle = document.getElementById('detail-title');
const detailDesc = document.getElementById('detail-desc');
const detailDate = document.getElementById('detail-date');
const detailTag = document.getElementById('detail-tag');
const detailComments = document.getElementById('detail-comments');
const newCommentInput = document.getElementById('new-comment-input');
const addCommentBtn = document.getElementById('add-comment-btn');
const deleteTaskBtn = document.getElementById('delete-task-btn');


// --- State Management ---
// We generally load from local storage
let tasks = JSON.parse(localStorage.getItem('orbitTasks')) || [];
let currentOpenTaskId = null;


// --- Initialization ---
init();

function init() {
    renderBoard();
    updateTheme();
    setupDragAndDrop(); // Initialize Board Drop Zones
    setupCustomDropdowns();
}


// --- Theme Logic ---
themeToggle.addEventListener('click', () => {
    document.body.classList.toggle('dark-mode');
    const isDark = document.body.classList.contains('dark-mode');
    localStorage.setItem('orbitTheme', isDark ? 'dark' : 'light');
    updateThemeIcon(isDark);
});

function updateTheme() {
    const savedTheme = localStorage.getItem('orbitTheme');
    if (savedTheme === 'dark') {
        document.body.classList.add('dark-mode');
        updateThemeIcon(true);
    }
}

function updateThemeIcon(isDark) {
    themeToggle.innerHTML = isDark
        ? '<i class="ph ph-sun text-xl text-yellow-400"></i>'
        : '<i class="ph ph-moon text-xl text-slate-500"></i>';
}


// --- Custom Dropdown Logic ---
function setupCustomDropdowns() {
    const dropdowns = document.querySelectorAll('.custom-dropdown');

    dropdowns.forEach(dd => {
        const trigger = dd.querySelector('.dropdown-trigger');
        const optionsContainer = dd.querySelector('.dropdown-options');
        const options = dd.querySelectorAll('.dropdown-option');
        const hiddenInput = dd.querySelector('input[type="hidden"]');
        const labelDisplay = dd.querySelector('span[id$="-Label"]') || dd.querySelector('#filter-label');

        trigger.addEventListener('click', (e) => {
            e.stopPropagation();
            // Close all other dropdowns
            document.querySelectorAll('.dropdown-options').forEach(el => {
                if (el !== optionsContainer) el.classList.remove('active');
            });
            optionsContainer.classList.toggle('active');
        });

        options.forEach(opt => {
            opt.addEventListener('click', (e) => {
                e.stopPropagation();

                const value = opt.dataset.value;

                // Handle Custom Tag Logic
                if (value === 'Custom+') {
                    customTagContainer.classList.remove('hidden');
                    customTagInput.focus();
                    hiddenInput.value = 'Custom';
                    labelDisplay.innerHTML = '<i class="ph ph-pencil-simple"></i> Custom Pin';
                } else {
                    if (customTagContainer) customTagContainer.classList.add('hidden');
                    hiddenInput.value = value;
                    if (labelDisplay) {
                        labelDisplay.innerHTML = opt.innerHTML;
                    }
                }

                optionsContainer.classList.remove('active');

                // Trigger updates if it's a filter/sort dropdown
                if (hiddenInput.id === 'filter-tag' || hiddenInput.id === 'sort-value') {
                    renderBoard();
                }
            });
        });
    });

    // Close dropdowns on outside click
    document.addEventListener('click', () => {
        document.querySelectorAll('.dropdown-options').forEach(el => el.classList.remove('active'));
    });
}


// --- Task CRUD ---
addTaskBtn.addEventListener('click', () => {
    // Reset Defaults
    document.getElementById('task-tag').value = 'Design';
    document.getElementById('new-task-Label').innerHTML = '<span class="w-2 h-2 rounded-full bg-pink-400"></span> Design';
    customTagContainer.classList.add('hidden');
    customTagInput.value = '';
    taskTitleInput.value = '';
    taskDateInput.value = '';

    openModal(taskModal);
});

cancelBtn.addEventListener('click', () => closeModal(taskModal));

saveTaskBtn.addEventListener('click', () => {
    const title = taskTitleInput.value.trim();
    if (!title) return;

    let finalTag = taskTagInput.value;
    if (finalTag === 'Custom') {
        finalTag = customTagInput.value.trim() || 'Custom';
    }

    const newTask = {
        id: Date.now(),
        title: title,
        tag: finalTag,
        status: 'todo',
        dueDate: taskDateInput.value || null,
        description: '',
        comments: [],
        createdAt: new Date().toLocaleDateString()
    };

    tasks.push(newTask);
    saveAndRender();
    closeModal(taskModal);
});


// --- Details View ---
function openDetails(taskId) {
    const task = tasks.find(t => t.id === taskId);
    if (!task) return;
    currentOpenTaskId = taskId;

    detailTitle.textContent = task.title;
    detailDesc.value = task.description || '';

    // Tag Styling
    detailTag.textContent = task.tag;
    detailTag.className = getTagClass(task.tag) + " text-[10px] font-bold px-2 py-0.5 rounded-full uppercase tracking-wide";

    const dateStr = task.dueDate ? new Date(task.dueDate).toLocaleDateString(undefined, { month: 'short', day: 'numeric' }) : 'No Date';
    detailDate.innerHTML = `<i class="ph ph-calendar"></i> <span>${dateStr}</span>`;

    renderComments(task);
    openModal(detailsModal);
}

detailDesc.addEventListener('change', () => {
    const task = tasks.find(t => t.id === currentOpenTaskId);
    if (task) { task.description = detailDesc.value; saveData(); }
});

addCommentBtn.addEventListener('click', addComment);
newCommentInput.addEventListener('keypress', (e) => { if (e.key === 'Enter') addComment(); });

function addComment() {
    const text = newCommentInput.value.trim();
    if (!text) return;
    const task = tasks.find(t => t.id === currentOpenTaskId);
    if (task) {
        task.comments.push({ text: text, date: new Date().toLocaleTimeString([], { hour: '2-digit', minute: '2-digit' }) });
        renderComments(task);
        saveAndRender();
        newCommentInput.value = '';
    }
}

function renderComments(task) {
    detailComments.innerHTML = task.comments.map(c => `
        <div class="flex gap-3 text-sm">
            <div class="w-6 h-6 rounded-full bg-indigo-100 flex-shrink-0 flex items-center justify-center text-indigo-600 font-bold text-[10px] mt-1">U</div>
            <div>
                <div class="bg-slate-50 dark:bg-slate-700 p-3 rounded-tr-xl rounded-br-xl rounded-bl-xl border border-slate-100 dark:border-slate-600">
                    <p class="text-slate-700 dark:text-slate-200">${c.text}</p>
                </div>
                <span class="text-[10px] text-slate-400 pl-1">${c.date}</span>
            </div>
        </div>
    `).join('');
}

closeDetailsBtn.addEventListener('click', () => closeModal(detailsModal));

// --- Premium Delete UI Logic ---
const deleteBtnTrigger = document.getElementById('delete-btn-trigger');
const footerNormal = document.getElementById('detail-footer-normal');
const footerConfirm = document.getElementById('detail-footer-confirm');
const confirmDeleteBtn = document.getElementById('confirm-delete-btn');
const cancelDeleteBtn = document.getElementById('cancel-delete-btn');

deleteBtnTrigger.addEventListener('click', () => {
    footerNormal.classList.add('hidden');
    footerNormal.classList.remove('flex');
    footerConfirm.classList.add('flex');
    footerConfirm.classList.remove('hidden');
});

cancelDeleteBtn.addEventListener('click', () => {
    footerConfirm.classList.add('hidden');
    footerConfirm.classList.remove('flex');
    footerNormal.classList.add('flex');
    footerNormal.classList.remove('hidden');
});

confirmDeleteBtn.addEventListener('click', () => {
    // Find the card in DOM for animation
    const card = document.querySelector(`.task-card[data-id="${currentOpenTaskId}"]`);
    if (card) {
        card.style.transform = 'scale(0.8) translateY(-20px)';
        card.style.opacity = '0';
        card.style.pointerEvents = 'none';

        setTimeout(() => {
            tasks = tasks.filter(t => t.id !== currentOpenTaskId);
            saveAndRender();
        }, 300);
    } else {
        tasks = tasks.filter(t => t.id !== currentOpenTaskId);
        saveAndRender();
    }

    closeModal(detailsModal);

    // Reset footer for next open
    setTimeout(() => {
        footerConfirm.classList.add('hidden');
        footerConfirm.classList.remove('flex');
        footerNormal.classList.add('flex');
        footerNormal.classList.remove('hidden');
    }, 400);
});


// --- Rendering & Logic ---
function renderBoard() {
    // Safety: Unlock UI if it was stuck
    document.getElementById('board-container').classList.remove('dragging-mode');

    const searchTerm = searchInput.value.toLowerCase();
    const filterTag = filterTagInput.value;
    const sortMode = sortValueInput.value;

    // Filter
    let filteredTasks = tasks.filter(task => {
        const matchesSearch = task.title.toLowerCase().includes(searchTerm);
        let matchesTag = true;

        if (filterTag === 'Custom') {
            const standardTags = ['Design', 'Dev', 'Marketing', 'Urgent'];
            matchesTag = !standardTags.includes(task.tag);
        } else if (filterTag !== 'all') {
            matchesTag = task.tag === filterTag;
        }
        return matchesSearch && matchesTag;
    });

    // Sort
    filteredTasks.sort((a, b) => {
        if (sortMode === 'date-asc') return (a.dueDate || '9999').localeCompare(b.dueDate || '9999');
        if (sortMode === 'date-desc') return (b.dueDate || '').localeCompare(a.dueDate || '');
        if (sortMode === 'name-asc') return a.title.localeCompare(b.title);
        if (sortMode === 'name-desc') return b.title.localeCompare(a.title);
        return 0;
    });

    // Clear Columns
    document.querySelectorAll('.column-content').forEach(col => col.innerHTML = '');
    const counts = { todo: 0, progress: 0, done: 0 };

    // Inject
    filteredTasks.forEach(task => {
        if (!counts.hasOwnProperty(task.status)) return;
        counts[task.status]++;
        const column = document.querySelector(`.column-content[data-status="${task.status}"]`);
        const card = createCardElement(task);
        column.appendChild(card);
    });

    // Update Counts
    document.getElementById('count-todo').textContent = counts.todo;
    document.getElementById('count-progress').textContent = counts.progress;
    document.getElementById('count-done').textContent = counts.done;
}

function createCardElement(task) {
    const card = document.createElement('div');
    card.className = 'task-card bg-white p-4 rounded-xl shadow-sm border border-slate-100 mb-3 select-none flex flex-col gap-3 group';
    card.draggable = true;

    // Store ID for DataTransfer
    card.dataset.id = task.id;

    const tagClass = getTagClass(task.tag);

    // Deadline & Icons Logic
    let dateBadge = '';
    if (task.dueDate) {
        const today = new Date();
        const due = new Date(task.dueDate);
        const diffDays = Math.ceil((due - today) / (1000 * 60 * 60 * 24));
        let badgeStyle = 'bg-slate-50 dark:bg-slate-800 text-slate-500 border-slate-100 dark:border-slate-700';
        let iconColor = 'text-slate-400';
        if (diffDays < 0) { badgeStyle = 'badge-urgent'; iconColor = 'text-red-500'; }
        else if (diffDays <= 2) { badgeStyle = 'badge-upcoming'; iconColor = 'text-orange-500'; }
        dateBadge = `<span class="flex items-center gap-1 ${badgeStyle} text-[10px] px-2 py-0.5 rounded border"><i class="ph ph-calendar ${iconColor}"></i> ${due.toLocaleDateString(undefined, { month: 'short', day: 'numeric' })}</span>`;
    }
    const hasComments = task.comments && task.comments.length > 0 ? `<span class="flex items-center gap-1 text-xs text-slate-400"><i class="ph ph-chat-circle"></i> ${task.comments.length}</span>` : '';
    const hasDesc = task.description ? `<i class="ph ph-text-align-left text-slate-400 text-xs"></i>` : '';

    card.innerHTML = `
        <div class="flex justify-between items-start">
            <span class="${tagClass} text-[10px] font-bold px-2 py-1 rounded-full uppercase tracking-wide truncate max-w-[120px]">${task.tag}</span>
            <button class="opacity-0 group-hover:opacity-100 transition-opacity text-slate-300 hover:text-indigo-500" onclick="event.stopPropagation(); openDetails(${task.id})">
                <i class="ph ph-pencil-simple"></i>
            </button>
        </div>
        <p class="font-bold text-sm text-slate-700 leading-snug">${task.title}</p>
        <div class="flex items-center justify-between mt-1">
            <div class="flex items-center gap-2">
                ${dateBadge}
            </div>
            <div class="flex items-center gap-2">
                ${hasDesc}
                ${hasComments}
            </div>
        </div>
    `;

    card.addEventListener('click', () => openDetails(task.id));
    attachDragEvents(card);

    return card;
}

function getTagClass(tag) {
    const map = { 'Design': 'tag-design', 'Dev': 'tag-dev', 'Marketing': 'tag-marketing', 'Urgent': 'tag-urgent' };
    return map[tag] || 'bg-indigo-50 text-indigo-600 border border-indigo-100';
}


// --- DRAG AND DROP (Native HTML5 DataTransfer) ---

function attachDragEvents(card) {
    card.addEventListener('dragstart', (e) => {
        // STANDARD API: Send ID
        e.dataTransfer.setData('text/plain', card.dataset.id);
        e.dataTransfer.effectAllowed = 'move';

        // DELAY UI updates to allow drag to initialize
        // (Prevents browser from dropping drag due to pointer-events:none)
        setTimeout(() => {
            card.classList.add('dragging');
            document.getElementById('board-container').classList.add('dragging-mode');
        }, 0);
    });

    card.addEventListener('dragend', () => {
        card.classList.remove('dragging');
        document.getElementById('board-container').classList.remove('dragging-mode');

        // Cleanup UI highlights
        document.querySelectorAll('.column-content').forEach(col => col.classList.remove('bg-drop-active'));
    });
}

function setupDragAndDrop() {
    const columns = document.querySelectorAll('.column-content');

    columns.forEach(col => {
        col.addEventListener('dragover', (e) => {
            e.preventDefault(); // Allows Drop
            col.classList.add('bg-drop-active');
            e.dataTransfer.dropEffect = 'move';
        });

        col.addEventListener('dragleave', (e) => {
            // Check if leaving the COLUMN logic (robust check)
            if (e.relatedTarget && !col.contains(e.relatedTarget)) {
                col.classList.remove('bg-drop-active');
            }
        });

        col.addEventListener('drop', (e) => {
            e.preventDefault();
            col.classList.remove('bg-drop-active');

            // Retrieve Data
            const id = e.dataTransfer.getData('text/plain');
            const draggedTask = tasks.find(t => t.id == id);

            if (draggedTask) {
                const newStatus = col.dataset.status;
                if (draggedTask.status !== newStatus) {
                    draggedTask.status = newStatus;
                    saveAndRender();
                }
            }
        });
    });
}


// --- Modal Utils ---
function openModal(modal) {
    modal.classList.remove('hidden');
    void modal.offsetWidth;
    modal.classList.add('modal-open');
    modal.style.opacity = '1';
}

function closeModal(modal) {
    modal.style.opacity = '0';
    setTimeout(() => {
        modal.classList.remove('modal-open');
        modal.classList.add('hidden');
    }, 300);
}

function saveAndRender() {
    saveData();
    renderBoard();
}

function saveData() {
    localStorage.setItem('orbitTasks', JSON.stringify(tasks));
}
