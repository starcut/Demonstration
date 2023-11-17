import SwiftUI

struct Symbol: Identifiable {
    var id = UUID()
    var image: String
}

struct PanelScrollView: View {
    let imageNames: [Symbol] = [Symbol(image: "man1"), Symbol(image: "man2"),
                                Symbol(image: "man3"), Symbol(image: "man4"),
                                Symbol(image: "man5"), Symbol(image: "man6"),
                                Symbol(image: "man7"), Symbol(image: "man8"),
                                Symbol(image: "man9"),
                                Symbol(image: "pin1"), Symbol(image: "pin2"),
                                Symbol(image: "pin3"), Symbol(image: "pin4"),
                                Symbol(image: "pin5"), Symbol(image: "pin6"),
                                Symbol(image: "pin7"), Symbol(image: "pin8"),
                                Symbol(image: "pin9"),
                                Symbol(image: "sou1"), Symbol(image: "sou2"),
                                Symbol(image: "sou3"), Symbol(image: "sou4"),
                                Symbol(image: "sou5"), Symbol(image: "sou6"),
                                Symbol(image: "sou7"), Symbol(image: "sou8"),
                                Symbol(image: "sou9"),
                                Symbol(image: "z1"), Symbol(image: "z2"),
                                Symbol(image: "z3"), Symbol(image: "z4"),
                                Symbol(image: "z5"), Symbol(image: "z6"),
                                Symbol(image: "z7"), ]
    
    let columns: [GridItem] = [GridItem(.adaptive(minimum: 150, maximum: 200))]
    
    var body: some View {
        ScrollView(.horizontal) {
            LazyHGrid(rows: columns) {
                ForEach(imageNames) { imageName in
                    ZStack {
                        Color.green
                        HStack {
                            Image(imageName.image)
                        }
                    }
                }
            }
        }
    }
}
