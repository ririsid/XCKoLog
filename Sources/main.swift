//
//  main.swift
//  ririsid
//
//  Created by Jeongyeon Park on 12/08/2017.
//
//

// 인자가 있는지 확안한다.
guard CommandLine.arguments.count > 1 else {
    fatalError("No arguments!")
}

// 첫 번째 인자를 꺼낸다.
let arg = CommandLine.arguments[1]

// 인자를 변환하고 화면에 찍는다.
let newString = koLog(arg)
print("=> \"\(newString)\"")
