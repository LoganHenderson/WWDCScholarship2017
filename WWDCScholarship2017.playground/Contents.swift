import UIKit
import PlaygroundSupport


let frame = CGRect(x: 0, y: 0, width: 400, height: 600)

let algView = AlgorithmContainerView(frame: frame)
PlaygroundPage.current.liveView = algView

/*:
# Sorting Made Easy
 In this playground you are going to learn about three of the most popular sorting algorithms in computer science: Bubble Sort, Insertion Sort, and Merge Sort. To accomplish this I've enlisted help from my close freinds and coworkers. Ive gathered some photos of us and now you will watch this playground sort each myself, my freinds, and my cowokers by height from shortest to tallest. In these demos feel free to grab onto any elements in the list to move them around. This is a fully interactive lesson that allows you to move elements in the list before, during or after they are sorted. After you move them they will recalculate the sort and you can continue sorting. This way you can visualize how these lists are sorted when they are almost sorted, completely random, or in reverse order. Furthermore, you can adjust the slider located above face list to adjust the speed of the animations.
 */

/*:
### Bubble Sort

Bubble sort is the simplest of the sorting algorithms as well as the worst performing. Bubble Sort has a worst case run time of O(n^2). Algorithms with a run time of O(n^2) are said to be "quadratic" because the time it takes to execute increases exponentially (by a power of 2) for each additional element in a list. Bubble sort works by iterating through a list and comparing each element to the element adjacent to it. If the element precedees an element that has a lower value than the elements will swap. This will continue until the algorithm makes a full iteration through the list without finding any adjacent elements in which an element is smaller than the element preceeding it.

If you watch the animation closely you can see that as the algorithm runs it will "bubble" up largest element to the top of the list at each iteration. Hence the name, Bubble Sort.
*/

/*:
### Insertion Sort
Insertion sort is another sorting algorithm with a worst case run time of O(n^2). Unlike most other quadratic algorithms, insertion sort has quite a few benefits. Insertion sort is very efficient for datasets that are already almost sorted. Insertion sort works by sorting a list from one end to another. The algorithm will iterate through every element in the list from the second to the last and figure out where to insert that element in all of the elements that came before it knowing that they are already in sorted order.

If you watch the animation closely you can see that as the algorithm runs it will "insert" each element it comes across into the appropriate index behind it. Hence the name Insertion Sort.
*/

/*:
### Merge Sort

Merge Sort is a very efficient sorting algorithm with a worst case run time of O(nLog(n)). Merge sort is a recursive algorithm which means that it calls itself with a smaller input value. Merge sort works by using a divide and conquer strategy. Merge sort will break a list of n elements in half repeatedly until it has n individual lists that each contain one element. Then, it will merge the broken down lists back together one at a time until the list is completely merged together in sorted order.
 
 If you watch the animation closely you can see that as the algorithm runs it will "merge" together small parts of the array one at a time until it merges the entire array together in order. Hence the name Merge Sort.
*/
