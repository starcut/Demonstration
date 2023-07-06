import Foundation
import RealmSwift

enum DataBaseOrder: String, CaseIterable, Identifiable {
    case idAscendingOrder = "ID昇順"
    case idDescendingOrder = "ID降順"
    case titleAscendingOrder = "タイトル昇順"
    case titleDescendingOrder = "タイトル降順"
    case registerDateAscendingOrder = "登録が古い順"
    case registerDateDescendingOrder = "登録が新しい順"
    case updateDateAscendingOrder = "更新が古い順"
    case updateDateDescendingOrder = "更新が新しい順"
    
    var id: String { rawValue }
}


class DatabaseManager {
    static let shared = DatabaseManager()
    var realm: Realm? = nil
    
    @Published var selectedOrder: DataBaseOrder = .idAscendingOrder
    
    private init() {
        
    }
    
    func getInstance() -> [DatabaseTableData] {
        do {
            self.realm = try? Realm()
        }
        guard var objects = self.realm?.objects(DatabaseTableData.self) else {
            return []
        }
        objects = sortedObjects(objects: objects)
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
    
    private func sortedObjects(objects: Results<DatabaseTableData>) -> Results<DatabaseTableData> {
        switch DatabaseManager.shared.selectedOrder {
        case .idAscendingOrder:
            let sortDescriptors = [
                SortDescriptor(keyPath: "id", ascending: true),
            ]
            return objects.sorted(by: sortDescriptors)
        case .idDescendingOrder:
            let sortDescriptors = [
                SortDescriptor(keyPath: "id", ascending: false),
            ]
            return objects.sorted(by: sortDescriptors)
        case .titleAscendingOrder:
            let sortDescriptors = [
                SortDescriptor(keyPath: "title", ascending: true),
            ]
            return objects.sorted(by: sortDescriptors)
        case .titleDescendingOrder:
            let sortDescriptors = [
                SortDescriptor(keyPath: "title", ascending: false),
            ]
            return objects.sorted(by: sortDescriptors)
        case .registerDateAscendingOrder:
            let sortDescriptors = [
                SortDescriptor(keyPath: "registerDate", ascending: true),
            ]
            return objects.sorted(by: sortDescriptors)
        case .registerDateDescendingOrder:
            let sortDescriptors = [
                SortDescriptor(keyPath: "registerDate", ascending: false),
            ]
            return objects.sorted(by: sortDescriptors)
        case .updateDateAscendingOrder:
            let sortDescriptors = [
                SortDescriptor(keyPath: "updateDate", ascending: true),
            ]
            return objects.sorted(by: sortDescriptors)
        case .updateDateDescendingOrder:
            let sortDescriptors = [
                SortDescriptor(keyPath: "updateDate", ascending: false),
            ]
            return objects.sorted(by: sortDescriptors)
        }
    }
}
