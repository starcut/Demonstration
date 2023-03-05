//
//  PickerView.swift
//  Test
//
//  Created by 清水脩輔 on 2023/03/04.
//

import SwiftUI

struct PickerView: View {
    let brides: [String] = ["ビアンカ", "フローラ", "デボラ", "ルドマン"]
    @State var yourBride: String = ""
    @State var comment: String = "\n"
    
    let range: [Range<Int>] = [0..<24, 0..<60, 0..<60]
    @State var selectedTime: [Int] = [0, 0, 0]
    
    var body: some View {
        singlePicker()
//        timePicker()
    }
    
    private func singlePicker() -> some View {
        return VStack {
            Text("フローラとビアンカさんの\nどちらと結婚したいか良く考えたかね？")
            Picker("", selection: $yourBride) {
                ForEach(brides, id: \.self) { bride in
                    Text(bride).tag(bride)
                }
            }
            .onChange(of: yourBride) { selectedBride in
                switch yourBride {
                case "ビアンカ":
                    comment = "ありがとう　リュカ。\nまた　一緒に　旅が　できるね！"
                case "フローラ":
                    comment = "うれしい！\nリュカさん　ありがとう！\nきっと　良い妻になりますわ。"
                case "デボラ":
                    comment = "ふつつかっぽい　リュカだけど\nめんどうみてあげるわ。\nちゃんと　ついてくるのよ。"
                case "ルドマン":
                    comment = "なんと、この私が好きと申すか！？\nそ、それはいかん！もう一度考えてみなさい。"
                default:
                    comment = "あら嫌ですよ○○○○さん。年寄りをからかわないで下さいな。"
                }
            }
            Text(comment)
        }
    }
    
    // 時間を設定するピッカー
    private func timePicker() -> some View {
        return VStack {
            HStack {
                // 設定した時間を表示する
                Text(String(format: "%02d", selectedTime[0]))
                    .font(.system(size: 20))
                
                ForEach(1..<selectedTime.count, id:\.self) { index in
                    Text(":")
                        .font(.system(size: 20))
                    Text(String(format: "%02d", selectedTime[index]))
                        .font(.system(size: 20))
                }
            }
            HStack {
                // 時間のピッカー群
                hhmmssSelectPicker(index: 0)
                ForEach(1 ..< range.count, id: \.self) { index in
                        Text(":")
                    hhmmssSelectPicker(index: index)
                }
            }
        }
    }
    
    // HH:mm:ssのそれぞれの要素を表示するピッカー
    private func hhmmssSelectPicker(index: Int) -> some View {
        return HStack {
            Picker("", selection: $selectedTime[index] ) {
                ForEach(range[index], id: \.self) { time in
                    // ピッカーの内容は二桁表示固定
                    Text(String(format: "%02d", time)).tag(time)
                }
            }
            .pickerStyle(WheelPickerStyle())
        }
    }
}

struct PickerView_Previews: PreviewProvider {
    static var previews: some View {
        PickerView()
    }
}
