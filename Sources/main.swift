//
//  main.swift
//  ririsid
//
//  Created by Jeongyeon Park on 12/08/2017.
//
//

/// 인자 배열
let arguments = CommandLine.arguments

// 인자가 있는지 확안한다.
if arguments.count > 1 {
    /// 변환된 문자열을 저장할 변수
    var convertedText: String = ""

    // 모든 인자를 변환해서 `convertedText`에 추가한다.
    for n in 1..<arguments.count {
        let converted = koLog(arguments[n])
        if n == 1 {
            convertedText = converted
        } else {
            convertedText = "\(convertedText) \(converted)"
        }
    }

    // 최종 결과를 출력한다.
    print("=> \"\(convertedText)\"")
} else {
    print("=> No arguments!")
}
