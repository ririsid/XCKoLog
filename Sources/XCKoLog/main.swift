//
//  main.swift
//  ririsid
//
//  Created by Jeongyeon Park on 12/08/2017.
//
//

/**
  *
  * main() will be run when you invoke this action
  *
  * @param Cloud Functions actions accept a single parameter, which must be Codable.
  *
  * @return The completion function, which takes as output a Codable and Error?.
  *
  */
struct Input: Codable {
    let text: String?
}
struct Output: Codable {
    let text: String
}
enum ParameterError: Error {
    case noParameters
}
func main(param: Input, completion: (Output?, Error?) -> Void) -> Void {
    if let text = param.text {
        let result = Output(text: koLog(text))
        completion(result, nil)
    } else {
        do{
            throw ParameterError.noParameters
        } catch {
            completion(nil, error)
        }
    }
}
