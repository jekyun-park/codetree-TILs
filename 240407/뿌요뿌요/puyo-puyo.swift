import Foundation

let n = Int(readLine()!)!
var map = [[Int]]()
var answers = [Int]()
var count = 0
var visited = Array(repeating: Array(repeating: false, count: n), count: n)

for _ in 0..<n {
    map.append(readLine()!.split(separator: " ").map{ Int($0)! })
}

for i in 0..<n {
    for j in 0..<n {
        dfs(i,j)
        if count >= 3 {
            answers.append(count)
        }
        count = 0
    }
}

print(answers.count, answers.max()!+1)

func dfs(_ x: Int, _ y: Int) {
    let dx = [-1, 1, 0, 0]
    let dy = [0, 0, -1, 1]
    visited[x][y] = true

    for i in 0..<4 {
        let nx = x + dx[i]
        let ny = y + dy[i]

        if canMoveToNextBlock(nx, ny) {
            if map[x][y] == map[nx][ny] {
                visited[nx][ny] = true
                count += 1
                dfs(nx, ny)
            }
        }
    }

}

func canMoveToNextBlock( _ x: Int, _ y: Int) -> Bool {
    if !isInRange(x, y) { return false }
    if visited[x][y] { return false }
    return true
}

func isInRange( _ x: Int, _ y: Int) -> Bool {
    return ((0..<n ~= x) && (0..<n ~= y))
}