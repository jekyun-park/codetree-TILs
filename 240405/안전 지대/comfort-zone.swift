import Foundation

let nm = readLine()!.split(separator: " ").map { Int($0)! } 
var originalMap = [[Int]]()

for _ in 0..<nm[0] {
    let input = readLine()!.split(separator: " ").map { Int($0)! } 
    originalMap.append(input)
}

let maxHeight = originalMap.flatMap{ $0 }.max()!
var visited = Array(repeating: Array(repeating: false, count: nm[1]), count: nm[0])
var results = [(k: Int, safeAreaCount: Int)]()
var count = 1
var map = [[Int]]()

for k in 1...maxHeight {
    map = originalMap.map{ $0.map{ $0 - k } }
    var safeArea = [Int]()
    
    for i in 0..<nm[0] {
        for j in 0..<nm[1] {
            if map[i][j] > 0 {
                count = 1
                dfs(i, j)
                safeArea.append(count) 
            }
        }
    }

    results.append((k, safeArea.count)) 
    safeArea.removeAll()
    visited = Array(repeating: Array(repeating: false, count: nm[1]), count: nm[0])
}

func dfs(_ x: Int, _ y: Int) {
    let dx = [-1, 1, 0, 0]
    let dy = [0, 0, -1, 1]

    visited[x][y] = true

    for i in 0..<4 {
        let nx = x + dx[i]
        let ny = y + dy[i]

        if isSafeArea(nx, ny) {
            visited[nx][ny] = true
            map[nx][ny] = 0
            count += 1
            dfs(nx, ny)
        }
    }
}

func isSafeArea(_ x: Int, _ y: Int) -> Bool {
    if !((0..<nm[0] ~= x) && (0..<nm[1] ~= y)) { return false }
    if (visited[x][y] || map[x][y] <= 0) { return false }
    return true
}

results.sort {
    if $0.safeAreaCount == $1.safeAreaCount {
        return $0.k < $1.k
    }
    return $0.safeAreaCount > $1.safeAreaCount
}

print(results.first!.k, results.first!.safeAreaCount)