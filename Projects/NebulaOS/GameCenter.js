/**
 * @fileoverview Nebula OS Game Center - Arcade Logic
 */

export class GameCenter {
    constructor(windowManager) {
        this.windowManager = windowManager;
        this.games = [
            { id: 'ttt', title: 'Tic Tac Toe', icon: '❌', description: 'Classic 3x3 strategy vs AI.' },
            { id: 'mines', title: 'Minesweeper', icon: '💣', description: 'Logic-based mine defusal.' },
            { id: 'sudoku', title: 'Sudoku', icon: '🔢', description: 'Number placement puzzle.' }
        ];
    }

    open() {
        const content = `
            <div class="game-center-container" style="padding: 24px; color: white; height: 100%; display: flex; flex-direction: column; overflow: hidden;">
                <div class="hub-header" style="margin-bottom: 25px; border-bottom: 1px solid rgba(255,255,255,0.08); padding-bottom: 12px;">
                    <h3 style="font-size: 20px; font-weight: 700; color: #6366f1; letter-spacing: -0.5px;">Nebula Arcade</h3>
                    <p style="font-size: 11px; color: rgba(255,255,255,0.4); text-transform: uppercase; letter-spacing: 1px;">Universal Play Console</p>
                </div>
                <div class="game-grid" style="display: grid; grid-template-columns: repeat(auto-fit, minmax(100px, 1fr)); gap: 15px; width: 100%; max-width: 400px; margin: 0 auto; overflow-y: auto;">
                    ${this.games.map(game => `
                        <div class="game-item" data-id="${game.id}">
                            <div class="game-icon-container">
                                <div class="icon-glow"></div>
                                <div class="game-icon-main">${game.icon}</div>
                            </div>
                            <div class="game-title">${game.title}</div>
                        </div>
                    `).join('')}
                </div>
                <style>
                    .game-item {
                        display: flex;
                        flex-direction: column;
                        align-items: center;
                        gap: 12px;
                        cursor: pointer;
                        transition: all 0.4s cubic-bezier(0.175, 0.885, 0.32, 1.275);
                    }
                    .game-icon-container {
                        width: 80px;
                        height: 80px;
                        background: rgba(255, 255, 255, 0.03);
                        border: 1px solid rgba(255, 255, 255, 0.1);
                        border-radius: 20px;
                        display: flex;
                        align-items: center;
                        justify-content: center;
                        font-size: 36px;
                        position: relative;
                        overflow: hidden;
                        transition: all 0.3s;
                    }
                    .game-item:hover .game-icon-container {
                        background: rgba(99, 102, 241, 0.1);
                        border-color: #6366f1;
                        transform: translateY(-5px);
                        box-shadow: 0 10px 25px rgba(0,0,0,0.3);
                    }
                    .game-title {
                        font-size: 13px;
                        font-weight: 500;
                        color: rgba(255,255,255,0.8);
                        text-shadow: 0 2px 4px rgba(0,0,0,0.5);
                    }
                    .game-icon-main {
                        position: relative;
                        z-index: 2;
                    }
                    .icon-glow {
                        position: absolute;
                        width: 100%;
                        height: 100%;
                        background: radial-gradient(circle at var(--icon-mouse-x, 50%) var(--icon-mouse-y, 50%), rgba(99, 102, 241, 0.4) 0%, transparent 70%);
                        opacity: 0;
                        transition: opacity 0.3s;
                        z-index: 1;
                    }
                    .game-item:hover .icon-glow {
                        opacity: 1;
                    }
                </style>
            </div>
        `;

        const win = this.windowManager.createWindow({
            id: 'win-games',
            title: 'Arcade Hub',
            content: content,
            width: 480,
            height: 380,
            x: (window.innerWidth - 480) / 2,
            y: (window.innerHeight - 380) / 2
        });

        this.attachListeners(win);
    }

