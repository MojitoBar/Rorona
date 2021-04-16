//
//  ContentView.swift
//  Shared
//
//  Created by judongseok on 2021/03/12.
//

import SwiftUI

// 오른쪽 상단 DropDown뷰 영역
struct DropDown : View{
    // DropBox가 펼쳐짐을 체크할 변수 선언
    @State var expand = false
    // ContentView에 선언된 isSudo 변수를 Binding함
    @Binding var isSudo: Bool
    
    var body: some View{
        VStack (alignment: .trailing){
            HStack{
                // 수도권이냐 아니냐에 따라 Text 변경해줌
                Text(isSudo ? "수도권 거리두기 2단계" : "비수도권 거리두기 1.5단계")
                // DropBox가 펼쳐졌는지 아닌지에 따라 화살표 이미지를 변경해줌
                Image(systemName: expand ? "chevron.up" : "chevron.down").resizable().frame(width: 13, height: 6)
            }.onTapGesture {
                self.expand.toggle()
            }
            if expand{
                VStack(alignment: .trailing){
                    Button(action: {
                        // 수도건 거리두기를 클릭한 경우 수도권 체크변수를 true, DropBox를 false로 바꿈
                        isSudo = true
                        expand = false
                    }, label: {
                        Text("수도권 거리두기 2단계")
                            .font(.custom("NanumSquareOTF_acEB", size: 15))
                    })
                    .padding(.vertical, 5)
                    Button(action: {
                        // 비수도권 거리두기를 클릭한 경우 수도권 체크변수를 false, DropBox를 false로 바꿈
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

// 각 카드뷰 클릭시 보여줄 Modal뷰 영역
struct ModalView: View {
    var roronainfo: RoronaInfo
    var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 10.0)
                .fill(
                    // 색깔을 hex코드로 쉽게 입력하기 위해 Color.init()함수를 extension해서 구현
                    LinearGradient(gradient: Gradient(colors: [Color.init(hex: roronainfo.color1), Color.init(hex: roronainfo.color2)]), startPoint: .topLeading, endPoint: .bottomTrailing)
                )
                .frame(height: UIScreen.main.bounds.size.height)
            VStack (alignment: .leading){
                Text("상세정보")
                    .font(.custom("NanumSquareOTF_acEB", size: 40))
                    .padding(.vertical, 80)
                Text("기간 : \(roronainfo.date)")
                    .font(.custom("NanumSquareOTF_acEB", size: 30))
                    .padding(.vertical, 20)
                    .frame(width: 350, alignment: .leading)
                Text(roronainfo.description)
                    .font(.custom("NanumSquareOTF_acEB", size: 20))
                    .frame(width: 350, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
                Spacer()
            }
            .foregroundColor(.white)
        }
    }
}

// 각 카드뷰 영역
struct CardView: View {
    // Modal을 띄운 상태인지를 체크하기 위한 변수 선언
    @State private var showModal = false
    // 카드에 표시될 정보가 들어있는 RoronaInfo형 변수 선언
    var roronainfo: RoronaInfo
    
    var body: some View {
        ZStack{
            Button(action: {
                // 클릭시 Modal상태를 true로 변경
                self.showModal = true
            }, label: {
                RoundedRectangle(cornerRadius: 15.0)
                    .fill(
                        // 색깔을 hex코드로 쉽게 입력하기 위해 Color.init()함수를 extension해서 구현
                        LinearGradient(gradient: Gradient(colors: [Color.init(hex: roronainfo.color1), Color.init(hex: roronainfo.color2)]), startPoint: .topLeading, endPoint: .bottomTrailing)
                    )
                    .frame(width: 300, height: 150)
                    .shadow(color: Color.init(hex: roronainfo.color1), radius: 5, x: /*@START_MENU_TOKEN@*/0.0/*@END_MENU_TOKEN@*/, y: /*@START_MENU_TOKEN@*/0.0/*@END_MENU_TOKEN@*/)
                    .padding()
            })
            // Modal상태가 true일 경우 해당 카드에 저장된 정보를 Modal뷰로 넘겨줌
            .sheet(isPresented: self.$showModal, content: {
                ModalView(roronainfo: roronainfo)
            })
            ZStack{
                Circle()
                    .opacity(0.25)
                    .blur(radius: 4)
                    .foregroundColor(Color(#colorLiteral(red: 0.9796831018, green: 0.9796831018, blue: 0.9796831018, alpha: 1)))
                // DB에 저장된 이미지 경로를 불러옴
                Image(roronainfo.image)
                    .resizable()
                    .frame(width: 65, height: 65)
                    .padding(.init(top: -10, leading: 20, bottom: 0, trailing: 0))
            }
            .frame(width: 110, height: 110)
            .padding(.init(top: -110, leading: 200, bottom: 0, trailing: 0))
            
            VStack(alignment: .leading){
                VStack(alignment: .leading){
                    // DB에 저장된 이름을 불러옴
                    Text(roronainfo.name)
                        .font(.custom("NanumSquareOTF_acEB", size: 30))
                        .frame(width: 200, height: 100, alignment: .leading)
                        .foregroundColor(.white)
                        .padding(.top, -30)
                }
                VStack(alignment: .leading){
                    // DB에 저장된 규칙을 불러옴
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

// 화면이 표시될 메인 뷰
struct ContentView: View {
    // FetchData의 생성자를 통해 뷰가 생성시 바로 데이터를 불러옴
    @ObservedObject var roronainfo = FetchData()
    // 수도인지 아닌지 체크할 변수 선언
    @State var isSudo = true
    
    var body: some View {
        ZStack{
            Color(#colorLiteral(red: 0.9796831018, green: 0.9796831018, blue: 0.9796831018, alpha: 1))
                .ignoresSafeArea()
            VStack{
                HStack{
                    Button(action: {
                        // 보건복지부 홈페이지로 이동할 링크
                        if let url = URL(string: "http://www.mohw.go.kr/react/al/sal0301vw.jsp?PAR_MENU_ID=04&MENU_ID=0403&page=1&CONT_SEQ=365202") {
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
                    // 왼쪽 상단 뷰
                    DropDown(isSudo: $isSudo)
                        .font(.custom("NanumSquareOTF_acEB", size: 20))
                        .padding(.init(top: -420, leading: 0, bottom: 0, trailing: -140))
                        .frame(width: 100, height: /*@START_MENU_TOKEN@*/100/*@END_MENU_TOKEN@*/, alignment: .trailing)
                    // SwiftUI에서 제공하는 List뷰는 항목들 사이에 구분선이 있어서 NoSeparatorList를 구현
                    NoSeparatorList{
                        // 수도인지 아닌지 체크해 알맞는 데이터를 보여줌
                        ForEach(isSudo ? roronainfo.sudoInfos : roronainfo.notSudoInfos){roronainfo in
                            CardView(roronainfo: roronainfo)
                        }
                    }
                    .padding(.init(top: 60, leading: 0, bottom: 0, trailing: 0))
                }
            }
        }
    }
}

// iOS 버전별 구분선 없는 리스트
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
