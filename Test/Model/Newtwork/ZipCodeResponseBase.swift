import Foundation

struct ZipCodeResponseBase: Decodable {
    var message: String?
    var results: [Address]
    var status: Int
    
    struct Address: Decodable {
        var address1: String
        var address2: String
        var address3: String
        var kana1: String
        var kana2: String
        var kana3: String
        var prefcode: String
        var zipcode: String
    }
}
