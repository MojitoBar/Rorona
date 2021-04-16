//
//  Data.swift
//  rorona
//
//  Created by judongseok on 2021/03/12.
//

import SwiftUI

class FetchData: ObservableObject {
    // 각각의 데이터를 저장할 RoronaInfo 배열 생성
    @Published var sudoInfos = [RoronaInfo]()
    @Published var notSudoInfos = [RoronaInfo]()
    
    // 초기화 시 데이터 json으로 불러옴
    init() {
        let url = URL(string: "http://localhost:8080/roronainfo/all")!
        URLSession.shared.dataTask(with: url) {(data, response, error) in
            do {
                if let userData = data {
                    // JSONDecoder 함수로 디코딩하여 데이터 저장
                    let decodedData = try JSONDecoder().decode([RoronaInfo].self, from: userData)
                    DispatchQueue.main.async {
                        self.sudoInfos = decodedData
                    }
                } else {
                    print("No data")
                }
            } catch {
                print("Error")
                print(error)
            }
        }.resume()
        
        let notsudo_url = URL(string: "http://localhost:8080/notsudo/all")!
        URLSession.shared.dataTask(with: notsudo_url) {(data, response, error) in
            do {
                if let userData = data {
                    // JSONDecoder 함수로 디코딩하여 데이터 저장
                    let decodedData = try JSONDecoder().decode([RoronaInfo].self, from: userData)
                    DispatchQueue.main.async {
                        self.notSudoInfos = decodedData
                    }
                } else {
                    print("No data")
                }
            } catch {
                print("Error")
                print(error)
            }
        }.resume()
    }
}
