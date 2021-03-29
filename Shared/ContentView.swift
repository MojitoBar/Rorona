//
//  ContentView.swift
//  Shared
//
//  Created by judongseok on 2021/03/12.
//

import SwiftUI

struct DropDown : View{
    @State var expand = false
    @Binding var isSudo: Bool
    var body: some View{
        VStack (alignment: .trailing){
            HStack{
                Text(isSudo ? "수도권 거리두기 2단계" : "비수도권 거리두기 1.5단계")
                Image(systemName: expand ? "chevron.up" : "chevron.down").resizable().frame(width: 13, height: 6)
            }.onTapGesture {
                self.expand.toggle()
            }
            if expand{
                VStack(alignment: .trailing){
                    Button(action: {
                        isSudo = true
                        expand = false
                    }, label: {
                        Text("수도권 거리두기 2단계")
                            .font(.custom("NanumSquareOTF_acEB", size: 15))
                    })
                    .padding(.vertical, 5)
                    Button(action: {
                        isSudo = false
                        expand = false
                    }, label: {
                        Text("비수도권 거리두기 1.5단계")
                            .font(.custom("NanumSquareOTF_acEB", size: 15))
                    })
                }
                .frame(width: 204)
                .foregroundColor(.gray)
            }
        }
        .animation(.spring())
    }
}

struct ModalView: View {
    var roronainfo: RoronaInfo
    var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 10.0)
                .fill(
                    LinearGradient(gradient: Gradient(colors: [Color.init(hex: roronainfo.color1), Color.init(hex: roronainfo.color2)]), startPoint: .topLeading, endPoint: .bottomTrailing)
                )
                .frame(height: UIScreen.main.bounds.size.height)
            VStack (alignment: .leading){
                Text("상세정보")
                    .font(.custom("NanumSquareOTF_acEB", size: 40))
                    .padding(.vertical, 100)
                Text(roronainfo.description)
                    .font(.custom("NanumSquareOTF_acEB", size: 20))
                    .frame(width: 350, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
                Spacer()
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
    @State var isSudo = true
    // db에 추가하기
    var body: some View {
        ZStack{
            Color(#colorLiteral(red: 0.9796831018, green: 0.9796831018, blue: 0.9796831018, alpha: 1))
                .ignoresSafeArea()
            VStack{
                HStack{
                    Button(action: {
                        // 링크
                        if let url = URL(string: "http://www.mohw.go.kr/react/al/sal0301vw.jsp?PAR_MENU_ID=04&MENU_ID=0403&page=1&CONT_SEQ=364260") {
                            UIApplication.shared.open(url)
                        }
                    }, label: {
                        Image(systemName: "info.circle")
                            .resizable()
                            .frame(width: 25, height: 25, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
                            .padding(.leading, 20)
                            .padding(.top, 10)
                            .foregroundColor(.gray)
                    })
                    Spacer()
                    
                }
                .padding(.horizontal)
                
                ZStack{
                    DropDown(isSudo: $isSudo)
                        .font(.custom("NanumSquareOTF_acEB", size: 20))
                        .padding(.init(top: -420, leading: 0, bottom: 0, trailing: -140))
                        .frame(width: 100, height: /*@START_MENU_TOKEN@*/100/*@END_MENU_TOKEN@*/, alignment: .trailing)
                    NoSeparatorList{
                        if isSudo{
                            ForEach(roronainfo.roronainfos){roronainfo in
                                CardView(roronainfo: roronainfo)
                            }
                        }
                        else{
                            
                        }
                    }
                    .padding(.init(top: 50, leading: 0, bottom: 0, trailing: 0))
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
