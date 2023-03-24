import Foundation
import RealmSwift

class DatabaseManager {
    static let shared = DatabaseManager()
    var realm: Realm? = nil
    
    private init() {
        
    }
    
    func getInstance() -> [DatabaseTableData] {
        do {
            self.realm = try? Realm()
        }
        guard let objects = self.realm?.objects(DatabaseTableData.self) else {
            return []
        }
        return Array(objects)
    }
    
    func registerData(data: DatabaseTableData) {
        do {
            self.realm = try? Realm()
            try? self.realm?.write {
                self.realm?.add(data)
            }
        }
    }
    
    func updateData(data: DatabaseTableData, title: String) {
        do {
            self.realm = try? Realm()
            try? self.realm?.write {
                data.title = title
                data.updateDate = Date()
            }
        }
    }
    
    func deleteData(data: DatabaseTableData) {
        do {
            self.realm = try? Realm()
            try? self.realm?.write {
                self.realm?.delete(data)
            }
        }
    }
}
