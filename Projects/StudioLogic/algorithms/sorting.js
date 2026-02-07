/**
 * @fileoverview sorting.js - Expanded sorting suite for Cyberpunk Nexus 2.0.
 */

export async function* bubbleSort(array) {
    const n = array.length;
    for (let i = 0; i < n; i++) {
        for (let j = 0; j < n - i - 1; j++) {
            yield { type: 'compare', indices: [j, j + 1], line: 1 };
            if (array[j] > array[j + 1]) {
                [array[j], array[j + 1]] = [array[j + 1], array[j]];
                yield { type: 'swap', indices: [j, j + 1], line: 3 };
            }
        }
    }
}

export async function* quickSort(array, left = 0, right = array.length - 1) {
    if (left >= right) {
        yield { line: 1 };
        return;
    }
    const pivotIndex = yield* partition(array, left, right);
    yield { line: 2 };
    yield* quickSort(array, left, pivotIndex - 1);
    yield { line: 3 };
    yield* quickSort(array, pivotIndex + 1, right);
    yield { line: 4 };
}

async function* partition(array, left, right) {
    const pivot = array[right];
    yield { line: 7 };
    let i = left - 1;
    yield { line: 8 };
    for (let j = left; j < right; j++) {
        yield { type: 'compare', indices: [j, right], line: 10 };
        if (array[j] < pivot) {
            i++;
            [array[i], array[j]] = [array[j], array[i]];
            yield { type: 'swap', indices: [i, j], line: 11 };
        }
    }
    [array[i + 1], array[right]] = [array[right], array[i + 1]];
    yield { type: 'swap', indices: [i + 1, right], line: 12 };
    return i + 1;
}

export async function* radixSort(array) {
    const max = Math.max(...array);
    for (let exp = 1; Math.floor(max / exp) > 0; exp *= 10) {
        yield* countSort(array, exp);
    }
}

async function* countSort(array, exp) {
    let output = new Array(array.length);
    let count = new Array(10).fill(0);

    for (let i = 0; i < array.length; i++) {
        count[Math.floor(array[i] / exp) % 10]++;
        yield { type: 'compare', indices: [i], line: 0 };
    }

    for (let i = 1; i < 10; i++) count[i] += count[i - 1];

    for (let i = array.length - 1; i >= 0; i--) {
        const digit = Math.floor(array[i] / exp) % 10;
        output[count[digit] - 1] = array[i];
        count[digit]--;
        yield { type: 'compare', indices: [i], line: 0 };
    }

    for (let i = 0; i < array.length; i++) {
        array[i] = output[i];
        yield { type: 'swap', indices: [i], line: 0 };
    }
}

// Merge Sort Implementation
export async function* mergeSort(array, start = 0, end = array.length - 1) {
    if (start >= end) return;
    const mid = Math.floor((start + end) / 2);
    yield* mergeSort(array, start, mid);
    yield* mergeSort(array, mid + 1, end);
    yield* mergeSync(array, start, mid, end);
}

async function* mergeSync(array, start, mid, end) {
    let left = array.slice(start, mid + 1);
    let right = array.slice(mid + 1, end + 1);
    let i = 0, j = 0, k = start;
    while (i < left.length && j < right.length) {
        yield { type: 'compare', indices: [start + i, mid + 1 + j], line: 0 };
        if (left[i] <= right[j]) {
            array[k] = left[i];
            i++;
        } else {
            array[k] = right[j];
            j++;
        }
        yield { type: 'swap', indices: [k], line: 0 };
        k++;
    }
    while (i < left.length) { array[k] = left[i]; i++; yield { type: 'swap', indices: [k] }; k++; }
    while (j < right.length) { array[k] = right[j]; j++; yield { type: 'swap', indices: [k] }; k++; }
}
