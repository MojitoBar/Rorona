//
//  Data.swift
//  rorona
//
//  Created by judongseok on 2021/03/12.
//

import SwiftUI

struct UserProfile: Codable, Identifiable{
    // ?
    var id: String
    var name: String
    var phone: String
    var address: String
}

class FetchUser: ObservableObject {
  // 1.
  @Published var users = [UserProfile]()
     
    init() {
        let url = URL(string: "http://localhost:8080/user/all")!
        // 2.
        URLSession.shared.dataTask(with: url) {(data, response, error) in
            do {
                if let userData = data {
                    // 3.
                    let decodedData = try JSONDecoder().decode([UserProfile].self, from: userData)
                    DispatchQueue.main.async {
                        self.users = decodedData
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
