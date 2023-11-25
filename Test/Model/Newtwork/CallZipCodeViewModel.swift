import Alamofire
import Foundation

class CallZipCodeViewModel: ObservableObject {
    @Published var zipCode: String = ""
    @Published var jsonData = ""
    @Published var isShownProgressView = false
    
    @Published var zipText: String = ""
    @Published var addressText: String = ""
    @Published var addressKana: String = ""
    
    private let baseUrl = "https://zipcloud.ibsnet.co.jp/api/search"
    
    func pushedSearchButton() {
        isShownProgressView = true
        jsonData = ""
        zipText = ""
        addressText = ""
        addressKana = ""
        
        let params: [String : String] = ["zipcode" : zipCode]
        
        AF.request(baseUrl, method: .get, parameters: params).responseData { [weak self] response in
            guard let self else {
                return
            }
            
            self.isShownProgressView = false
            guard let data = response.data else {
                print("No Data")
                return
            }
            do {
                let decoder: JSONDecoder = JSONDecoder()
                let zipCodeResponseBase: ZipCodeResponseBase = try decoder.decode(ZipCodeResponseBase.self, from: data)
                guard let zipCodeData = zipCodeResponseBase.results.first else {
                    print("results transfer error")
                    return
                }
                
                self.jsonData = "\(zipCodeResponseBase)"
                
                self.zipText = zipCodeData.zipcode
                self.addressText = zipCodeData.address1 + zipCodeData.address2 + zipCodeData.address3
                self.addressKana = zipCodeData.kana1 + zipCodeData.kana2 + zipCodeData.kana3
            } catch {
                print(error.localizedDescription)
            }
        }
    }
}
