import Foundation
import StoreKit

typealias Transaction = StoreKit.Transaction
typealias RenewalInfo = StoreKit.Product.SubscriptionInfo.RenewalInfo
typealias RenewalState = StoreKit.Product.SubscriptionInfo.RenewalState

public enum StoreError: Error {
    case failedVerification
}

class Store: ObservableObject {
    
    @Published private(set) var jems: [Product] = []
    @Published private(set) var items: [Product] = []
    @Published private(set) var subscriptions: [Product] = []
    @Published private(set) var nonRenewables: [Product] = []
    
    @Published private(set) var purchasedItems: [Product] = []
    @Published private(set) var purchasedNonRenewableSubscriptions: [Product] = []
    @Published private(set) var purchasedSubscriptions: [Product] = []
    @Published private(set) var subscriptionGroupStatus: RenewalState?
    
    var updateListenerTask: Task<Void, Error>? = nil
    
    private let productIdToEmoji: [String: String]
    static let shared = Store()
    
    private init() {
        productIdToEmoji = Store.loadProductIdToEmojiData()
        
        jems = []
        items = []
        subscriptions = []
        nonRenewables = []
        
        updateListenerTask = listenForTransactions()
        
        Task {
            await requestProducts()
            await updateCustomerProductStatus()
        }
    }
    
    deinit {
        updateListenerTask?.cancel()
    }
    
    static func loadProductIdToEmojiData() -> [String: String] {
        guard let path = Bundle.main.path(forResource: "Products", ofType: "plist"),
              let plist = FileManager.default.contents(atPath: path),
              let data = try? PropertyListSerialization.propertyList(from: plist, format: nil) as? [String: String] else {
            return [:]
        }
        return data
    }
    
    func listenForTransactions() -> Task<Void, Error> {
        return Task.detached {
            for await result in Transaction.updates {
                do {
                    let transaction = try self.checkVerified(result)
                    
                    await self.updateCustomerProductStatus()
                    
                    await transaction.finish()
                } catch {
                    print("Transaction failed verification")
                }
            }
        }
    }
    
    @MainActor
    func requestProducts() async {
        do {
            let storeProducts = try await Product.products(for: productIdToEmoji.keys)
            
            var newJems: [Product] = []
            var newItems: [Product] = []
            var newSubscriptions: [Product] = []
            var newNonRenewables: [Product] = []
            
            for product in storeProducts {
                switch product.type {
                case .consumable:
                    newItems.append(product)
                case .nonConsumable:
                    newJems.append(product)
                case .autoRenewable:
                    newSubscriptions.append(product)
                case .nonRenewable:
                    newNonRenewables.append(product)
                default:
                    print("Unknown product")
                }
            }
            
            jems = sortByPrice(newJems)
            items = sortByPrice(newItems)
            subscriptions = sortByPrice(newSubscriptions)
            nonRenewables = sortByPrice(newNonRenewables)
            print(jems)
            print(items)
            print(subscriptions)
            print(nonRenewables)
            print("PurchaseViewModel")
        } catch {
            print("Failed product request from the App Store server: \(error)")
        }
    }
    
    func checkVerified<T>(_ result: VerificationResult<T>) throws -> T {
        switch result {
        case .unverified:
            throw StoreError.failedVerification
        case .verified(let safe):
            return safe
        }
    }
    
    @MainActor
    func updateCustomerProductStatus() async {
        var purchasedItems: [Product] = []
        var purchasedSubscriptions: [Product] = []
        var purchasedNonRenewableSubscriptions: [Product] = []
        
        for await result in Transaction.currentEntitlements {
            do {
                let transaction = try checkVerified(result)
                
                switch transaction.productType {
                case .nonConsumable:
                    if let item = items.first(where: { $0.id == transaction.productID }) {
                        purchasedItems.append(item)
                    }
                case .nonRenewable:
                    if let nonRenewable = nonRenewables.first(where: { $0.id == transaction.productID }),
                       transaction.productID == "nonRenewing.standard" {
                        let currentDate = Date()
                        let expirationDate = Calendar(identifier: .gregorian).date(byAdding: DateComponents(year: 1),
                                                                                   to: transaction.purchaseDate)!
                        
                        if currentDate < expirationDate {
                            purchasedNonRenewableSubscriptions.append(nonRenewable)
                        }
                    }
                case .autoRenewable:
                    if let subscription = subscriptions.first(where: { $0.id == transaction.productID }) {
                        purchasedSubscriptions.append(subscription)
                    }
                default:
                    break
                }
            } catch {
                print()
            }
        }
        
        self.purchasedItems = purchasedItems
        self.purchasedNonRenewableSubscriptions = purchasedNonRenewableSubscriptions
        self.purchasedSubscriptions = purchasedSubscriptions
        
        subscriptionGroupStatus = try? await subscriptions.first?.subscription?.status.first?.state
    }
    
    func sortByPrice(_ products: [Product]) -> [Product] {
        products.sorted(by: { return $0.price < $1.price })
    }
}
