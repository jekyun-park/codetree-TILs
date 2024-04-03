import Foundation

func dfs(_ vertex: Int) -> Int? {
    for v in graph[vertex] {
        if !visited[v] {
            visited[v] = true
            answer += 1
            dfs(v)
        }
    }

    return answer
}

var answer = 0
let nm = readLine()!.split(separator: " ").map { Int($0)! }
var graph: [[Int]] = Array(repeating: [], count: nm[0]+1)
var visited = Array(repeating: false, count: nm[0])

for _ in 0..<nm[1] {
    let startEnd = readLine()!.split(separator: " ").map { Int($0)! }
    graph[startEnd[0]].append(startEnd[1])
    graph[startEnd[1]].append(startEnd[0])
}

print(dfs(1)!-1)