import SwiftUI
import PDFKit

struct AirPrintTestView: View {
    @ObservedObject private var printerPickerModel = PrinterPickerModel()
    @ObservedObject private var airPrintTestViewModel = AirPrintTestViewModel()
    
    var body: some View {
        VStack {
            Text(printerPickerModel.message)
            Text(printerPickerModel.printerUrl?.absoluteString ?? "")
            Button {
                printerPickerModel.showPrinterPicker()
            } label: {
                Text("プリンタを選択する")
            }
            Button
            {
                airPrintTestViewModel.printOut(printerUrl: printerPickerModel.printerUrl,
                                               printingItem: airPrintTestViewModel.createPDFData())
            } label: {
                Text("印刷する")
            }.disabled(printerPickerModel.printerUrl == nil)
            Text(airPrintTestViewModel.message)
            PDFViewRepresentable(data: airPrintTestViewModel.createPDFData())
        }
    }
}

struct PDFViewRepresentable: UIViewRepresentable {
    var data: Data
    
    func makeUIView(context: Context) -> PDFView {
        let view = PDFView()
        view.document = PDFDocument(data: data)
        view.autoScales = true
        return view
    }
    
    func updateUIView(_ uiView: PDFView, context: Context) {
    }
}