    attachListeners(win) {
        win.querySelectorAll('.game-item').forEach(item => {
            // Shine Follow Effect
            item.addEventListener('mousemove', (e) => {
                const rect = item.querySelector('.game-icon-container').getBoundingClientRect();
                const x = ((e.clientX - rect.left) / rect.width) * 100;
                const y = ((e.clientY - rect.top) / rect.height) * 100;
                item.style.setProperty('--icon-mouse-x', `${x}%`);
                item.style.setProperty('--icon-mouse-y', `${y}%`);
            });

            item.addEventListener('click', () => {
                const gameId = item.dataset.id;
                this.launchGame(gameId);
            });

            item.addEventListener('mouseenter', () => document.body.classList.add('cursor-hover'));
            item.addEventListener('mouseleave', () => document.body.classList.remove('cursor-hover'));
        });
    }

    showDifficultySelector(gameId) {
        const game = this.games.find(g => g.id === gameId);
        const win = this.windowManager.createWindow({
            id: `win-diff-${gameId}`,
            title: `Select Difficulty - ${game.title}`,
            content: `
                <div style="padding: 30px; text-align: center; color: white;">
                    <div style="font-size: 40px; margin-bottom: 20px;">${game.icon}</div>
                    <h3 style="margin-bottom: 25px; color: var(--primary);">Choose Your Level</h3>
                    <div style="display: flex; flex-direction: column; gap: 12px;">
                        <button class="diff-btn" data-level="easy" style="background: rgba(16, 185, 129, 0.1); border: 1px solid #10b981; color: #10b981; padding: 12px; border-radius: 8px; cursor: pointer; transition: all 0.3s;">EASY</button>
                        <button class="diff-btn" data-level="medium" style="background: rgba(99, 102, 241, 0.1); border: 1px solid #6366f1; color: #6366f1; padding: 12px; border-radius: 8px; cursor: pointer; transition: all 0.3s;">MEDIUM</button>
                        <button class="diff-btn" data-level="hard" style="background: rgba(239, 68, 68, 0.1); border: 1px solid #ef4444; color: #ef4444; padding: 12px; border-radius: 8px; cursor: pointer; transition: all 0.3s;">HARD</button>
                    </div>
                    <style>
                        .diff-btn:hover { transform: scale(1.02); filter: brightness(1.2); box-shadow: 0 0 15px currentColor; }
                    </style>
                </div>
            `,
            width: 350,
            height: 400
        });

        win.querySelectorAll('.diff-btn').forEach(btn => {
            btn.addEventListener('click', () => {
                this.windowManager.close(`win-diff-${gameId}`);
                const level = btn.dataset.level;
                if (gameId === 'ttt') this.startTicTacToe(level);
                if (gameId === 'mines') this.startMinesweeper(level);
                if (gameId === 'sudoku') this.startSudoku(level);
            });

            btn.addEventListener('mouseenter', () => document.body.classList.add('cursor-hover'));
            btn.addEventListener('mouseleave', () => document.body.classList.remove('cursor-hover'));
        });
    }

    launchGame(id) {
        this.showDifficultySelector(id);
    }

    startSudoku(level = 'easy') {
        const win = this.windowManager.createWindow({
            id: 'win-sudoku',
            title: `Sudoku (${level.toUpperCase()})`,
            content: `
                <div id="sudoku-game" style="padding: 20px; display: flex; flex-direction: column; align-items: center; justify-content: center; height: 100%; color: white;">
                    <div id="sudoku-grid" style="display: grid; grid-template-columns: repeat(9, 35px); gap: 1px; background: rgba(255,255,255,0.1); border: 2px solid rgba(255,255,255,0.2); border-radius: 4px; padding: 2px;">
                        ${Array(81).fill(0).map((_, i) => `<input class="sudoku-cell" type="text" maxlength="1" data-index="${i}" style="width: 35px; height: 35px; background: rgba(0,0,0,0.2); border: 1px solid rgba(255,255,255,0.05); color: white; text-align: center; font-size: 16px; outline: none;">`).join('')}
                    </div>
                    <div style="margin-top: 20px; display: flex; gap: 10px;">
                        <button id="sudoku-validate" style="padding: 10px 15px; background: var(--primary); border: none; border-radius: 8px; color: white; cursor: pointer;">Check Solution</button>
                        <button id="sudoku-reset" style="padding: 10px 15px; background: rgba(255,255,255,0.05); border: 1px solid rgba(255,255,255,0.1); border-radius: 8px; color: white; cursor: pointer;">New Puzzle</button>
                    </div>
                    <div id="sudoku-feedback" style="margin-top: 15px; font-size: 13px; font-weight: bold;"></div>
                    <style>
                        .sudoku-cell:focus { background: rgba(99, 102, 241, 0.2); }
                        .sudoku-cell.fixed { font-weight: bold; color: #6366f1; background: rgba(255,255,255,0.05); }
                    </style>
                </div>
            `,
            width: 420,
            height: 550
        });

        this.initSudoku(win, level);
    }

