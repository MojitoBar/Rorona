//
//  Data.swift
//  rorona
//
//  Created by judongseok on 2021/03/12.
//

import SwiftUI

struct RoronaInfo: Codable, Identifiable{
    // ?
    var id: Int
    var name: String
    var rule: String
    var date: String
    var description: String
    var image: String
    var color1: String
    var color2: String
}

class FetchUser: ObservableObject {
  // 1.
    @Published var roronainfos = [RoronaInfo]()
    @Published var sudoinfos = [RoronaInfo]()
     
    init() {
        let url = URL(string: "http://localhost:8080/roronainfo/all")!
        // 2.
        URLSession.shared.dataTask(with: url) {(data, response, error) in
            do {
                if let userData = data {
                    // 3.
                    let decodedData = try JSONDecoder().decode([RoronaInfo].self, from: userData)
                    DispatchQueue.main.async {
                        self.roronainfos = decodedData
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
        // 2.
        URLSession.shared.dataTask(with: notsudo_url) {(data, response, error) in
            do {
                if let userData = data {
                    // 3.
                    let decodedData = try JSONDecoder().decode([RoronaInfo].self, from: userData)
                    DispatchQueue.main.async {
                        self.sudoinfos = decodedData
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
