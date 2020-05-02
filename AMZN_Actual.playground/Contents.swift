import UIKit

func reorderElements(logFileSize:Int, logLines:[String]) -> [String]
{
    func isAllLowerCase(_ s: String) -> Bool {
        let cs = CharacterSet.lowercaseLetters
        for us in s.unicodeScalars {
            if !cs.contains(us) {
                return false
            }
        }
        return true
    }

    var stringLogs : [String] = [String]()
    var digitLogs : [String] = [String]()

    for logLine in logLines{
        let lineArray = logLine.components(separatedBy: " ")
        if lineArray.count > 1, isAllLowerCase(lineArray[1]){
            digitLogs.append(logLine)
        }else{
            stringLogs.append(logLine)
        }
    }

    stringLogs.sort { (first, second) -> Bool in
        if let index1 = Array(first).firstIndex(of: " "), let index2 = Array(second).firstIndex(of: " "){
            let log1 = first.substring(from: first.index(first.startIndex, offsetBy: index1))
            let log2 = second.substring(from: second.index(second.startIndex, offsetBy: index2))
            if log1.compare(log2) == .orderedSame{
                return first.compare(second) == .orderedAscending
            }
            return log1.compare(log2) == .orderedAscending
        }
        return false
    }
    stringLogs.append(contentsOf: digitLogs)
    return stringLogs
}


func popularNFeatures(numFeatures:Int,topFeatures:Int,
                      possibleFeatures:[String], numFeatureRequests:Int,
                      featureRequests:[String])->[String]
{
    // Define a map to store feature count
    var featureMap : [String : Int] = [String : Int]()

    for feature in possibleFeatures{ // O(numFeatures)
        featureMap[feature] = 0
    }

    // Traverse through every request, compare lowercased and update feature count
    for featureRequest in featureRequests{ // O(numFeatureRequests) * O(numFeatures)
        let lowerCasedRequest = featureRequest.lowercased()
        for feature in possibleFeatures{
            let lowerCasedFeature = feature.lowercased()
            if lowerCasedRequest.contains(lowerCasedFeature){
                if let value = featureMap[feature]{
                    featureMap[feature] = value + 1
                }
            }
        }
    }

    // sort featureMap
    var sortedFeatureMap = featureMap.sorted{ // O(numFeatures * log(numFeatures))
        return $0.value > $1.value
        }.sorted{
            if $0.value == $1.value{
                return $0.key < $1.key
            }
            return false
    }

    // Store result
    if topFeatures > numFeatures{
        return sortedFeatureMap.filter { return $0.value > 0 }.compactMap{ return $0.key }
    }else{
        return sortedFeatureMap[0..<topFeatures].compactMap{ return $0.key }
    }
}
