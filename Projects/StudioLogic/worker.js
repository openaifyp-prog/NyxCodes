import { UnifiedRenderer, RENDER_MODE } from './engine.js';
import * as sorting from './algorithms/sorting.js';
import * as pathfinding from './algorithms/pathfinding.js';
import * as maze from './algorithms/maze.js';

let renderer = null;
let engine = null;
let statsBatch = { comparisons: 0, swaps: 0, operations: 0 };
let lastBatchTime = 0;
const BATCH_INTERVAL = 16;

/**
 * Debounced Pseudocode Sync state
 */
let pendingLineHighlight = -1;
let lastLineSyncTime = 0;
const LINE_SYNC_INTERVAL = 32; // ms (~30fps sync for readability)

function sendStats() {
    postMessage({ type: 'STATS_UPDATE', stats: statsBatch });
    lastBatchTime = performance.now();
}

function syncLineHighlight() {
    if (pendingLineHighlight !== -1) {
        postMessage({ type: 'HIGHLIGHT_LINE', line: pendingLineHighlight });
        lastLineSyncTime = performance.now();
        pendingLineHighlight = -1;
    }
}

function onEngineStatsUpdate(stats) {
    statsBatch = stats;
    const now = performance.now();
    if (now - lastBatchTime > BATCH_INTERVAL) sendStats();
}

function onLineHighlight(line) {
    pendingLineHighlight = line;
    const now = performance.now();
    if (now - lastLineSyncTime > LINE_SYNC_INTERVAL) {
        syncLineHighlight();
    }
}

onmessage = async (e) => {
    const { type, payload } = e.data;

    switch (type) {
        case 'INIT': {
            const { canvas, pixelRatio, width, height, mode } = payload;
            renderer = new UnifiedRenderer(canvas, pixelRatio);
            renderer.setMode(mode || RENDER_MODE.LINEAR);
            renderer.handleResize(width, height);
            break;
        }

        case 'SWITCH_MODE': {
            renderer.setMode(payload.mode);
            break;
        }

        case 'RESIZE': {
            renderer.handleResize(payload.width, payload.height);
            break;
        }

        case 'START': {
            const { algoName, mode, data, speed, heuristic } = payload;

            const { AlgorithmEngine } = await import('./engine.js');
            engine = new AlgorithmEngine(renderer, onEngineStatsUpdate, onLineHighlight);
            engine.setSpeed(speed);

            let generator;
            if (mode === RENDER_MODE.LINEAR) {
                engine.setArray(data);
                if (sorting[algoName]) generator = sorting[algoName](data);
            } else {
                engine.setGrid(data);
                if (algoName === 'aStar') generator = pathfinding.aStar(data, data.start, data.end, heuristic);
                if (algoName === 'dijkstra') generator = pathfinding.dijkstra(data, data.start, data.end);
                if (algoName === 'maze_backtracking') generator = maze.recursiveBacktracking(data);
            }

            if (generator) {
                renderer.start();
                await engine.run(generator);
                renderer.stop();
            }

            sendStats();
            syncLineHighlight(); // Final sync
            postMessage({ type: 'FINISHED' });
            break;
        }

        case 'STOP': {
            if (engine) engine.abort();
            if (renderer) {
                renderer.stop();
                renderer.render();
            }
            break;
        }
    }
};
