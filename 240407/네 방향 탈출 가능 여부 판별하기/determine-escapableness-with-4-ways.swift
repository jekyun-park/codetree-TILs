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
            outputStack = inputStack
            inputStack.removeAll()
        } 
        outputStack = outputStack.reversed()
        let result = outputStack.popLast()
        outputStack = outputStack.reversed()

        return result
    }
}

let nm = readLine()!.split(separator: " ").map{ Int($0)! } 
let n = nm[0], m = nm[1]
let dx = [-1, 1, 0, 0]
let dy = [0, 0, -1, 1]

var map = [[Int]]()
var visited = Array(repeating: Array(repeating: false, count: m), count: n)

for _ in 0..<n {
    map.append(readLine()!.split(separator: " ").map{ Int($0)! })
}

var queue = Queue<(x: Int, y: Int)>()
queue.enqueue((0,0))
visited[0][0] = true
var flag = false


while !queue.isEmpty {
    guard let (x, y) = queue.dequeue() else { break }

    if (x == n-1) && (y == m-1) { 
        flag = true
        break
    }

    for i in 0..<4 {
        let nx = x + dx[i]
        let ny = y + dy[i]

        if canMove(nx, ny) {
            visited[nx][ny] = true
            queue.enqueue((nx, ny))
        }
    }

}

print(flag ? 1 : 0)

func canMove(_ x: Int, _ y: Int) -> Bool {
    if !isInRange(x, y) { return false }
    if visited[x][y] || map[x][y] == 0 { return false }
    return true
}

func isInRange(_ x: Int, _ y: Int) -> Bool {
    return (0..<n ~= x) && (0..<m ~= y)
}