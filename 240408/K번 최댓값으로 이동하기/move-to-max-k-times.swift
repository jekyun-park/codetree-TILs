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
var visited = Array(repeating: Array(repeating: false, count: n), count: n)

for _ in 0..<n {
    grid.append(readLine()!.split(separator: " ").map { Int($0)! })
}

let rc = readLine()!.split(separator: " ").map { Int($0)! }
let r = rc[0] - 1, c = rc[1] - 1
var position = (r: r, c: c)
var queue = Queue<(Int, Int)>()
var maxValue = Int.min 

for _ in 0..<k {
    bfs(position.r, position.c)
    visited = Array(repeating: Array(repeating: false, count: n), count: n)
    maxValue = Int.min
}

print(position.r+1, position.c+1)

func bfs(_ x: Int, _ y: Int) {

    queue.enqueue((x, y))
    visited[x][y] = true
    let value = grid[x][y]
    
    let dx = [-1, 1, 0, 0]
    let dy = [0, 0, -1, 1]
    
    while !queue.isEmpty {

        guard let (x, y) = queue.dequeue() else { break }
        
        for i in 0..<4 {
            let nx = x + dx[i]
            let ny = y + dy[i]

            if canMoveTo(nx, ny, value) {
                visited[nx][ny] = true
                if grid[nx][ny] >= maxValue {
                    maxValue = grid[nx][ny]
                    if nx < position.r {
                        position = (nx, ny)
                    } else if nx == position.r {
                        if ny < position.c {
                            position = (nx, ny)
                        }
                    } else {
                        position = (nx, ny)
                    }
                }       
                queue.enqueue((nx, ny))
            }
        }

    }
}

func canMoveTo(_ x: Int, _ y: Int, _ value: Int) -> Bool {
    if !isInRange(x, y) { return false }
    if visited[x][y] || grid[x][y] >= value { return false }
    return true
}

func isInRange(_ x: Int, _ y: Int) -> Bool {
    return (0..<n ~= x) && (0..<n ~= y)
}