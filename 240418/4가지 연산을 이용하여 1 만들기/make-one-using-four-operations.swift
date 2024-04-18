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
var visited = Set<Int>()
visited.insert(N)
queue.enqueue((0, N))

while !queue.isEmpty {
    
    guard let (count, number) = queue.dequeue() else { break }
    
    if number == 1 {
        answer = count
        break
    } 
    
    if (number % 3 == 0) && !visited.contains(number/3) {
        visited.insert(number/3)
        queue.enqueue((count+1, number/3))
    } 
    if (number % 2 == 0) && !visited.contains(number/2){
        visited.insert(number/2)
        queue.enqueue((count+1, number/2))
    } 
    if !visited.contains(number-1) {
        visited.insert(number-1)
        queue.enqueue((count+1, number-1))
    }
    if !visited.contains(number+1){
        visited.insert(number+1)
        queue.enqueue((count+1, number+1))
    }
}

print(answer)