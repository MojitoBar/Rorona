//
//  ContentView.swift
//  Shared
//
//  Created by judongseok on 2021/03/12.
//

import SwiftUI

struct CardView: View {
    var user: UserProfile
    var body: some View {
        ZStack{
            RoundedRectangle(cornerRadius: /*@START_MENU_TOKEN@*/25.0/*@END_MENU_TOKEN@*/)
                .frame(width: 300, height: 200)
                .padding()
                .foregroundColor(/*@START_MENU_TOKEN@*/.blue/*@END_MENU_TOKEN@*/)
            Text(user.name)
        }
    }
}

struct ContentView: View {
    @ObservedObject var user = FetchUser()
    
    init() {
        UITableView.appearance().separatorColor = .clear
    }
    
    var body: some View {
        VStack{
            HStack{
                Text("RORONA!")
                    .padding(.leading, 30)
                    .font(.system(size: 30))
                Spacer()
                Circle()
                    .frame(width: 40, height: 40, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
                    .padding(.trailing, 30)
            }
            NoSepratorList{
                ForEach(user.users){user in
                    CardView(user: user)
                }
            }
        }
        
    }
}

struct NoSepratorList<Content>: View where Content: View {

    let content: () -> Content

    init(@ViewBuilder content: @escaping () -> Content) {
        self.content = content
    }
        
    var body: some View {
        if #available(iOS 14.0, *) {
           ScrollView {
               LazyVStack(spacing: 0) {
                self.content()
             }
           }
        } else {
            List {
                self.content()
            }
            .onAppear {
               UITableView.appearance().separatorStyle = .none
            }.onDisappear {
               UITableView.appearance().separatorStyle = .singleLine
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
