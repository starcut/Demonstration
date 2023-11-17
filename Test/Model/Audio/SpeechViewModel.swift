import AVFAudio
import Foundation

class SpeechViewModel: ObservableObject {
    private let speechSynthesizer = AVSpeechSynthesizer()
    @Published var speechText: String = ""
    
    func readText() {
        speechSynthesizer.stopSpeaking(at: .immediate)
        let utterance = AVSpeechUtterance(string: speechText)
        utterance.voice = AVSpeechSynthesisVoice(language: "ja-JP")
        utterance.pitchMultiplier = 1.0
        utterance.rate = 0.6
        speechSynthesizer.speak(utterance)
    }
}
