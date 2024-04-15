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

func isInRange(_ x: Int, _ y: Int) -> Bool {
    return ((0..<m) ~= x) && ((0..<n) ~= y)
}

func canMove(_ x: Int, _ y: Int) -> Bool {
    if !isInRange(x, y) { return false }
    if visited[y][x] || grid[y][x] == 0 { return false }
    return true
}

func bfs() {
    let dx = [0, 0, -1, 1]
    let dy = [-1, 1, 0, 0]

    while !queue.isEmpty {
        guard let (x, y) = queue.dequeue() else { return }

        for i in 0..<4 {
            let nx = x + dx[i]
            let ny = y + dy[i]

            if canMove(nx, ny) {
                visited[ny][nx] = true
                distance[ny][nx] = distance[y][x] + 1
                queue.enqueue((nx, ny))
            }
        }
    }
}

let nm = readLine()!.split(separator: " ").map { Int($0)! }
let n = nm[0], m = nm[1]
var grid = [[Int]]()
var visited = Array(repeating: Array(repeating: false, count: m), count: n)
var distance = Array(repeating: Array(repeating: 0, count: m), count: n)
var queue = Queue<(Int, Int)>()

for _ in 0..<n {
    grid.append(readLine()!.split(separator: " ").map { Int($0)! })
}

queue.enqueue((0, 0))
visited[0][0] = true
bfs()

print(distance[n-1][m-1])