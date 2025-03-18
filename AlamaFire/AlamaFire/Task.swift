//
//  Task.swift
//  AlamaFire
//
//  Created by mac on 16/05/24.
//

import Foundation

let sharedTask = SwiftTask()

class SwiftTask{
    
    //MARK: One
    //var b:[Any] = [1,2,3,34,[4,5,[6,7,[8,9,[10,11,12]]]]]
    
    var array = [Int]()
    
    func go(b:[Any]){
        for i in b {
            if let f = i as? Int{
                print(f)
                array.append(f)
            }else{
                go(b: i as! [Any])
            }
        }
        print(array)
    }

    
    //MARK: Two
    
    //let strings = "seenu manoj karthick seenu asvith manoj ram karthick"
    
    func call(value:String){
        let e = value.split(separator: " ")
        
        
        for i in 0..<e.count{
            for j in 1..<e.count{
                
            }
        }
    }
    
    //MARK: Three
    // let intArray = [3,5,34,6,74,4,98,97]
    
    func secondLargeNumber(intArray:[Int]){
        
        var secondLargerInt = 0
        var largerint = 0
        
        for i in 0..<intArray.count{
            if i != 0{
                if largerint <= intArray[i]{
                    secondLargerInt = largerint
                    largerint = intArray[i]
                }else{
                    if secondLargerInt <= intArray[i]{
                        secondLargerInt = intArray[i]
                    }
                }
            }else{
                secondLargerInt = intArray[i]
                largerint = intArray[i]
            }
        }
        print("secondLargerInt : \(secondLargerInt) , ","largerint :\(largerint)")
    }
    
}
