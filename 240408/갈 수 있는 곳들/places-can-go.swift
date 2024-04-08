import Foundation

struct Queue<T> {
    private var inputStack: [T] = []
    private var outputStack: [T] = []

    var isEmpty: Bool {
        return inputStack.isEmpty && outputStack.isEmpty
    }

    mutating func enqueue(_ element: T) {
        inputStack.append(element)
    }

    mutating func dequeue() -> T? {
        if outputStack.isEmpty {
            outputStack = inputStack.reversed()
            inputStack.removeAll()
        }
        return outputStack.popLast()
    }
}

let nk = readLine()!.split(separator: " ").map { Int($0)! }
let n = nk[0], k = nk[1]
var grid = [[Int]]()
var starts = [(Int, Int)]()
var queue = Queue<(Int, Int)>()
var visited = Array(repeating: Array(repeating: false, count: n), count: n)
var count = 0
var answer = 0

for _ in 0..<n {
    grid.append(readLine()!.split(separator: " ").map { Int($0)! })
}

for _ in 0..<k {
    let input = readLine()!.split(separator: " ").map { Int($0)! }
    starts.append((input[0]-1, input[1]-1))
}

func bfs(_ x: Int, _ y: Int) {

    queue.enqueue((x, y))

    let dx = [-1, 1, 0, 0]
    let dy = [0, 0, -1, 1]

    visited[x][y] = true

    while !queue.isEmpty {

        guard let (x, y) = queue.dequeue() else { return }

        for i in 0..<4 {
            let nx = x + dx[i]
            let ny = y + dy[i]

            if canMoveTo(nx, ny) {
                visited[nx][ny] = true
                count += 1
                queue.enqueue((nx, ny))
            }
        }

    }

}

func canMoveTo(_ x: Int, _ y: Int) -> Bool {
    if !isInRange(x, y) { return false }
    if visited[x][y] || grid[x][y] == 1 { return false }
    return true
}

func isInRange(_ x: Int, _ y: Int) -> Bool {
    return (0..<n ~= x) && (0..<n ~= y)
}

for (x, y) in starts {
    grid[x][y] == 0 ? (count = 1) : (count = 0)
    if !visited[x][y] {
        bfs(x, y)
        answer += count
    }
}

print(answer)