    initSudoku(win, level) {
        const inputs = win.querySelectorAll('.sudoku-cell');
        const validate = win.querySelector('#sudoku-validate');
        const reset = win.querySelector('#sudoku-reset');
        const feedback = win.querySelector('#sudoku-feedback');

        let solution = [];
        let puzzle = [];
        const clueCounts = { easy: 45, medium: 35, hard: 26 };

        const isSafe = (board, row, col, num) => {
            for (let x = 0; x <= 8; x++) if (board[row][x] === num) return false;
            for (let x = 0; x <= 8; x++) if (board[x][col] === num) return false;
            let startRow = row - row % 3, startCol = col - col % 3;
            for (let i = 0; i < 3; i++) {
                for (let j = 0; j < 3; j++) {
                    if (board[i + startRow][j + startCol] === num) return false;
                }
            }
            return true;
        };

        const solveSudoku = (board) => {
            let row = -1, col = -1, isEmpty = true;
            for (let i = 0; i < 9; i++) {
                for (let j = 0; j < 9; j++) {
                    if (board[i][j] === 0) {
                        row = i; col = j;
                        isEmpty = false; break;
                    }
                }
                if (!isEmpty) break;
            }
            if (isEmpty) return true;
            for (let num = 1; num <= 9; num++) {
                if (isSafe(board, row, col, num)) {
                    board[row][col] = num;
                    if (solveSudoku(board)) return true;
                    board[row][col] = 0;
                }
            }
            return false;
        };

        const generate = () => {
            solution = Array.from({ length: 9 }, () => Array(9).fill(0));
            // Fill diagonal 3x3 boxes
            for (let i = 0; i < 9; i += 3) {
                let nums = [1, 2, 3, 4, 5, 6, 7, 8, 9].sort(() => Math.random() - 0.5);
                for (let r = 0; r < 3; r++) {
                    for (let c = 0; c < 3; c++) {
                        solution[i + r][i + c] = nums.pop();
                    }
                }
            }
            solveSudoku(solution);

            // Create puzzle by hiding cells
            const targetClues = clueCounts[level];
            puzzle = solution.map(row => [...row]);
            let removed = 0;
            const cells = Array.from({ length: 81 }, (_, i) => i).sort(() => Math.random() - 0.5);

            while (removed < (81 - targetClues)) {
                const cell = cells.pop();
                const r = Math.floor(cell / 9), c = cell % 9;
                puzzle[r][c] = 0;
                removed++;
            }

            inputs.forEach((input, i) => {
                const r = Math.floor(i / 9), c = i % 9;
                input.value = puzzle[r][c] === 0 ? '' : puzzle[r][c];
                input.readOnly = puzzle[r][c] !== 0;
                input.classList.toggle('fixed', puzzle[r][c] !== 0);
                input.style.color = puzzle[r][c] !== 0 ? '#6366f1' : 'white';
            });
            feedback.textContent = '';
        };

        validate.addEventListener('click', () => {
            let userBoard = Array.from({ length: 9 }, () => Array(9).fill(0));
            let fullyFilled = true;
            inputs.forEach((input, i) => {
                const r = Math.floor(i / 9), c = i % 9;
                const val = parseInt(input.value);
                if (isNaN(val) || val < 1 || val > 9) {
                    if (!input.readOnly) fullyFilled = false;
                } else {
                    userBoard[r][c] = val;
                }
            });

            if (!fullyFilled) {
                feedback.textContent = "Please fill all cells correctly!";
                feedback.style.color = "#ef4444";
                return;
            }

            let correct = true;
            for (let r = 0; r < 9; r++) {
                for (let c = 0; c < 9; c++) {
                    if (userBoard[r][c] !== solution[r][c]) {
                        correct = false; break;
                    }
                }
            }

            if (correct) {
                feedback.textContent = "CORRECT SOLUTION!";
                feedback.style.color = "#10b981";
            } else {
                feedback.textContent = "INCORRECT SOLUTION. TRY AGAIN!";
                feedback.style.color = "#ef4444";
            }
        });

        reset.addEventListener('click', generate);
        generate();
    }

