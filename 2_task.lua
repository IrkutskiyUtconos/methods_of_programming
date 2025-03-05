function shellSort(arr, steps)
    local n = #arr
    local comparisons = 0

    for _, step in ipairs(steps) do
        for i = step + 1, n do
            local temp = arr[i]
            local j = i
            while j > step and arr[j - step] > temp do
                arr[j] = arr[j - step]
                j = j - step
                comparisons = comparisons + 1
            end
            arr[j] = temp
        end
    end

    return comparisons
end

function printArray(arr)
    for i, v in ipairs(arr) do
        io.write(v, " ")
    end
    io.write("\n")
end

local arr = {5, 3, 8, 4, 6, 1, 7, 2, 9, 0}
local steps = {5, 3, 1}

print("Изначальный массив:")
printArray(arr)

print("Массив шагов:")
printArray(steps)

local comparisons = shellSort(arr, steps)

print("Отсортированный массив:")
printArray(arr)

print("Количество сравнений:", comparisons)

function generateRandomArray(n)
    local arr = {}
    for i = 1, n do
        arr[i] = math.random(1, 1000)
    end
    return arr
end

function generateSteps(n)
    local steps = {}
    local step = n / 2
    while step >= 1 do
        table.insert(steps, step)
        step = math.floor(step / 2)
    end
    return steps
end

local arr100 = generateRandomArray(100)
local steps100 = generateSteps(100)

print("Изначальный массив (N=100):")
printArray(arr100)

print("Массив шагов (N=100):")
printArray(steps100)

local comparisons100 = shellSort(arr100, steps100)

print("Отсортированный массив (N=100):")
printArray(arr100)

print("Количество сравнений (N=100):", comparisons100)

local arr1000 = generateRandomArray(1000)
local steps1000 = generateSteps(1000)

print("Изначальный массив (N=1000):")
printArray(arr1000)

print("Массив шагов (N=1000):")
printArray(steps1000)

local comparisons1000 = shellSort(arr1000, steps1000)

print("Отсортированный массив (N=1000):")
printArray(arr1000)

print("Количество сравнений (N=1000):", comparisons1000)

function generateBinaryArray(n)
    local arr = {}
    for i = 1, n do
        arr[i] = math.random(0, 1)
    end
    return arr
end

local binaryArr1000 = generateBinaryArray(1000)
local stepsBinary1000 = generateSteps(1000)

print("Изначальный массив (N=1000, бинарный):")
printArray(binaryArr1000)

print("Массив шагов (N=1000, бинарный):")
printArray(stepsBinary1000)

local comparisonsBinary1000 = shellSort(binaryArr1000, stepsBinary1000)

print("Отсортированный массив (N=1000, бинарный):")
printArray(binaryArr1000)

print("Количество сравнений (N=1000, бинарный):", comparisonsBinary1000)

local arr10 = generateRandomArray(10)
local steps10 = generateSteps(10)

print("Изначальный массив (N=10):")
printArray(arr10)

print("Массив шагов (N=10):")
printArray(steps10)

local comparisons10 = shellSort(arr10, steps10)

print("Отсортированный массив (N=10):")
printArray(arr10)

print("Количество сравнений (N=10):", comparisons10)
