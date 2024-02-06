import Foundation
import UIKit

class PrinterPickerModel: ObservableObject {
    @Published private(set) var printerUrl: URL?
    @Published private(set) var message = ""
    
    func showPrinterPicker() {
        let printerPicker = UIPrinterPickerController(initiallySelectedPrinter: nil)
        printerPicker.present(animated: true) {
            printerPickerController, userDidSelect, error in
            if let error {
                self.message = "プリンター選択時にエラー：\(error)"
                return
            }
            
            if let printer = printerPickerController.selectedPrinter {
                self.printerUrl = printer.url
                self.message = "プリンターが選択されました"
            }
        }
    }
}
