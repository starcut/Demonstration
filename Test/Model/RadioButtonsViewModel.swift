import Foundation
import SwiftUI

class RadioButtonsViewModel: NSObject, ObservableObject {
    @Published var selectedItem: String = ""
    
    func updateSelectedItem(selectedItem: String) {
        self.selectedItem = selectedItem
    }
    
    // ラジオボタンのシステム名を返す
    func getRadioButtonImage(item: String) -> String {
        return self.selectedItem == item ? "button.programmable" : "circle"
    }
    
    // ラジオボタンの色を返す
    func getRadioButtonColor(item: String) -> Color {
        return self.selectedItem == item ? Color.blue : Color.gray
    }
}
