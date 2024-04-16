import Foundation

struct Queue<T> {
    private var inbox: [T] = []
    private var outbox: [T] = []

    var isEmpty: Bool {
        return inbox.isEmpty && outbox.isEmpty
    }

    mutating func enqueue(_ element: T) {
        inbox.append(element)
    }

    mutating func dequeue() -> T? {
        if outbox.isEmpty {
            outbox = inbox.reversed()
            inbox.removeAll()
        }
        return outbox.popLast()
    }
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

func bfs(_ y: Int, _ x: Int) {
    let dy = [-1, 1, 0, 0]
    let dx = [0, 0, -1, 1]
    visited[y][x] = true
    queue.enqueue((y, x))

    while !queue.isEmpty {
        guard let (y, x) = queue.dequeue() else { return }

        for i in 0..<4 {
            let ny = y + dy[i]
            let nx = x + dx[i]

            if canMoveTo(ny, nx) {
                visited[ny][nx] = true
                distance[ny][nx] = distance[y][x] + 1
                queue.enqueue((ny, nx))
            }
        }
    }
}

func canMoveTo(_ y: Int, _ x: Int) -> Bool {
    if !isInRange(y, x) { return false }
    if grid[y][x] == 1 || visited[y][x] { return false }
    return true
}

func isInRange(_ y: Int, _ x: Int) -> Bool {
    return (0..<n ~= y) && (0..<n ~= x)
}

let nk = readLine()!.split(separator: " ").map { Int($0)! }
let n = nk[0], k = nk[1]
var wall = [(Int, Int)]()
var answer = Int.max
var visited = Array(repeating: Array(repeating: false, count: n), count: n)
var distance = Array(repeating: Array(repeating: 0, count: n), count: n)
var queue = Queue<(Int, Int)>()

// 0: 이동가능, 1: 벽
var originalMap = [[Int]]()
var grid = [[Int]]()
for _ in 0..<n {
    originalMap.append(readLine()!.split(separator: " ").map { Int($0)! })
}

let start = readLine()!.split(separator: " ").map { Int($0)! - 1 }
let r1 = start[0], c1 = start[1]
let end = readLine()!.split(separator: " ").map { Int($0)! - 1 }
let r2 = end[0], c2 = end[1]

for i in 0..<n {
    for j in 0..<n {
        if originalMap[i][j] == 1 {
            wall.append((i,j))
        }
    }
}

let chosen = combination(wall, k)

for walls in chosen {
    grid = originalMap
    for point in walls {
        grid[point.0][point.1] = 0
    }

    visited = Array(repeating: Array(repeating: false, count: n), count: n)
    distance = Array(repeating: Array(repeating: 0, count: n), count: n)

    bfs(r1, c1)

    if distance[r2][c2] != 0 {
        answer = min(answer, distance[r2][c2])
    }
}

print(answer == 0 ? -1 : answer)