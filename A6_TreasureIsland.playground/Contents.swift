import UIKit

/*
 
 You have a map that marks the location of a treasure island. Some of the map area has jagged rocks and dangerous reefs. Other areas are safe to sail in. There are other explorers trying to find the treasure. So you must figure out a shortest route to the treasure island.

 Assume the map area is a two dimensional grid, represented by a matrix of characters. You must start from the top-left corner of the map and can move one block up, down, left or right at a time. The treasure island is marked as X in a block of the matrix. X will not be at the top-left corner. Any block with dangerous rocks or reefs will be marked as D. You must not enter dangerous blocks. You cannot leave the map area. Other areas O are safe to sail in. The top-left corner is always safe. Output the minimum number of steps to get to the treasure.

 Example:

 Input:
 [['O', 'O', 'O', 'O'],
  ['D', 'O', 'D', 'O'],
  ['O', 'O', 'O', 'O'],
  ['X', 'D', 'D', 'O']]

 Output: 5
 Explanation: Route is (0, 0), (0, 1), (1, 1), (2, 1), (2, 0), (3, 0) The minimum route takes 5 steps.
 
 */

//Queue implementation
class IndexQueue{
    private var array : [(row : Int, col : Int)] = [(Int,Int)]()
    
    //push from rear
    func push(_ element : (Int,Int)){
        array.append(element)
    }
    
    //delete from front
    func pop() -> (Int,Int)?{
        if array.count > 0{
            let element = array[0]
            array.remove(at: 0)
            return element
        }
        return nil
    }
    
    func isEmpty() -> Bool{
        return array.count == 0
    }
    
    func size() -> Int{
        return array.count
    }
    
    func printQueue(){
        print(array)
    }
}

func findTreasure(_ matrix : [[Character]]) -> Int{
    guard matrix.count > 0, matrix[0].count > 0 else{
        return 0
    }
    
    let n = matrix.count
    let m = matrix[0].count
    var queue : IndexQueue = IndexQueue()
    var visited : [[Bool]] = Array(repeating: Array(repeating: false, count: m), count: n)
    
    queue.push((0,0))
    visited[0][0] = true
    var count : Int = 1
    
    while !queue.isEmpty(){
        let size = queue.size()
        
        for i in 0..<size{
            if let element = queue.pop(){
                
                let adjacent : [(Int,Int)] = [(0,-1),(-1,0),(0,1),(1,0)]
                
                for adj in adjacent{
                    let x = element.0 + adj.0
                    let y = element.1 + adj.1
                    
                    if x >= 0 && x < n && y >= 0 && y < m && matrix[x][y] != Character("D") && !visited[x][y]{
                        if matrix[x][y] == Character("O"){
                            queue.push((x,y))
                            visited[x][y] = true
                        }else if matrix[x][y] == Character("X"){
                            return count
                        }
                    }
                }
            }
        }
        count = count + 1
        queue.printQueue()
    }
    return -1
}

print(findTreasure([[Character("O"),Character("O"),Character("O"),Character("O")],
                    [Character("D"),Character("O"),Character("D"),Character("O")],
                    [Character("O"),Character("O"),Character("O"),Character("O")],
                    [Character("X"),Character("D"),Character("D"),Character("O")]]))
