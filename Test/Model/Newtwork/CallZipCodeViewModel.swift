import Alamofire
import Foundation

class CallZipCodeViewModel: ObservableObject {
    @Published var zipCode: String = ""
    @Published var jsonData = ""
    
    private let baseUrl = "https://zipcloud.ibsnet.co.jp/api/search"
    
    func pushedSearchButton() {
        let params: [String : String] = ["zipcode" : zipCode]
        AF.request(baseUrl, method: .get, parameters: params).response { response in
            guard let data = response.data else {
                print("NoData")
                return
            }
            do {
                let responseData = try JSONSerialization.jsonObject(with: data, options: [])
                print(responseData)
                self.jsonData = "\(responseData)"
            } catch {
                print("error")
            }
        }
    }
}
