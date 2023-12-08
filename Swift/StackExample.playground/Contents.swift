import UIKit

struct StringStack { // pilha
    private var array: [String] = [String]()
    
    mutating func push(item: String) {
        array.append(item)
    }
    
    mutating func pop() -> String? {
        return array.popLast()
    }
    
    mutating func top() -> String? {
        return array.last
    }
    
    var isEmpty: Bool {
        return array.isEmpty
    }
}

var stack = StringStack()
print(stack.isEmpty)

stack.push(item: "firstItem")
print(stack.isEmpty)

print(stack.top() ?? "Pilha vazia")

stack.push(item: "secondItem")
print(stack.top() ?? "Pilha Vazia")

stack.pop()
print(stack.top() ?? "Pilha Vazia")
stack.pop()
print(stack.top() ?? "Pilha Vazia")

print(stack.isEmpty)
