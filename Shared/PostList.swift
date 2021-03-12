//
//  PostList.swift
//  rorona
//
//  Created by judongseok on 2021/03/12.
//

import SwiftUI

struct PostList: View {
    @ObservedObject var user = FetchUser()
        var body: some View {
            VStack {
                // 2.
                List(user.users) { user in
                    VStack(alignment: .leading) {
                        // 3.
                        Text(user.name)
                        Text(user.phone)
                        Text(user.address)
                    }
                }
            }
        }
}

struct PostList_Previews: PreviewProvider {
    static var previews: some View {
        PostList()
    }
}
