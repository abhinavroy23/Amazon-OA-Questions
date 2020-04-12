import UIKit

/*
 Task:

 You work on a team whose job is to understand the most sought after toys for the holiday season. A teammate of yours has built a webcrawler that extracts a list of quotes about toys from different articles. You need to take these quotes and identify which toys are mentioned most frequently. Write an algorithm that identifies the top N toys out of a list of quotes and list of toys.

 Your algorithm should output the top N toys mentioned most frequently in the quotes.

 Input:

 The input to the function/method consists of five arguments:

 numToys, an integer representing the number of toys
 topToys, an integer representing the number of top toys your algorithm needs to return;
 toys, a list of strings representing the toys,
 numQuotes, an integer representing the number of quotes about toys;
 quotes, a list of strings that consists of space-sperated words representing articles about toys
 Output:

 Return a list of strings of the most popular N toys in order of most to least frequently mentioned

 Note:

 The comparison of strings is case-insensitive. If the value of topToys is more than the number of toys, return the names of only the toys mentioned in the quotes. If toys are mentioned an equal number of times in quotes, sort alphabetically.

 */

func getMostSoughtToysCount(numToys : Int,topToys : Int,toys : [String], numQuotes : Int, quotes : [String]) -> [String]{
    var hashMap : [String : Int] = [String : Int]()
    
    for toy in toys{ // O(numToys)
        hashMap[toy] = 0
    }

    for quote in quotes{ // O(numQuotes) * O(numToys)
        let lowerCasedQuote = quote.lowercased()
        for toy in toys{
            let lowerCasedToy = toy.lowercased()
            if lowerCasedQuote.contains(lowerCasedToy){
                if let value = hashMap[toy]{
                    hashMap[toy] = value + 1
                }
            }
        }
    }
    
    var sortedHashMap = hashMap.sorted{ // O(numToys * log(numToys))
        return $0.value > $1.value
    }.sorted{
        if $0.value == $1.value{
            return $0.key < $1.key
        }
        return false
    }
        
    var result : [String] = [String]()
    if topToys > numToys{
        for (key,value) in sortedHashMap{ // O(numToys)
            if value > 0{
                result.append(key)
            }
        }
    }else{
        for i in 0..<topToys{  // O(topToys)
            let element = sortedHashMap[i]
            result.append(element.key)
        }
    }
    return result
}

let numToys = 6
let topToys = 8
let toys = ["elmo", "elsa", "legos", "drone", "tablet", "warcraft"]
let numQuotes = 6
let quotes = ["Emo is the hottest of the season! Elmo will be on every kid's wishlist!",
"The new Elmo dolls are super high quality",
"Expect the Elsa dolls to be very popular this year",
"Elsa and Elmo are the toys I'll be buying for my kids",
"For parents of older kids, look into buying them a drone",
"Warcraft is slowly rising in popularity ahead of the holiday season"];

print(getMostSoughtToysCount(numToys: numToys, topToys: topToys, toys: toys, numQuotes: numQuotes, quotes: quotes))
