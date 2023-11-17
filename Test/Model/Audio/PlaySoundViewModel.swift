import AVFoundation
import UIKit
import Foundation

class PlaySoundViewModel: NSObject, ObservableObject {
    private var soundPlayer: AVAudioPlayer?
    
    func playSoundDingdong() {
        guard let data = NSDataAsset(name: "Dingdong")?.data else {
            return
        }
        do {
            soundPlayer = try AVAudioPlayer(data: data)
            soundPlayer?.prepareToPlay()
            soundPlayer?.play()
        } catch {
            print("error")
        }
    }
    
    func playSoundFailure() {
        guard let data = NSDataAsset(name: "Failure")?.data else {
            return
        }
        do {
            soundPlayer = try AVAudioPlayer(data: data)
            soundPlayer?.prepareToPlay()
            soundPlayer?.play()
        } catch {
            print("error")
        }
    }
}
