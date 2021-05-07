# Rorona

Rorona developed with SwiftUI

Spring Tool Suite & Mysql을 이용한 API 연동

### Award
2021 성공회대 it공모전 2등

### ScreenShots
<img src="https://github.com/MojitoBar/Rorona/blob/main/screenshot.gif" width="250"/>

### Skill
- DB table Model & FetchData
```Swift
struct RoronaInfo: Codable, Identifiable{
    // table Model
    var id: Int
    var name: String
    var rule: String
    var date: String
    var description: String
    var image: String
    var color1: String
    var color2: String
}

// Fetch Data
class FetchUser: ObservableObject {
    @Published var roronainfos = [RoronaInfo]()
     
    init() {
        let url = URL(string: "API_URL")!
        URLSession.shared.dataTask(with: url) {(data, response, error) in
            do {
                if let userData = data {
                    let decodedData = try JSONDecoder().decode([RoronaInfo].self, from: userData)
                    DispatchQueue.main.async {
                        self.roronainfos = decodedData
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
```

- ModalView
```Swift
@State private var showModal = false

Button(action: {
    self.showModal = true
}, label: {
    // Some Label...
})
.sheet(isPresented: self.$showModal, content: {
    // Some ModalView
})
```

- DropDown
```Swift
struct DropDown : View{
    @State var expand = false
    var body: some View{
        VStack (alignment: .trailing){
            HStack{
                Text("DropBox")
                Image(systemName: expand ? "chevron.up" : "chevron.down").resizable().frame(width: 13, height: 6)
            }.onTapGesture {
                self.expand.toggle()
            }
            if expand{
                VStack(alignment: .trailing){
                    Text("item 1")
                    Text("item 2")
                }
            }
        }
        .animation(.spring())
    }
}
```

- LinkButton
```Swift
Button(action: {
    if let url = URL(string: "Link_URL") {
        UIApplication.shared.open(url)
    }
}, label: {
    // Some Link Button
})
```
