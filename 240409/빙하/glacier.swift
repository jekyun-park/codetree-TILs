import Foundation

let nm = readLine()!.split(separator: " ").map { Int($0)! }
let n = nm[0], m = nm[1]
var grid = [[Int]]()
var visited = Array(repeating: Array(repeating: false, count: m), count: n)
var queue = Queue<(Int, Int)>()
var water = Set<[Int]>()
var answer = 0
var time = 0

for _ in 0..<n {
    grid.append(readLine()!.split(separator: " ").map { Int($0)! })
}


while (grid.flatMap{ $0 }.reduce(0, +) != 0) {
    bfs(0, 0)
    answer = meltGlacier(water)
    visited = Array(repeating: Array(repeating: false, count: m), count: n)
    water.removeAll()
    time += 1
}

print(time, answer)

func meltGlacier(_ water: Set<[Int]>) -> Int {
    let dy = [-1, 1, 0, 0]
    let dx = [0, 0, -1, 1]
    var count = 0

    for point in water {
        for i in 0..<4 {
            let ny = point[0] + dy[i]
            let nx = point[1] + dx[i]

            if  isInRange(ny, nx) {
                if grid[ny][nx] == 1 {
                    grid[ny][nx] = 0
                    count += 1
                }
            }
        }
    }

    return count
}

func isInRange(_ y: Int, _ x: Int) -> Bool {
    return (0..<m ~= x) && (0..<n ~= y)
}

func canMove(_ y: Int, _ x: Int) -> Bool {
    if !isInRange(y, x) { return false }
    if visited[y][x] || grid[y][x] == 1 { return false }
    return true
}



func bfs(_ y: Int, _ x: Int) {

    let dy = [-1, 1, 0, 0]
    let dx = [0, 0, -1, 1]

    visited[y][x] = true
    water.insert([y, x])
    queue.enqueue((y, x))


    while !queue.isEmpty {

        guard let (y, x) = queue.dequeue() else { return }

        for i in 0..<4 {
            let ny = y + dy[i]
            let nx = x + dx[i]

            if canMove(ny, nx) {
                visited[ny][nx] = true
                water.insert([ny, nx])

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