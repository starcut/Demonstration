import Foundation
import RealmSwift

class DatabaseListViewModel: ObservableObject {
    @Published var isShownDialog: Bool = false
    @Published var data: [DatabaseTableData]
    
    init() {
        self.data = DatabaseManager.shared.getInstance()
    }
    
    func registerData(inputText: String) {
        let data = DatabaseTableData(id: self.data.count + 1,
                                     title: inputText,
                                     registerDate: Date(),
                                     updateDate: Date())
        DatabaseManager.shared.registerFavoriteSetting(data: data)
        self.data = DatabaseManager.shared.getInstance()
    }
}
