//
//  ContentView.swift
//  Shared
//
//  Created by judongseok on 2021/03/12.
//

import SwiftUI

struct ModalView: View {
    var roronainfo: RoronaInfo
    var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 10.0)
                .fill(
                    LinearGradient(gradient: Gradient(colors: [Color.init(hex: roronainfo.color1), Color.init(hex: roronainfo.color2)]), startPoint: .topLeading, endPoint: .bottomTrailing)
                )
                .frame(height: UIScreen.main.bounds.size.height)
            Button(action: {
                
            }) {
                Text(roronainfo.description)
                    .font(.custom("NanumSquareOTF_acEB", size: 20))
            }
            .foregroundColor(.white)
        }
    }
}

struct CardView: View {
    @State private var showModal = false
    var roronainfo: RoronaInfo
    
    var body: some View {
        ZStack{
            Button(action: {
                self.showModal = true
            }, label: {
                RoundedRectangle(cornerRadius: 15.0)
                    .fill(
                        LinearGradient(gradient: Gradient(colors: [Color.init(hex: roronainfo.color1), Color.init(hex: roronainfo.color2)]), startPoint: .topLeading, endPoint: .bottomTrailing)
                    )
                    .frame(width: 300, height: 150)
                    .shadow(color: Color.init(hex: roronainfo.color1), radius: 5, x: /*@START_MENU_TOKEN@*/0.0/*@END_MENU_TOKEN@*/, y: /*@START_MENU_TOKEN@*/0.0/*@END_MENU_TOKEN@*/)
                    .padding()
            })
            .sheet(isPresented: self.$showModal, content: {
                ModalView(roronainfo: roronainfo)
            })
            ZStack{
                Circle()
                    .opacity(0.25)
                    .blur(radius: 4)
                    .foregroundColor(Color(#colorLiteral(red: 0.9796831018, green: 0.9796831018, blue: 0.9796831018, alpha: 1)))
                Image(roronainfo.image)
                    .resizable()
                    .frame(width: 65, height: 65)
                    .padding(.init(top: -10, leading: 20, bottom: 0, trailing: 0))
            }
            .frame(width: 110, height: 110)
            .padding(.init(top: -110, leading: 200, bottom: 0, trailing: 0))
            
            VStack(alignment: .leading){
                VStack(alignment: .leading){
                    Text(roronainfo.name)
                        .font(.custom("NanumSquareOTF_acEB", size: 35))
                        .frame(width: 200, height: 100, alignment: .leading)
                        .foregroundColor(.white)
                        .padding(.top, -30)
                }
                VStack(alignment: .leading){
                    Text(roronainfo.rule)
                        .font(.custom("NanumSquareOTF_acB", size: 25))
                        .fontWeight(.bold)
                        .foregroundColor(.white)
                    Spacer()
                }
            }
            .frame(width: 300, height: 100, alignment: .leading)
            .padding(.leading, 40)
        }
        .padding(.top, 10)
    }
}

struct ContentView: View {
    @ObservedObject var roronainfo = FetchUser()
    // db에 추가하기
    var body: some View {
        ZStack{
            Color(#colorLiteral(red: 0.9796831018, green: 0.9796831018, blue: 0.9796831018, alpha: 1))
                .ignoresSafeArea()
            VStack{
                HStack{
                    Text("RORONA!")
                        .fontWeight(.bold)
                        .padding(.leading, 30)
                        .font(.custom("NanumSquareOTF_acB", size: 30))
                        .foregroundColor(Color(#colorLiteral(red: 0.05882352963, green: 0.180392161, blue: 0.2470588237, alpha: 1)))
                    Spacer()
                    Circle()
                        .frame(width: 40, height: 40, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
                        .padding(.trailing, 30)
                        .foregroundColor(Color(#colorLiteral(red: 0.05882352963, green: 0.180392161, blue: 0.2470588237, alpha: 1)))
                }
                HStack{
                    Spacer()
                    HStack(){
                        Text("거리두기 2단계")
                            .font(.custom("NanumSquareOTF_acB", size: 18))
                            .foregroundColor(Color(#colorLiteral(red: 0.2549019754, green: 0.2745098174, blue: 0.3019607961, alpha: 1)))
                        Text("/ ~3월 28일")
                            .font(.custom("NanumSquareOTF_acB", size: 18))
                            .foregroundColor(Color(#colorLiteral(red: 0.2549019754, green: 0.2745098174, blue: 0.3019607961, alpha: 1)))
                    }
                    .padding(.horizontal)
                }
                .padding(.horizontal)
                
                NoSeparatorList{
                    ForEach(roronainfo.roronainfos){roronainfo in
                        CardView(roronainfo: roronainfo)
                    }
                }
            }
        }
        
    }
}

struct NoSeparatorList<Content>: View where Content: View {

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
