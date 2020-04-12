import UIKit

/*
 
 You are given an undirected connected graph. An articulation point (or cut vertex) is defined as a vertex which, when removed along with associated edges, makes the graph disconnected (or more precisely, increases the number of connected components in the graph). The task is to find all articulation points in the given graph.

 Input:
 The input to the function/method consists of three arguments:

 numNodes, an integer representing the number of nodes in the graph.
 numEdges, an integer representing the number of edges in the graph.
 edges, the list of pair of integers - A, B representing an edge between the nodes A and B.
 Output:
 Return a list of integers representing the critical nodes.

 Example:

 Input: numNodes = 7, numEdges = 7, edges = [[0, 1], [0, 2], [1, 3], [2, 3], [2, 5], [5, 6], [3, 4]]
 Output: [2, 3, 5]
 
 Link: https://leetcode.com/discuss/interview-question/436073/
 */

//Linked List implementation
class Node{
    var data : Int?
    var next : Node?
    
    init(data : Int?, next : Node?) {
        self.data = data
        self.next = next
    }
}

//Graph Implementation
class Graph{
    private var indexTable : [Int : Node?] = [Int : Node?]()
    
    func addVertices(_ vertices : [Int]){
        for vertex in vertices{
            if !indexTable.keys.contains(vertex){
                indexTable.updateValue(nil, forKey: vertex)
            }
        }
    }
    
    //Add Edge
    func addEdge(_ u : Int,_ v : Int){
        if let root = indexTable[u] as? Node{
            var node : Node?  = root
            while node?.next != nil {
                node = node?.next
            }
            node?.next = Node(data: v, next: nil)
        }else{
            indexTable[u] = Node(data: v, next: nil)
        }
    }
    
    //Delete Edge
    func deleteEdge(_ u : Int,_ v : Int){
        if let root = indexTable[u] as? Node{
            if let data = root.data, v == data{
                indexTable[u] = nil
            }else{
                var node : Node? = root
                while node?.next != nil{
                    if v == node?.next?.data{
                        node?.next = node?.next?.next
                    }else{
                        node = node?.next
                    }
                }
            }
        }else{
            print("Edge (\(u),\(v)) does not exist")
        }
    }
    
    //isEdge
    func isEdge(_ u : Int,_ v : Int) -> Bool{
       if let root = indexTable[u] as? Node{
            if let data = root.data, v == data{
                return true
            }else{
                var node : Node? = root
                while node?.next != nil{
                    if v == node?.next?.data{
                        return true
                    }
                    node = node?.next
                }
            }
        }
        return false
    }
    
    //size
    func size() -> Int{
        return indexTable.count
    }
    
    func getAdjacentList(_ source : Int) -> Node?{
        return indexTable[source] as? Node
    }
    
    //Utility function to print graph
    func printGraph(){
        for (key,value) in indexTable{
            var row : String = "\(key) -> "
            if let value = value{
                var node : Node? = value
                while node != nil {
                    if let data = node?.data{
                        row.append("\(data)    ")
                    }
                    node = node?.next
                }
            }
            print(row)
        }
    }
}


//DFS recursive method
func DFSVisit(_ graph : Graph,_ current : Int,_ visited : inout [Bool]){
    visited[current] = true
    if let adjacentList = graph.getAdjacentList(current){
        var node : Node? = adjacentList
        while node != nil{
            if let data = node?.data, !visited[data]{
                DFSVisit(graph, data, &visited)
            }
            node = node?.next
        }
    }
}


func checkConnected(numNodes : Int, numEdges : Int, edges : [[Int]]) -> [Int]{
    var result : [Int] = [Int]()
    for i in 0..<numNodes{
        var newVertexArray = (0..<numNodes).filter {
            if $0 != i{
                return true
            }
            return false
        }
        
        var newEdgeArray = edges.filter {
            for element in $0{
                if element == i{
                    return false
                }
            }
            return true
        }
        
        let graph : Graph = Graph()
        graph.addVertices(newVertexArray)
        for edge in newEdgeArray{
            graph.addEdge(edge[0], edge[1])
            graph.addEdge(edge[1], edge[0])
        }
        
        var visited : [Bool] = Array.init(repeating: false, count: numNodes)
        DFSVisit(graph, newVertexArray[0], &visited)
        let filteredArr = visited.filter{$0 == false}
        if filteredArr.count > 1{
            result.append(i)
        }
    }
    return result
}

print(checkConnected(numNodes: 7, numEdges: 7, edges: [[0, 1], [0, 2], [1, 3], [2, 3], [2, 5], [5, 6], [3, 4]]))

