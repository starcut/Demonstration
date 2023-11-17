import Foundation
import SwiftUI

class RadioButtonsViewModel: NSObject, ObservableObject {
    @Published var selectedJob: String = ""
    
    func updateSelectedJob(selectedJob: String) {
        self.selectedJob = selectedJob
    }
    
    // ラジオボタンのシステム名を返す
    func getRadioButtonImage(job: String) -> String {
        return self.selectedJob == job ? "button.programmable" : "circle"
    }
    
    // ラジオボタンの色を返す
    func getRadioButtonColor(job: String) -> Color {
        return self.selectedJob == job ? Color.blue : Color.gray
    }
}
