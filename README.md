# WWDC Scholarship Submission 2017

[![Language: Swift 3.0](https://img.shields.io/badge/swift-3.0-orange.svg?style=flat)](https://developer.apple.com/swift) [![License: MIT License](https://img.shields.io/github/license/mashape/apistatus.svg)](https://opensource.org/licenses/MIT)

**Sorting Made Easy** My submission is a Playground designed to teach computer science students about popular sorting algorithms. To accomplish this I've created an interactive scene that will take in a photo and then sort the people in the photo by height from shortest to tallest. I am able to compare each person's height by using Core Images CIDetector class to detect all of the faces present in the photo. Then taking the bounds of each face I can compare the origin's Y coordindate point to get a relative measurement for each person's height. 

In the interactive scene you are able to play, pause, and shuffle the list of faces to be sorted. At any point in time whether the list has not started sorting, has finished sorting, or is currently sorting you can click onto any face and drag it to anywhere on the screen. Once you let go it will gracefully reposition itself back into the closest index of the list and recompute the steps to correctly sort the newly arranged list. You are also able to toggle the slider above the list to adjust the speed at which the sorting animations will execute.  

## Examples
#### Insertion Sort, and Merge Sort

<div>
<img style="float:left;" src='https://github.com/LoganHenderson/WWDCScholarship2017/blob/master/Demos/InsertionSortDemo.gif?raw=true' title='Main Feed' alt='Main Feed'/>
<img style="float:left;" src='https://github.com/LoganHenderson/WWDCScholarship2017/blob/master/Demos/MergeSortDemo.gif?raw=true' title='Profile' alt='Profile'/>
</div>

























