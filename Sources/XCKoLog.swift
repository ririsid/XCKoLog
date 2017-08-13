//
//  XCKoLog.swift
//  ririsid
//
//  Created by Jeongyeon Park on 27/07/2017.
//
//

import Foundation

/// Xcode에서 한글 로그가 유니코드 값으로 표현되는 것을 읽을 수 있게 변환한다.
func koLog(_ string: String) -> String {
    // 유니코드 값을 찾을 정규표현식을 만든다.
    let pattern = "\\\\U([a-z0-9]{1,8})"
    var regex: NSRegularExpression
    do {
        regex = try NSRegularExpression(pattern: pattern, options: [])
    } catch {
        debugPrint("\(error)")
        return ""
    }

    // 변환하고 반환한다.
    return replacingCharacters(with: string, regex: regex)
}

/// 정규표현식에 맞는 문자를 찾아서 변환한다.
private func replacingCharacters(with string: String, regex: NSRegularExpression) -> String {
    // 정규표현식에 맞는 문자를 찾는다.
    let range = NSRange(location: 0, length: string.characters.count)
    guard let firstMatch = regex.firstMatch(in: string, options: [], range: range) else {
        return string
    }

    // 정규표현식 결과를 사용해 변환하려면 `NSString`을 쓰는 게 편하다.
    let nsString = NSString(string: string)
    // 찾은 문자를 잘라낸다.
    #if os(Linux)
        let substring = nsString.substring(with: firstMatch.range(at: 1))
    #else
        let substring = nsString.substring(with: firstMatch.rangeAt(1))
    #endif
    // 유니코드 값을 구한다. 유니코드 문자열은 16진수이며, 유니코드 스칼라는 21비트이다.
    let unicodeValue = UInt32(substring, radix: 16)!
    // 유니코드 값을 유니코드 스칼라로 변환한다.
    guard let unicodeScalar = UnicodeScalar(unicodeValue) else {
        return string
    }

    // 유니코드 표현을 찾아 유니코드 스칼라로 교체한다.
    #if os(Linux)
        let newString = nsString.replacingCharacters(in: firstMatch.range(at: 0), with: String(unicodeScalar))
    #else
        let newString = nsString.replacingCharacters(in: firstMatch.rangeAt(0), with: String(unicodeScalar))
    #endif

    // 재귀 호출한다.
    return replacingCharacters(with: newString, regex: regex)
}
