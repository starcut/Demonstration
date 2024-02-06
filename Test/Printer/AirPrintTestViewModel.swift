import Foundation
import UIKit

class AirPrintTestViewModel: ObservableObject {
    @Published private(set) var message = ""
    
    func printOut(printerUrl: URL?, printingItem: Any?) {
        guard let printerUrl = printerUrl else {
            message = "プリンターが選択されていない"
            return
        }
        let printer = UIPrinter(url: printerUrl)
        let printInteractionController = UIPrintInteractionController.shared
        let printInfo = UIPrintInfo(dictionary: nil)
        printInfo.jobName = "テストプリンター"
        printInteractionController.printInfo = printInfo
        printInteractionController.printingItem = printingItem
        printInteractionController.print(to: printer) { controller, completed, error in
            if let error {
                self.message = "印刷時にエラー発生：\(error)"
                return
            }
            if completed {
                self.message = "印刷完了"
            } else {
                self.message = "印刷が完了しませんでした。"
            }
        }
    }
    
    func createPDFData() -> Data {
        let pdfMetaData = [
            kCGPDFContextCreator: "@seeking-star.co.jp",
            kCGPDFContextAuthor: "seeking-star.co.jp"
        ]
        let format = UIGraphicsPDFRendererFormat()
        format.documentInfo = pdfMetaData as [String: Any]
        
        // A4サイズ
        let pageRect = CGRect(x: 0, y: 0, width: 2100, height: 2900)
        let renderer = UIGraphicsPDFRenderer(bounds: pageRect,
                                             format: format)
        return renderer.pdfData { context in
            renderPdfReport(context: context)
        }
    }
    
    private func renderPdfReport(context: UIGraphicsPDFRendererContext) {
        context.beginPage()
        
        let text = "PDF Test"
        let attributes = [
            NSAttributedString.Key.font: UIFont.boldSystemFont(ofSize: 72)
        ]
        text.draw(at: CGPoint(x: 30, y: 30), withAttributes: attributes)
    }
}
