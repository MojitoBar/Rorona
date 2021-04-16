//
//  PostList.swift
//  rorona
//
//  Created by judongseok on 2021/03/12.
//

import SwiftUI

struct PostList: View {
    @ObservedObject var roronainfo = FetchUser()
        var body: some View {
            VStack {
                // 2.
                List(roronainfo.roronainfos) { roronainfo in
                    VStack(alignment: .leading) {
                        // 3.
                        Text(roronainfo.name)
                        Text(roronainfo.rule)
                        Text(roronainfo.date)
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
