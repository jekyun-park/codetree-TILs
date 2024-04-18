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
}

let N = Int(readLine()!)!
var queue = Queue<(count: Int, number: Int)>()
var answer = 0
var visited = Array(repeating: false, count:1_000_001)
visited[N] = true
queue.enqueue((0, N))

while !queue.isEmpty {
    
    guard let (count, number) = queue.dequeue() else { break }

    for i in 0..<4 {
        var newNumber = number

        switch i {
        case 0:
            newNumber -= 1
        case 1:
            newNumber += 1
        case 2:
            if newNumber % 3 == 0 {
                newNumber /= 3
            } else {
                continue
            }
        case 3:
            if newNumber % 2 == 0 {
                newNumber /= 2
            } else {
                continue
            }
        default:
            break
        }

        if check(newNumber) {
            if newNumber == 1 { 
                answer = count + 1
                break
            } else {
                visited[newNumber] = true
                queue.enqueue((count + 1, newNumber))
            }
        }
    }

}

func check(_ n: Int) -> Bool {
    if !isInRange(n) { return false }
    if visited[n] { return false }
    return true
}

func isInRange(_ n: Int) -> Bool {
    return (1...1_000_000) ~= n
}

print(answer)