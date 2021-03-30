//
//  Data.swift
//  rorona
//
//  Created by judongseok on 2021/03/12.
//

import SwiftUI

struct notsudodata: Codable, Identifiable{
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

class FetchNotsudoData: ObservableObject {
  // 1.
    @Published var notsudodatas = [notsudodata]()
     
    init() {
        let url = URL(string: "http://localhost:8080/notsudo/all")!
        // 2.
        URLSession.shared.dataTask(with: url) {(data, response, error) in
            do {
                if let userData = data {
                    // 3.
                    let decodedData = try JSONDecoder().decode([notsudodata].self, from: userData)
                    DispatchQueue.main.async {
                        self.notsudodatas = decodedData
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
