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
    return ((0..<n) ~= x) && ((0..<n) ~= y)
}

func canMove(_ x: Int, _ y: Int) -> Bool {
    if !isInRange(x, y) { return false }
    if visited[y][x] { return false }
    return true
}

func bfs() {
    let dx = [-1, 1, -1, 1, -2, -2, 2, 2]
    let dy = [-2, -2, 2, 2, -1, 1, -1, 1]

    while !queue.isEmpty {
        guard let (x, y) = queue.dequeue() else { return }

        for i in 0..<8 {
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

let n = Int(readLine()!)!
let points = readLine()!.split(separator: " ").map { Int($0)! - 1 }
let r1 = points[0], c1 = points[1], r2 = points[2], c2 = points[3]

if (r1 == r2) && (c1 == c2) {
    print(1)
} else {
    var visited = Array(repeating: Array(repeating: false, count: n), count: n)
    var distance = Array(repeating: Array(repeating: 0, count: n), count: n)
    var queue = Queue<(Int, Int)>()
    queue.enqueue((r1, c1))
    visited[r1][c1] = true

    bfs()
    print(distance[r2][c2] == 0 ? -1 : distance[r2][c2])
}