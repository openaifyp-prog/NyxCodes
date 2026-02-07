/**
 * @fileoverview Pseudocode mappings for the Logic-Sync HUD.
 */

export const Pseudocode = {
    quickSort: [
        "function quickSort(arr, left, right):",
        "  if left >= right: return",
        "  pivot = partition(arr, left, right)",
        "  quickSort(arr, left, pivot - 1)",
        "  quickSort(arr, pivot + 1, right)",
        "",
        "function partition(arr, left, right):",
        "  pivotValue = arr[right]",
        "  i = left - 1",
        "  for j = left to right - 1:",
        "    if arr[j] < pivotValue:",
        "      i++; swap(arr[i], arr[j])",
        "  swap(arr[i+1], arr[right])",
        "  return i + 1"
    ],
    aStar: [
        "while openSet is not empty:",
        "  current = node in openSet with lowest fScore",
        "  if current == end: return reconstruct_path(current)",
        "  remove current from openSet; add to visited",
        "  for each neighbor of current:",
        "    tentative_gScore = gScore[current] + 1",
        "    if tentative_gScore < gScore[neighbor]:",
        "      cameFrom[neighbor] = current",
        "      gScore[neighbor] = tentative_gScore",
        "      fScore[neighbor] = gScore[neighbor] + heuristic(neighbor)",
        "      if neighbor not in openSet: push(neighbor)"
    ],
    bubbleSort: [
        "for i from 0 to n-1:",
        "  for j from 0 to n-i-2:",
        "    if arr[j] > arr[j+1]:",
        "      swap(arr[j], arr[j+1])"
    ]
};
