//
//  ContentView.swift
//  Shared
//
//  Created by judongseok on 2021/03/12.
//

import SwiftUI

struct CardView: View {
    var colors: [Color]
    var image: String
    let nanum = UIFont(name: "NanumSquareOTF_acB", size: 10)
    var roronainfo: RoronaInfo
    var body: some View {
        ZStack{
            RoundedRectangle(cornerRadius: 15.0)
                .fill(
                    LinearGradient(gradient: Gradient(colors: [colors[0], colors[1]]), startPoint: .topLeading, endPoint: .bottomTrailing)
                )
                .frame(width: 300, height: 200)
                .shadow(color: colors[0], radius: 5, x: /*@START_MENU_TOKEN@*/0.0/*@END_MENU_TOKEN@*/, y: /*@START_MENU_TOKEN@*/0.0/*@END_MENU_TOKEN@*/)
                .padding()
            ZStack{
                Circle()
                    .opacity(0.25)
                    .blur(radius: 4)
                    .foregroundColor(Color(#colorLiteral(red: 0.9796831018, green: 0.9796831018, blue: 0.9796831018, alpha: 1)))
                Image(image)
                    .resizable()
                    .frame(width: 65, height: 65)
                    .padding(.init(top: -10, leading: 20, bottom: 0, trailing: 0))
            }
            .frame(width: 110, height: 110)
            .padding(.init(top: -140, leading: -165, bottom: 0, trailing: 0))
            
            VStack(alignment: .leading){
                VStack(alignment: .leading){
                    Text(roronainfo.name)
                        .font(.custom("NanumSquareOTF_acEB", size: 35))
                        .frame(width: 220, height: 100, alignment: .leading)
                        .foregroundColor(.white)
                }
                .padding(.leading, 140)
                VStack(alignment: .leading){
                    Text(roronainfo.rule)
                        .font(.custom("NanumSquareOTF_acB", size: 25))
                        .fontWeight(.bold)
                        .foregroundColor(.white)
                        .padding(.init(top: 5, leading: 0, bottom: 10, trailing: 0))
                    Text(roronainfo.date)
                        .font(.custom("NanumSquareOTF_acB", size: 20))
                        .fontWeight(.bold)
                        .foregroundColor(.white)
                    Spacer()
                }
                .padding(.leading, 50)
            }
        }
        .padding(.top, 25)
    }
}

struct ContentView: View {
    
    // db에 추가하기
    @State var Colors = [
        [Color(#colorLiteral(red: 0.9568627477, green: 0.6588235497, blue: 0.5450980663, alpha: 1)), Color(#colorLiteral(red: 0.9764705896, green: 0.850980401, blue: 0.5490196347, alpha: 1))],
        [Color(#colorLiteral(red: 0.2386925334, green: 0.4814667995, blue: 0.9686274529, alpha: 1)), Color(#colorLiteral(red: 0.5587813862, green: 0.6104271209, blue: 0.9764705896, alpha: 1))],
        [Color(#colorLiteral(red: 0.9212490338, green: 0.273721212, blue: 0.5218184406, alpha: 1)), Color(#colorLiteral(red: 1, green: 0.5301271778, blue: 0.7130295974, alpha: 1))],
        [Color(#colorLiteral(red: 0.9764705896, green: 0.850980401, blue: 0.5490196347, alpha: 1)), Color(#colorLiteral(red: 0.721568644, green: 0.8862745166, blue: 0.5921568871, alpha: 1))],
        [Color(#colorLiteral(red: 0.5843137503, green: 0.8235294223, blue: 0.4196078479, alpha: 1)), Color(#colorLiteral(red: 0.721568644, green: 0.8862745166, blue: 0.5921568871, alpha: 1))],
        [Color(#colorLiteral(red: 0.3647058904, green: 0.06666667014, blue: 0.9686274529, alpha: 1)), Color(#colorLiteral(red: 0.5568627715, green: 0.3529411852, blue: 0.9686274529, alpha: 1))],
        [Color(#colorLiteral(red: 0.9796831018, green: 0.9796831018, blue: 0.9796831018, alpha: 1)), Color(#colorLiteral(red: 0.9796831018, green: 0.9796831018, blue: 0.9796831018, alpha: 1))]
    ]
    @State var Image = [
        "party",
        "mic",
        "computer",
        "party",
        "party",
        "party"
    ]
    
    @ObservedObject var roronainfo = FetchUser()
    
    var body: some View {
        ZStack{
            Color(#colorLiteral(red: 0.9796831018, green: 0.9796831018, blue: 0.9796831018, alpha: 1))
                .ignoresSafeArea()
            VStack{
                HStack{
                    Text("RORONA!")
                        .fontWeight(.bold)
                        .padding(.leading, 30)
                        .font(.system(size: 30))
                        .foregroundColor(Color(#colorLiteral(red: 0.05882352963, green: 0.180392161, blue: 0.2470588237, alpha: 1)))
                    Spacer()
                    Circle()
                        .frame(width: 40, height: 40, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
                        .padding(.trailing, 30)
                        .foregroundColor(Color(#colorLiteral(red: 0.05882352963, green: 0.180392161, blue: 0.2470588237, alpha: 1)))
                }
                NoSepratorList{
                    ForEach(roronainfo.roronainfos){roronainfo in
                        CardView(colors: Colors[roronainfo.id - 1], image: Image[roronainfo.id - 1], roronainfo: roronainfo)
                    }
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
