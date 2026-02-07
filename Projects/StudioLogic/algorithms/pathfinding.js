/**
 * @fileoverview Pathfinding algorithms for the Cyberpunk Nexus 2.0.
 */

/**
 * A* Pathfinding Algorithm.
 */
export async function* aStar(grid, start, end, heuristic = 'manhattan') {
    const { rows, cols } = grid;
    const startNode = parsePos(start);
    const endNode = parsePos(end);

    let openSet = [startNode];
    let cameFrom = new Map();
    let gScore = new Map();
    let fScore = new Map();

    gScore.set(start, 0);
    fScore.set(start, getHeuristic(startNode, endNode, heuristic));

    let visited = new Set();

    while (openSet.length > 0) {
        // Line 1: Sort openSet by fScore
        openSet.sort((a, b) => fScore.get(posStr(a)) - fScore.get(posStr(b)));
        let current = openSet.shift();
        let currentStr = posStr(current);

        if (currentStr === end) {
            yield { type: 'grid_update', visited, path: reconstructPath(cameFrom, currentStr), line: 10 };
            return;
        }

        visited.add(currentStr);
        yield { type: 'grid_update', visited, path: [], line: 2 };

        for (let neighbor of getNeighbors(current, grid)) {
            let neighborStr = posStr(neighbor);
            if (visited.has(neighborStr)) continue;

            let tentativeGScore = gScore.get(currentStr) + 1;

            if (!gScore.has(neighborStr) || tentativeGScore < gScore.get(neighborStr)) {
                cameFrom.set(neighborStr, currentStr);
                gScore.set(neighborStr, tentativeGScore);
                fScore.set(neighborStr, tentativeGScore + getHeuristic(neighbor, endNode, heuristic));

                if (!openSet.find(n => posStr(n) === neighborStr)) {
                    openSet.push(neighbor);
                }
            }
        }
        yield { type: 'grid_update', visited, path: [], line: 5 };
    }
}

/**
 * Dijkstra's Algorithm.
 */
export async function* dijkstra(grid, start, end) {
    yield* aStar(grid, start, end, 'none'); // Dijkstra is A* with zero heuristic
}

// Helpers
function parsePos(str) {
    const [r, c] = str.split(',').map(Number);
    return { r, c };
}

function posStr(node) {
    return `${node.r},${node.c}`;
}

function getNeighbors(node, gridData) {
    const { r, c } = node;
    const { rows, cols, grid } = gridData;
    const neighbors = [];
    const dirs = [[0, 1], [1, 0], [0, -1], [-1, 0]];

    for (let [dr, dc] of dirs) {
        const nr = r + dr;
        const nc = c + dc;
        if (nr >= 0 && nr < rows && nc >= 0 && nc < cols && grid[nr][nc] !== 'wall') {
            neighbors.push({ r: nr, c: nc });
        }
    }
    return neighbors;
}

function getHeuristic(a, b, type) {
    if (type === 'none') return 0;
    const dr = Math.abs(a.r - b.r);
    const dc = Math.abs(a.c - b.c);

    switch (type) {
        case 'manhattan': return dr + dc;
        case 'euclidean': return Math.sqrt(dr * dr + dc * dc);
        case 'chebyshev': return Math.max(dr, dc);
        default: return 0;
    }
}

function reconstructPath(cameFrom, current) {
    const path = [current];
    while (cameFrom.has(current)) {
        current = cameFrom.get(current);
        path.unshift(current);
    }
    return path;
}
