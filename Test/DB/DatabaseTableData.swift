import Foundation
import RealmSwift

class DatabaseTableData: Object {
    @objc dynamic var id: Int
    @objc dynamic var title: String
    @objc dynamic var registerDate: Date
    @objc dynamic var updateDate: Date
    
    override init() {
        self.id = 0
        self.title = ""
        self.registerDate = Date()
        self.updateDate = Date()
    }
    
    init(id: Int, title: String, registerDate: Date, updateDate: Date) {
        self.id = id
        self.title = title
        self.registerDate = registerDate
        self.updateDate = updateDate
    }
}
