import Foundation

let nkm = readLine()!.split(separator: " ").map { Int($0)! }
let n = nkm[0], k = nkm[1], m = nkm[2]
var grid = [[Int]]()
var newGrid = [[Int]]()
var startPoints = [(Int, Int)]()
var stones = [(Int, Int)]()
var answer = Int.min
var count = 0
var visited = Array(repeating: Array(repeating: false, count: n), count: n)
var queue = Queue<(x: Int, y: Int)>()

for _ in 0..<n {
    grid.append(readLine()!.split(separator: " ").map { Int($0)! })
}

for _ in 0..<k {
    let point = readLine()!.split(separator: " ").map { Int($0)! }
    startPoints.append((point[0] - 1 , point[1] - 1))
}

for i in 0..<n {
    for j in 0..<n {
        if grid[i][j] == 1 {
            stones.append((i, j))
        }
    }
}

let cases = combination(stones, m)
// print(stones)

for points in cases {
    newGrid = grid
    for point in points {
        newGrid[point.0][point.1] = 0
    }
    
    for points in startPoints {
        bfs(points.0, points.1)
        answer = max(answer, count)
        visited = Array(repeating: Array(repeating: false, count: n), count: n)
        count = 1
    }
    
}

print(answer)


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

func bfs(_ x: Int, _ y: Int) {
    let dx = [-1, 1, 0, 0]
    let dy = [0, 0, -1, 1]
    count = 1

    queue.enqueue((x, y))
    visited[x][y] = true

    while !queue.isEmpty {
        guard let (x, y) = queue.dequeue() else { break }

        for i in 0..<4 {
            let nx = x + dx[i]
            let ny = y + dy[i]

            if canMove(nx, ny) {
                visited[nx][ny] = true
                count += 1
                queue.enqueue((nx, ny))
            }
        }
    }
}

func isInRange(_ x: Int, _ y: Int) -> Bool {
    return (0..<n ~= x) && (0..<n ~= y)
}

func canMove(_ x: Int, _ y: Int) -> Bool {
    if !isInRange(x, y) { return false }
    if visited[x][y] || newGrid[x][y] == 1  { return false }
    return true
}

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