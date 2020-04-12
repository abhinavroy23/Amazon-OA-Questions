import UIKit

/*
 
 Given a 2d grid map of '1's (land) and '0's (water), count the number of islands. An island is surrounded by water and is formed by connecting adjacent lands horizontally or vertically. You may assume all four edges of the grid are all surrounded by water.

 Example 1:

 Input:
 11110
 11010
 11000
 00000

 Output: 1
 Example 2:

 Input:
 11000
 11000
 00100
 00011

 Output: 3
 
 */

func numIslands(_ grid : [[Int]]) -> Int{
    guard grid.count > 0, grid[0].count > 0 else{
        return 0
    }
    
    let n = grid.count
    let m = grid[0].count
    var visited : [[Bool]] = Array(repeating: Array(repeating: false, count: m), count: n)
    var islandCount = 0
    
    for i in 0..<n{
        for j in 0..<m{
            if grid[i][j] == 1 && !visited[i][j]{
                DFS(grid, i, j, &visited)
                islandCount = islandCount + 1
            }
        }
    }
    return islandCount
}

func DFS(_ grid : [[Int]],_ row : Int,_ col : Int,_ visited : inout [[Bool]]){
    //var adjRows : [Int] = [-1,-1,-1,0,0,1,1,1]
    //var adjCols : [Int] = [-1,0,1,-1,1,-1,0,1]
    
    var adjRows : [Int] = [-1,0,0,1]
    var adjCols : [Int] = [0,-1,1,0]
    
    visited[row][col] = true
    
    for i in 0..<adjRows.count{
        let r = row + adjRows[i]
        let c = col + adjCols[i]
        
        if r >= 0 && r < grid.count && c >= 0 && c < grid[0].count && grid[r][c] == 1 && !visited[r][c]{
            DFS(grid, r, c, &visited)
        }
    }
    
}

print(numIslands([[1,1,1,1,0], [1,1,0,1,0], [1,1,0,0,0], [0,0,0,0,0]]))
print(numIslands([[1,1,0,0,0],[1,1,0,0,0],[0,0,1,0,0],[0,0,0,1,1]]))
