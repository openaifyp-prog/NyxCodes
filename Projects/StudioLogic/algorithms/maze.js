/**
 * @fileoverview Maze generation algorithms.
 */

export async function* recursiveBacktracking(gridData) {
    const { rows, cols, grid } = gridData;
    let visited = new Set();

    // Fill with walls
    for (let r = 0; r < rows; r++) {
        for (let c = 0; c < cols; c++) {
            grid[r][c] = 'wall';
        }
    }

    async function* carve(r, c) {
        visited.add(`${r},${c}`);
        grid[r][c] = 'empty';
        yield { type: 'grid_update', visited, path: [], line: 1 };

        const dirs = [[0, 2], [2, 0], [0, -2], [-2, 0]].sort(() => Math.random() - 0.5);

        for (let [dr, dc] of dirs) {
            const nr = r + dr;
            const nc = c + dc;

            if (nr >= 0 && nr < rows && nc >= 0 && nc < cols && !visited.has(`${nr},${nc}`)) {
                // Remove wall between
                grid[r + dr / 2][c + dc / 2] = 'empty';
                yield* carve(nr, nc);
            }
        }
    }

    yield* carve(0, 0);
}
