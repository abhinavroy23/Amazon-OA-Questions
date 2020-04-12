import UIKit

/*
 
 Given an array of strings products and a string searchWord. We want to design a system that suggests at most three product names from products after each character of searchWord is typed. Suggested products should have common prefix with the searchWord. If there are more than three products with a common prefix return the three lexicographically minimums products.

 Return list of lists of the suggested products after each character of searchWord is typed.

  

 Example 1:

 Input: products = ["mobile","mouse","moneypot","monitor","mousepad"], searchWord = "mouse"
 Output: [
 ["mobile","moneypot","monitor"],
 ["mobile","moneypot","monitor"],
 ["mouse","mousepad"],
 ["mouse","mousepad"],
 ["mouse","mousepad"]
 ]
 Explanation: products sorted lexicographically = ["mobile","moneypot","monitor","mouse","mousepad"]
 After typing m and mo all products match and we show user ["mobile","moneypot","monitor"]
 After typing mou, mous and mouse the system suggests ["mouse","mousepad"]
 Example 2:

 Input: products = ["havana"], searchWord = "havana"
 Output: [["havana"],["havana"],["havana"],["havana"],["havana"],["havana"]]
 Example 3:

 Input: products = ["bags","baggage","banner","box","cloths"], searchWord = "bags"
 Output: [["baggage","bags","banner"],["baggage","bags","banner"],["baggage","bags"],["bags"]]
 Example 4:

 Input: products = ["havana"], searchWord = "tatiana"
 Output: [[],[],[],[],[],[],[]]
  

 Constraints:

 1 <= products.length <= 1000
 There are no repeated elements in products.
 1 <= Σ products[i].length <= 2 * 10^4
 All characters of products[i] are lower-case English letters.
 1 <= searchWord.length <= 1000
 All characters of searchWord are lower-case English letters.
 
 */

func suggestedProducts(products : [String], keyword : String) -> [[String]]{
    var result : [[String]] = [[String]]()
    
    for i in 0..<keyword.count{
        let kwd = String(Array(keyword)[0...i])
        let res = products.filter{
            if $0.prefix(kwd.count) == kwd{
                return true
            }
            return false
        }
        if res.count > 3{
            result.append(Array(res.sorted().prefix(3)))
        }else{
            result.append(res.sorted())
        }
    }
    return result
}

print(suggestedProducts(products: ["mobile","mouse","moneypot","monitor","mousepad"], keyword: "mouse"))
print(suggestedProducts(products: ["havana"], keyword: "havana"))
print(suggestedProducts(products: ["bags","baggage","banner","box","cloths"], keyword: "bags"))