    startTicTacToe(level = 'medium') {
        const win = this.windowManager.createWindow({
            id: 'win-ttt',
            title: `Tic Tac Toe (${level.toUpperCase()})`,
            content: `
                <div id="ttt-game" style="padding: 20px; display: flex; flex-direction: column; align-items: center; justify-content: center; height: 100%; color: white;">
                    <div id="ttt-status" style="margin-bottom: 20px; font-weight: bold; color: #6366f1;">Your Turn (X)</div>
                    <div class="ttt-grid" style="display: grid; grid-template-columns: repeat(3, 80px); gap: 10px;">
                        ${Array(9).fill(0).map((_, i) => `<div class="ttt-cell" data-index="${i}" style="width: 80px; height: 80px; background: rgba(255,255,255,0.05); border: 1px solid rgba(255,255,255,0.1); border-radius: 8px; display: flex; align-items: center; justify-content: center; font-size: 32px; font-weight: bold; cursor: pointer;"></div>`).join('')}
                    </div>
                    <button id="ttt-reset" style="margin-top: 25px; padding: 10px 20px; background: var(--primary); border: none; border-radius: 8px; color: white; cursor: pointer;">Reset Game</button>
                    <style>
                        .ttt-cell:hover { background: rgba(255,255,255,0.1); }
                        .ttt-cell.taken { cursor: default; }
                    </style>
                </div>
            `,
            width: 350,
            height: 450
        });

        this.initTTTLite(win, level);
    }

    initTTTLite(win, level) {
        const cells = win.querySelectorAll('.ttt-cell');
        const status = win.querySelector('#ttt-status');
        const reset = win.querySelector('#ttt-reset');
        let board = Array(9).fill(null);
        let gameActive = true;

        const checkWinner = (v) => {
            const wins = [[0, 1, 2], [3, 4, 5], [6, 7, 8], [0, 3, 6], [1, 4, 7], [2, 5, 8], [0, 4, 8], [2, 4, 6]];
            for (let comb of wins) {
                if (v[comb[0]] && v[comb[0]] === v[comb[1]] && v[comb[0]] === v[comb[2]]) return v[comb[0]];
            }
            return v.every(c => c !== null) ? 'Draw' : null;
        };

        const minimax = (tempBoard, depth, isMaximizing) => {
            const result = checkWinner(tempBoard);
            if (result === 'O') return 10 - depth;
            if (result === 'X') return depth - 10;
            if (result === 'Draw') return 0;

            if (isMaximizing) {
                let bestScore = -Infinity;
                for (let i = 0; i < 9; i++) {
                    if (tempBoard[i] === null) {
                        tempBoard[i] = 'O';
                        let score = minimax(tempBoard, depth + 1, false);
                        tempBoard[i] = null;
                        bestScore = Math.max(score, bestScore);
                    }
                }
                return bestScore;
            } else {
                let bestScore = Infinity;
                for (let i = 0; i < 9; i++) {
                    if (tempBoard[i] === null) {
                        tempBoard[i] = 'X';
                        let score = minimax(tempBoard, depth + 1, true);
                        tempBoard[i] = null;
                        bestScore = Math.min(score, bestScore);
                    }
                }
                return bestScore;
            }
        };

        const getBestMove = () => {
            let bestScore = -Infinity;
            let move = null;
            for (let i = 0; i < 9; i++) {
                if (board[i] === null) {
                    board[i] = 'O';
                    let score = minimax(board, 0, false);
                    board[i] = null;
                    if (score > bestScore) {
                        bestScore = score;
                        move = i;
                    }
                }
            }
            return move;
        };

        const aiMove = () => {
            if (!gameActive) return;
            const available = board.map((c, i) => c === null ? i : null).filter(c => c !== null);
            if (available.length === 0) return;

            let move;
            if (level === 'easy') {
                move = available[Math.floor(Math.random() * available.length)];
            } else if (level === 'medium') {
                move = Math.random() > 0.5 ? getBestMove() : available[Math.floor(Math.random() * available.length)];
            } else { // 'hard'
                move = getBestMove();
            }

            board[move] = 'O';
            cells[move].textContent = 'O';
            cells[move].style.color = '#ef4444';
            cells[move].classList.add('taken');

            const winner = checkWinner(board);
            if (winner) {
                gameActive = false;
                status.textContent = winner === 'Draw' ? "It's a Draw!" : "AI Wins!";
            } else {
                status.textContent = "Your Turn (X)";
            }
        };

        cells.forEach(cell => {
            cell.addEventListener('click', () => {
                const idx = cell.dataset.index;
                if (!gameActive || board[idx]) return;

                board[idx] = 'X';
                cell.textContent = 'X';
                cell.style.color = '#6366f1';
                cell.classList.add('taken');

                const winner = checkWinner(board);
                if (winner) {
                    gameActive = false;
                    status.textContent = winner === 'Draw' ? "It's a Draw!" : "You Win!";
                } else {
                    status.textContent = "AI Thinking...";
                    setTimeout(aiMove, 600);
                }
            });
        });

        reset.addEventListener('click', () => {
            board = Array(9).fill(null);
            gameActive = true;
            status.textContent = "Your Turn (X)";
            cells.forEach(c => {
                c.textContent = '';
                c.classList.remove('taken');
            });
        });
    }

