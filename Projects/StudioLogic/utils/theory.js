/**
 * @fileoverview Theoretical documentation for Studio Logic algorithms.
 */

export const Theory = {
    quickSort: {
        title: "Quick Sort",
        description: "A highly efficient, divide-and-conquer sorting algorithm. It works by selecting a 'pivot' element and partitioning the array into two sub-arrays: elements less than the pivot and elements greater than the pivot.",
        complexity: "O(n log n) average, O(n²) worst-case",
        useCase: "General purpose sorting where average-case performance is critical."
    },
    bubbleSort: {
        title: "Bubble Sort",
        description: "A simple comparison-based sorting algorithm. It repeatedly steps through the list, compares adjacent elements, and swaps them if they are in the wrong order.",
        complexity: "O(n²)",
        useCase: "Educational purposes or very small datasets where simplicity is preferred."
    },
    radixSort: {
        title: "Radix Sort",
        description: "A non-comparative sorting algorithm. It avoids comparison by creating and distributing elements into buckets based on their individual digits (or characters).",
        complexity: "O(nk)",
        useCase: "Sorting large numbers of integers or fixed-length strings."
    },
    aStar: {
        title: "A* Pathfinding",
        description: "An informed search algorithm that finds the shortest path between nodes. It uses a heuristic (like Manhattan distance) to estimate the cost to the goal, making it significantly faster than Dijkstra's.",
        complexity: "O(E log V)",
        useCase: "Video games, GPS navigation, and robotics."
    },
    dijkstra: {
        title: "Dijkstra's Algorithm",
        description: "A classic algorithm for finding the shortest paths between nodes in a graph. It is a special case of A* where the heuristic is always zero.",
        complexity: "O(E + V log V)",
        useCase: "Network routing protocols and general shortest-path problems."
    },
    maze_backtracking: {
        title: "Recursive Backtracking",
        description: "A randomized version of Depth-First Search used to generate perfect mazes. It carves paths by moving to random unvisited neighbors and backtracking when hitting a dead end.",
        complexity: "O(N)",
        useCase: "Procedural level generation and maze design."
    }
};
