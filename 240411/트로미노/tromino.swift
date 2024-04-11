import Foundation

let nm = readLine()!.split(separator: " ").map { Int($0)! }
let n = nm[0], m = nm[1]
var grid = [[Int]]()
var answer = Int.min

for _ in 0..<n {
    grid.append(readLine()!.split(separator: " ").map { Int($0)! })
}

func checkFirstBlock() {
    // 0
    var sum = 0
    for i in 0..<n-1 {
        for j in 0..<m-1 {
            sum += grid[i][j]
            sum += grid[i+1][j]
            sum += grid[i+1][j+1]
            answer = max(answer, sum)   
            sum = 0
        }
    }

    

    // 90
    for i in 0..<n-1 {
        for j in 0..<m-1 {
            sum += grid[i][j]
            sum += grid[i][j+1]
            sum += grid[i+1][j+1]
            answer = max(answer, sum)
            sum = 0
        }
        
    }

    // 180 
    for i in 0..<n-1 {
        for j in 1..<m {
            sum += grid[i][j]
            sum += grid[i+1][j]
            sum += grid[i+1][j-1] 
            answer = max(answer, sum)
            sum = 0
        }
        
    }

    for i in 0..<n-1 {
        for j in 0..<m-1 {
            sum += grid[i][j]
            sum += grid[i][j+1]
            sum += grid[i+1][j] 
            answer = max(answer, sum)
            sum = 0
        }
    }
}

func checkSecondBlock() {
    var sum = 0

    for i in 0..<n {
        for j in 0..<m-2 {
            sum += grid[i][j]
            sum += grid[i][j+1]
            sum += grid[i][j+2] 
            answer = max(answer, sum)
            sum = 0
        }
    }

    for i in 0..<n-2 {
        for j in 0..<m {
            sum += grid[i][j]
            sum += grid[i+1][j]
            sum += grid[i+2][j] 
            answer = max(answer, sum)
            sum = 0
        }
    }
}

checkFirstBlock()
checkSecondBlock()
print(answer)