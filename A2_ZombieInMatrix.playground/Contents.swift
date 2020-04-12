import UIKit

/*
    0 1 1 0 1
    0 1 0 1 0
    0 0 0 0 0
    0 1 0 0 0
 
    all servers can update their adjacent servers in 1 day. Calculate min no of days to update all servers, return -1 if servers can't be updated.
 
    0 represents out of date.
    1 represents updated server.
 
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

func minimumNumberOfDays(_ arr : inout [[Int]]) -> Int{
    var queue : IndexQueue = IndexQueue()
    let n = arr.count //rows
    let m = arr[0].count //columns
    
    var counter : Int = 0 //coutner to traverse each element
    var result : Int = 0 //store min num of days
    
    for i in 0..<n{
        for j in 0..<m{
            if arr[i][j] == 1{
                queue.push((i,j))
                counter = counter + 1
            }
        }
    }
    
    let dirs : [(Int,Int)] = [(0,1),(0,-1),(1,0),(-1,0)]
    while !queue.isEmpty() {
        if counter == n*m{
            return result
        }

        let size = queue.size()
        for _ in 0..<size{
            if let element = queue.pop(){
                for dir in dirs{
                    let idx = dir.0 + element.0
                    let idy = dir.1 + element.1
                    if idx >= 0 && idx < n && idy >= 0 && idy < m && arr[idx][idy] == 0{
                        counter = counter + 1
                        arr[idx][idy] = 1
                        queue.push((idx,idy))
                    }
                }
            }
        }
        result = result + 1
    }
    
    return -1
}

var arr : [[Int]] = [[0,1,1,0,1],
                    [0,1,0,1,0],
                    [0,0,0,0,1],
                    [0,1,0,0,0]]
print(minimumNumberOfDays(&arr))
