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

var N = Int(readLine()!)!
var answer = 0

while N != 1 {
    if N % 3 == 0 {
        N /= 3
    } else if N % 2 == 0 {
        N /= 2
    } else if (N+1) % 3 == 0 {
        N += 1
    } else if (N-1) % 3 == 0 {
        N -= 1
    } else if (N+1) % 2 == 0 {
        N += 1
    } else if (N-1) % 2 == 0 {
        N -= 1
    }
    
    answer += 1
}

print(answer)