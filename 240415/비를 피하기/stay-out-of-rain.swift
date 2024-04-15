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

    mutating func removeAll() {
        inbox.removeAll()
        outbox.removeAll()
    }
}

func isInRange(_ x: Int, _ y: Int) -> Bool {
    return ((0..<n) ~= x) && ((0..<n) ~= y)
}

func canMove(_ x: Int, _ y: Int) -> Bool {
    if !isInRange(x, y) { return false }
    if visited[y][x] || grid[y][x] == 1 { return false }
    return true
}

func bfs(_ x: Int, _ y: Int) {
    var findShelter = false

    queue.enqueue((x, y))
    visited[y][x] = true

    let dx = [0, 0, -1, 1]
    let dy = [-1, 1, 0, 0]

    while !queue.isEmpty {
        guard let (x, y) = queue.dequeue() else { break }

        for i in 0..<4 {
            let nx = x + dx[i]
            let ny = y + dy[i]

            if canMove(nx, ny) {
                visited[ny][nx] = true
                distances[ny][nx] = distances[y][x] + 1
                queue.enqueue((nx, ny))
                if grid[ny][nx] == 3 {
                    currentMinimum = min(currentMinimum, distances[y][x] + 1)
                    findShelter = true
                    break
                }
            }
        }
        if findShelter { break }
    }
}

let nhm = readLine()!.split(separator: " ").map { Int($0)! }
let n = nhm[0], h = nhm[1], m = nhm[2]
var grid = [[Int]]()
var visited = Array(repeating: Array(repeating: false, count: n), count: n)
var distances = Array(repeating: Array(repeating: 0, count: n), count: n)
var answer = Array(repeating: Array(repeating: 0, count: n), count: n)
var queue = Queue<(Int, Int)>()
var currentMinimum = Int.max

for _ in 0..<n {
    grid.append(readLine()!.split(separator: " ").map { Int($0)! })
}

for i in 0..<n {
    for j in 0..<n {
        if grid[i][j] == 2 { 
            currentMinimum = Int.max
            distances = Array(repeating: Array(repeating: 0, count: n), count: n)
            visited = Array(repeating: Array(repeating: false, count: n), count: n)
            queue.removeAll()
            bfs(j, i) 
            
            if currentMinimum != Int.max {
                answer[i][j] = currentMinimum
            } else {
                answer[i][j] = -1
            }
        }
    }
}

for i in 0..<n {
    for j in 0..<n {
        print(answer[i][j], terminator: " ")
    }
    print()
}