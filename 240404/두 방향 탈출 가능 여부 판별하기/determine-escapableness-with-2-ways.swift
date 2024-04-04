import Foundation

let nm = readLine()!.split(separator: " ").map { Int($0)!}
let n = nm[0], m = nm[1]
var map: [[Int]] = []
var order = 1

for _ in 0..<n {
    map.append(readLine()!.split(separator: " ").map { Int($0)!})
}

var visited = Array(repeating: Array(repeating: false, count: m), count: n)
var answer = Array(repeating: Array(repeating: 0, count: m), count: n)

func dfs(_ x: Int, _ y: Int) {
    let dx = [1, 0]
    let dy = [0, 1]

    visited[x][y] = true

    for i in 0...1 {
        let nx = x + dx[i]
        let ny = y + dy[i]

        if canMoveTo(nx, ny) {
            visited[nx][ny] = true
            dfs(nx, ny)
            answer[ny][ny] = order
            order += 1
        }
    }

}

func isInRange(_ x: Int, _ y: Int) -> Bool {
    return (0..<n ~= x) && (0..<m ~= y)
}

func canMoveTo(_ x: Int, _ y: Int) -> Bool {
    if !isInRange(x, y) { return false }
    if (visited[x][y] || map[x][y] == 0) { return false }
    return true
}

visited[0][0] = true
answer[0][0] = order
dfs(0, 0)

print(answer[n-1][m-1] == 0 ? 0 : 1)