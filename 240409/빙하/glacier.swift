import Foundation

let nm = readLine()!.split(separator: " ").map { Int($0)! }
let n = nm[0], m = nm[1]
var grid = [[Int]]()
var visited = Array(repeating: Array(repeating: false, count: m), count: n)
var queue = Queue<(Int, Int)>()
var glacierCount = 0
var time = 0
let dy = [-1, 1, 0, 0], dx = [0, 0, -1, 1]

for _ in 0..<n {
    grid.append(readLine()!.split(separator: " ").map { Int($0)! })
}

while true {
    simulate()
    if !isGlacierExist() { break }
}

print(time, glacierCount)

func isGlacierExist() -> Bool {
    return grid.flatMap { $0 }.filter { $0 == 1 }.count > 0
}

func simulate() {
    time += 1
    glacierCount = 0
    bfs()
    meltGlacier()
}

func meltGlacier() {
    for i in 0..<n {
        for j in 0..<m {
            if grid[i][j] == 1 && check(i, j) {
                grid[i][j] = 0
                glacierCount += 1
            }
        }
    }
}

func check(_ y: Int, _ x: Int) -> Bool {
    for i in 0..<4 {
        let ny = y + dy[i], nx = x + dx[i]
        if isInRange(ny, nx) && visited[ny][nx] {
            return true
        }
    }
    return false
}

func isGlacier(_ y: Int, _ x: Int) -> Bool {
    return isInRange(y, x) && (grid[y][x] == 1) && !visited[y][x]
}

func isInRange(_ y: Int, _ x: Int) -> Bool {
    return (0..<m ~= x) && (0..<n ~= y)
}

func canMove(_ y: Int, _ x: Int) -> Bool {
    if !isInRange(y, x) { return false }
    if visited[y][x] || grid[y][x] == 1 { return false }
    return true
}

func bfs() {
    visited[0][0] = true
    queue.enqueue((0, 0))

    while !queue.isEmpty {
        guard let (y, x) = queue.dequeue() else { return }
        for i in 0..<4 {
            let ny = y + dy[i]
            let nx = x + dx[i]

            if canMove(ny, nx) {
                visited[ny][nx] = true
                queue.enqueue((ny, nx))
            }
        }
    }
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