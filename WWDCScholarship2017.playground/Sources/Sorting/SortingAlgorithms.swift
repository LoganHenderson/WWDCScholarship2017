import UIKit

public struct Algorithm {
    public let name: String
    public let runTime: String
}

public let bubbleSortAlg       = Algorithm(name: "Bubble Sort", runTime: "O(n\u{00B2})")
public let insertionSortAlg    = Algorithm(name: "Insertion Sort", runTime: "O(n\u{00B2})")
public let mergeSortAlg        = Algorithm(name: "Merge Sort", runTime: "O(nLog(n))")

public extension SortingAlgorithmView {
    
    
    func mergeSort(_ array: [Face]) -> [Face] {
        
        var arrayToSort = array
        
        guard arrayToSort.count > 1 else { return arrayToSort }
        
        let middleIndex = arrayToSort.count / 2
        let leftArray = mergeSort(Array(arrayToSort[0..<middleIndex]))
        let rightArray = mergeSort(Array(arrayToSort[middleIndex..<array.count]))
        
        algAnimations.append(ListAnimation(name: .accessAnimationType, indxs: (getIndexesFromFaceList(faces: leftArray), getIndexesFromFaceList(faces: rightArray))))
        algAnimations.append(ListAnimation(name: .mergeAnimationType, indxs: (getIndexesFromFaceList(faces: leftArray), getIndexesFromFaceList(faces: rightArray))))
        
        return merge(leftPile: leftArray, rightPile: rightArray)
    }
    
    func getIndexesFromFaceList(faces: [Face]) -> [Int] {
        var indexList: [Int]  = []
        
        for face in faces {
            indexList.append(face.indexInList)
        }
        
        return indexList
    }
    
    
    func merge(leftPile: [Face], rightPile: [Face]) -> [Face] {
        
        print("merge alg : \(getIndexesFromFaceList(faces: leftPile)) and \(getIndexesFromFaceList(faces: rightPile))")

        var leftIndex = 0
        var rightIndex = 0
        var orderedPile = [Face]()
        if orderedPile.capacity < leftPile.count + rightPile.count {
            orderedPile.reserveCapacity(leftPile.count + rightPile.count)
        }
        
        while leftIndex < leftPile.count && rightIndex < rightPile.count {
            if leftPile[leftIndex] < rightPile[rightIndex] {
                orderedPile.append(leftPile[leftIndex])
                leftIndex += 1
            } else if leftPile[leftIndex] > rightPile[rightIndex] {
                orderedPile.append(rightPile[rightIndex])
                rightIndex += 1
            } else {
                orderedPile.append(leftPile[leftIndex])
                leftIndex += 1
                orderedPile.append(rightPile[rightIndex])
                rightIndex += 1
            }
        }
        
        while leftIndex < leftPile.count {
            orderedPile.append(leftPile[leftIndex])
            leftIndex += 1
        }
        
        while rightIndex < rightPile.count {
            orderedPile.append(rightPile[rightIndex])
            rightIndex += 1
        }
        
        print("ordered pile : \(orderedPile)")
        return orderedPile
    }

    public func insertionSort(faces: [Face]) -> ([ListAnimation]) {
        
        var animations: [ListAnimation] = []
        var arrayToSort = faces
        
            for i in 1 ..< faces.count {
                
                var position = i
                let temp = arrayToSort[position]
                
                // the only purpose of the if condition below is to add a single access animation if the while loop does not execute a single time because an access would still have occured one time
                if !(position > 0 && temp > arrayToSort[position - 1]) {
                    animations.append(ListAnimation(name: .accessAnimationType, indxs: ([position - 1], [i])))
                }
                
                while position > 0 && temp > arrayToSort[position - 1] {
                    animations.append(ListAnimation(name: .accessAnimationType, indxs: ([position], [i])))
                    arrayToSort[position] = arrayToSort[position - 1]
                    position -= 1
                }

                animations.append(ListAnimation(name: .insertAnimationType, indxs: ([position], [i])))
                arrayToSort[position] = temp
            }
        
        return animations
    }

    public func bubbleSort(faces: [Face]) -> [ListAnimation] {
        
        var animations: [ListAnimation] = []
        var arrayToSort = faces
        var sortedAboveIndex = arrayToSort.count
        
        
        while sortedAboveIndex != 0 {
            var lastSwapIndex = 0
            for i in 1 ..< sortedAboveIndex {
                animations.append(ListAnimation(name: .accessAnimationType, indxs: ([i - 1], [i])))

                if (arrayToSort[i - 1] < arrayToSort[i]) {
                    
                    animations.append(ListAnimation(name: .swapAnimationType, indxs: ([i - 1], [i])))
                    swap(&arrayToSort[i - 1], &arrayToSort[i])
                    
                    lastSwapIndex = i
                }
            }
            sortedAboveIndex = lastSwapIndex
        }
        
        return animations
    }
}
