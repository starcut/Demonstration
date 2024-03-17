import Foundation

class UrlRequest {
//    func connectionRequest(jsonString: [String:Any], complesion: ([String:String], String?) -> ()) {
//        guard let url = URL(string: "https://seeking-star.co.jp") else {
//            return
//        }
//        var request = URLRequest(url: url)
//        var result: [String:Any] = [:]
//        
//        do {
//            request.httpBody = try JSONSerialization.data(withJSONObject: jsonString, options: [])
//        } catch {
//            request.httpBody = nil
//        }
//        request.timeoutInterval = 20.0
//        request.httpMethod = "POST"
//        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
//        request.setValue("gzip", forHTTPHeaderField: "Accept-encoding")
//        
//        let configuration = URLSessionConfiguration.default
//        
//        let session = URLSession(configuration: configuration,
//                                 delegate: self,
//                                 delegateQueue: OperationQueue.main)
//        
//        let task = session.dataTask(with: request) { data, response, error in
//            if error != nil {
//                print("error: \(error)")
//                return
//            }
//            if let httpResponse = response as? HTTPURLResponse {
//                print("ステータスコード：\(httpResponse.statusCode)")
//                if httpResponse.statusCode == 200 {
//                    print("正常終了")
//                    complesion(data, nil)
//                } else {
//                    print("異常終了")
//                }
//            }
//        }
//        task.resume()
//    }
    
//    func UrlSession(session: URLSession, didReceiveChallenge challenge: URLAuthenticationChallenge, complesion: (URLCredential) -> ()) {
//        if challenge.protectionSpace.authenticationMethod == NSURLAuthenticationMethodServerTrust {
//            guard let serverTrust = challenge.protectionSpace.serverTrust,
//                  let certificate: SecCertificate = SecTrustCopyCertificateChain(serverTrust) as! SecCertificate,
//                  let remoteCertificateData = CFBridgingRetain(SecCertificateCopyData(certificate)),
//                  let cerPath = Bundle.main.path(forResource: "seeking-star.co.jp", ofType: "cer"),
//                  let localCertificateData = NSData(contentsOfFile: cerPath) else {
//                return
//            }
//            
//            if remoteCertificateData.isEqual(localCertificateData) {
//                let credentaial = URLCredential(trust: serverTrust)
//                challenge.sender?.use(credentaial, for: challenge)
//                
//            }
//        }
//    }
}
