import Foundation

struct Queue<T> {
    private var inBox: [T] = []
    private var outBox: [T] = []

    var isEmpty: Bool {
        return inBox.isEmpty && outBox.isEmpty
    }

    mutating func enqueue(_ element: T) {
        inBox.append(element)
    }

    mutating func dequeue() -> T? {
        if outBox.isEmpty {
            outBox = inBox.reversed()
            inBox.removeAll()
        }
        return outBox.popLast()
    }
}

let nkud = readLine()!.split(separator: " ").map { Int($0)! }
let n = nkud[0], k = nkud[1], u = nkud[2], d = nkud[3]
var grid = [[Int]]()
let dy = [-1, 1, 0, 0]
let dx = [0, 0, -1, 1]
var visited = Array(repeating: Array(repeating: false, count: n), count: n)
var heights = [(Int, Int)]()
var queue = Queue<(Int, Int)>()
var answer = Int.min, count = 0

for i in 0..<n {
    for j in 0..<n {
        heights.append((i, j))
    }
}

let coordinates = combination(heights, k)

for _ in 0..<n {
    grid.append(readLine()!.split(separator: " ").map { Int($0)! })
}

for points in coordinates {
    count = 1
    for point in points {
        bfs(point.1, point.0)
    }
    answer = max(count, answer)
    visited = Array(repeating: Array(repeating: false, count: n), count: n)
}

print(answer)

func bfs(_ x: Int, _ y: Int) {
    queue.enqueue((x, y))
    visited[y][x] = true

    while !queue.isEmpty {
        guard let (x, y) = queue.dequeue() else { return }
        
        for i in 0..<4 {
            let ny = y + dy[i]
            let nx = x + dx[i]

            if canMoveTo(nx, ny, grid[y][x]) {
                visited[ny][nx] = true
                count += 1
                queue.enqueue((nx, ny))
            }
        }

    }
}

func isInRange(_ x: Int, _ y: Int) -> Bool {
    return (0..<n ~= x) && (0..<n ~= y)
}

func canMoveTo(_ x: Int, _ y: Int, _ height: Int) -> Bool {
    if !isInRange(x, y) { return false }
    if visited[y][x] || !(u...d ~= abs(grid[y][x]-height)) { return false }
    return true
}

func combination(_ array: [(Int, Int)], _ targetCount: Int) -> [[(Int, Int)]] {
    var result = [[(Int, Int)]]()

    func recursion(_ index: Int, _ current: [(Int, Int)]) {
        if current.count == targetCount {
            result.append(current)
            return
        }

        for i in index..<array.count {
            recursion(i+1, current + [array[i]])
        }
    }

    recursion(0, [])

    return result
}