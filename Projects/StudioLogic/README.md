# Cyberpunk Nexus 2.0 | Master's Algorithm Suite

A high-fidelity, off-main-thread algorithmic command center designed for performance, educational clarity, and cinematic visual impact.

## Advanced Technical Architecture

### 1. Off-Main-Thread (OMT) Multi-Mode Engine
To maintain a rigid 60FPS fluid experience, Cyberpunk Nexus 2.0 implements a heavy-duty worker architecture:
- **Worker-Driven Rendering**: All logic (Sorting, Pathfinding, Maze Generation) and Rendering calculations occur in a dedicated Web Worker.
- **OffscreenCanvas**: Control of the main visualizer is transferred to the worker, isolating any main-thread UI jank from the actual data visualization.
- **UnifiedRenderer**: A single modular rendering class that switches seamlessly between Linear (Bar-based) and Grid (Coordinate-based) systems without object re-instantiation.

### 2. Logic-Sync & Educational HUD
- **Pseudocode Mapping**: ES6 Async Generators yield "line number signals," allowing the Main Thread to highlight specific lines of code in real-time as they execute in the background.
- **Operational Load Monitor**: A secondary Canvas-based graphing system that tracks algorithmic complexity (operations per frame) in real-time.

### 3. High-Fidelity Canvas VFX
- **Bloom Pass**: Implements multi-layered rendering to simulate neon light diffusion by blurring bright pixels and overlaying them with additive blending.
- **Particle System**: An efficient point-based system emitting "Data-bits" upon significant algorithmic events (swaps, node closures).
- **Chromatic Aberration**: Post-processing simulation of lens distortion during "Glitch" states (triggered by data mutations).

## Algorithmic Suite

### Sorting (Linear Domain)
- **QuickSort**: pivot-based recursive partitioning.
- **Radix Sort**: Non-comparative digit distribution.
- **Bubble Sort**: Iterative neighbor swap stabilization.

### Pathfinding & Mazes (Grid Domain)
- **A* Search**: Heuristic-guided shortest path optimization.
- **Dijkstra's**: Weight-based traversal (BFS-hybrid).
- **Recursive Backtracking**: Randomized depth-first maze synthesis.

## Engineering Standards
- **Message Batching**: Throttles worker-to-main communication to 16ms intervals to prevent message flooding.
- **Heuristic Flexibility**: Real-time switching between Manhattan, Euclidean, and Chebyshev metrics for A*.
- **JSDoc Documentation**: High-level documentation for technical review and maintainability.