    startMinesweeper(level = 'easy') {
        const configs = {
            easy: { size: 10, bombs: 10, width: 380, height: 520 },
            medium: { size: 12, bombs: 20, width: 440, height: 580 },
            hard: { size: 14, bombs: 35, width: 500, height: 640 }
        };
        const config = configs[level];

        const win = this.windowManager.createWindow({
            id: 'win-mines',
            title: `Minesweeper (${level.toUpperCase()})`,
            content: `
                <div id="mines-game" style="padding: 20px; display: flex; flex-direction: column; align-items: center; justify-content: center; height: 100%; color: white;">
                    <div id="mines-header" style="width: 100%; display: flex; justify-content: space-between; margin-bottom: 20px; font-family: 'JetBrains Mono', monospace;">
                        <span id="mines-count" style="color: #ef4444;">💣 ${config.bombs}</span>
                        <span id="mines-status" style="color: #6366f1;">READY</span>
                        <span id="mines-timer">⏱️ 000</span>
                    </div>
                    <div id="mines-grid" style="display: grid; grid-template-columns: repeat(${config.size}, 30px); gap: 2px; padding: 10px; background: rgba(0,0,0,0.2); border-radius: 8px;">
                        ${Array(config.size * config.size).fill(0).map((_, i) => `<div class="mines-cell" data-index="${i}" style="width: 30px; height: 30px; background: rgba(255,255,255,0.05); border: 1px solid rgba(255,255,255,0.1); border-radius: 2px; display: flex; align-items: center; justify-content: center; font-size: 14px; font-weight: bold; cursor: pointer;"></div>`).join('')}
                    </div>
                    <button id="mines-reset" style="margin-top: 25px; padding: 10px 20px; background: var(--primary); border: none; border-radius: 8px; color: white; cursor: pointer;">New Mission</button>
                    <style>
                        .mines-cell:hover { background: rgba(255,255,255,0.1); border-color: #6366f1; }
                        .mines-cell.revealed { background: rgba(255,255,255,0.15); border: none; cursor: default; }
                        .mines-cell.bomb { background: #ef4444 !important; }
                        .mines-cell.flagged::after { content: '🚩'; font-size: 10px; }
                        
                        .mines-1 { color: #6366f1; }
                        .mines-2 { color: #10b981; }
                        .mines-3 { color: #ef4444; }
                        .mines-4 { color: #a16207; }
                    </style>
                </div>
            `,
            width: config.width,
            height: config.height
        });

        this.initMines(win, config);
    }

