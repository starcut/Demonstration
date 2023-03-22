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
    
    func registerFavoriteSetting(data: DatabaseTableData) {
        do {
            self.realm = try? Realm()
            try? self.realm?.write {
                self.realm?.add(data)
            }
        }
    }
    
    func deleteFariteSetting(data: DatabaseTableData) {
        do {
            self.realm = try? Realm()
            try? self.realm?.write {
                self.realm?.delete(data)
            }
        }
    }
}
