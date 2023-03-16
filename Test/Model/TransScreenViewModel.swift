import Foundation

class TransScreenViewModel: ObservableObject {
    @Published var isFullScreenPresented: Bool = false
    @Published var isPresented: Bool = false
    @Published var isPushTrans: Bool = false
}