    initMines(win, config) {
        const cells = win.querySelectorAll('.mines-cell');
        const status = win.querySelector('#mines-status');
        const countLabel = win.querySelector('#mines-count');
        const timerLabel = win.querySelector('#mines-timer');
        const reset = win.querySelector('#mines-reset');

        const totalCells = config.size * config.size;
        let grid = Array(totalCells).fill(0);
        let revealed = Array(totalCells).fill(false);
        let flagged = Array(totalCells).fill(false);
        let bombs = [];
        let gameActive = true;
        let timer = 0;
        let timerInterval = null;

        const setup = () => {
            grid = Array(totalCells).fill(0);
            revealed = Array(totalCells).fill(false);
            flagged = Array(totalCells).fill(false);
            bombs = [];
            gameActive = true;
            timer = 0;
            clearInterval(timerInterval);
            timerLabel.textContent = `⏱️ 000`;
            status.textContent = 'READY';
            status.style.color = '#6366f1';
            countLabel.textContent = `💣 ${config.bombs}`;

            // Place bombs
            while (bombs.length < config.bombs) {
                const pos = Math.floor(Math.random() * totalCells);
                if (!bombs.includes(pos)) {
                    bombs.push(pos);
                    grid[pos] = -1;
                }
            }

            // Calculate numbers
            for (let i = 0; i < totalCells; i++) {
                if (grid[i] === -1) continue;
                let count = 0;
                const r = Math.floor(i / config.size), c = i % config.size;
                for (let dr = -1; dr <= 1; dr++) {
                    for (let dc = -1; dc <= 1; dc++) {
                        const nr = r + dr, nc = c + dc;
                        if (nr >= 0 && nr < config.size && nc >= 0 && nc < config.size) {
                            if (grid[nr * config.size + nc] === -1) count++;
                        }
                    }
                }
                grid[i] = count;
            }

            cells.forEach((cell, i) => {
                cell.textContent = '';
                cell.className = 'mines-cell';
                cell.style.background = '';
            });
        };

        const reveal = (i) => {
            if (!gameActive || revealed[i] || flagged[i]) return;

            if (timer === 0) {
                timerInterval = setInterval(() => {
                    timer++;
                    timerLabel.textContent = `⏱️ ${String(timer).padStart(3, '0')}`;
                }, 1000);
            }

            revealed[i] = true;
            const cell = cells[i];
            cell.classList.add('revealed');

            if (grid[i] === -1) {
                // Game Over
                gameActive = false;
                clearInterval(timerInterval);
                bombs.forEach(b => {
                    cells[b].classList.add('bomb');
                    cells[b].textContent = '💣';
                });
                status.textContent = 'MISSION FAILED';
                status.style.color = '#ef4444';
                return;
            }

            if (grid[i] > 0) {
                cell.textContent = grid[i];
                cell.classList.add(`mines-${grid[i]}`);
            } else {
                // Flood Fill
                const r = Math.floor(i / config.size), c = i % config.size;
                for (let dr = -1; dr <= 1; dr++) {
                    for (let dc = -1; dc <= 1; dc++) {
                        const nr = r + dr, nc = c + dc;
                        if (nr >= 0 && nr < config.size && nc >= 0 && nc < config.size) {
                            reveal(nr * config.size + nc);
                        }
                    }
                }
            }

            if (revealed.filter((r, idx) => !r && grid[idx] !== -1).length === 0) {
                gameActive = false;
                clearInterval(timerInterval);
                status.textContent = 'SECURE';
                status.style.color = '#10b981';
            }
        };

        cells.forEach((cell, i) => {
            let touchTimer;
            cell.addEventListener('mousedown', (e) => {
                if (e.button === 0) reveal(i);
                if (e.button === 2) {
                    e.preventDefault();
                    if (!gameActive || revealed[i]) return;
                    flagged[i] = !flagged[i];
                    cell.classList.toggle('flagged');
                    const flags = flagged.filter(f => f).length;
                    countLabel.textContent = `💣 ${config.bombs - flags}`;
                }
            });

            // Mobile Touch Support: Long Press to Flag
            cell.addEventListener('touchstart', (e) => {
                touchTimer = setTimeout(() => {
                    if (!gameActive || revealed[i]) return;
                    flagged[i] = !flagged[i];
                    cell.classList.toggle('flagged');
                    const flags = flagged.filter(f => f).length;
                    countLabel.textContent = `💣 ${config.bombs - flags}`;
                    // Vibrate if supported
                    if (navigator.vibrate) navigator.vibrate(50);
                }, 500);
            });

            cell.addEventListener('touchend', () => {
                clearTimeout(touchTimer);
            });

            cell.addEventListener('contextmenu', e => e.preventDefault());
        });

        reset.addEventListener('click', setup);
        setup();
    }
}
