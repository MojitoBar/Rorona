//
//  ContentView.swift
//  Shared
//
//  Created by judongseok on 2021/03/12.
//

import SwiftUI

struct CardView: View {
    var roronainfo: RoronaInfo
    var body: some View {
        ZStack{
            RoundedRectangle(cornerRadius: /*@START_MENU_TOKEN@*/25.0/*@END_MENU_TOKEN@*/)
                .fill(
                    LinearGradient(gradient: Gradient(colors: [Color(#colorLiteral(red: 0.04076000323, green: 0.2159992264, blue: 0.372004512, alpha: 1)), Color(#colorLiteral(red: 0.06490538184, green: 0.343952678, blue: 0.5923722519, alpha: 1))]), startPoint: .topLeading, endPoint: .bottomTrailing)
                )
                .frame(width: 300, height: 200)
                .padding()
                .shadow(color: Color(#colorLiteral(red: 0.101288268, green: 0.1096670212, blue: 0.1218392683, alpha: 1)), radius: 5, x: 0, y: 0)
            VStack(alignment: .leading){
                Text(roronainfo.name)
                    .font(.system(size: 35))
                    .frame(width: 250, height: /*@START_MENU_TOKEN@*/100/*@END_MENU_TOKEN@*/, alignment: .leading)
                    .foregroundColor(.white)
                Text(roronainfo.rule)
                    .foregroundColor(.white)
                Text(roronainfo.date)
                    .foregroundColor(.white)
                Spacer()
            }
        }
    }
}

struct ContentView: View {
    @ObservedObject var roronainfo = FetchUser()
    
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
                ForEach(roronainfo.roronainfos){roronainfo in
                    CardView(roronainfo: roronainfo)
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
