import Foundation
import Speech

class LiveAudioViewModel: NSObject, ObservableObject {
    // 音声入力した文字列
    @Published var voiceText: String = ""
    // 音声入力中かどうか
    @Published var audioRunning: Bool = false
    
    private var audioEngine = AVAudioEngine()
    private var speechRecognizer: SFSpeechRecognizer?
    private var recognitionRequest: SFSpeechAudioBufferRecognitionRequest?
    private var recognitionTask: SFSpeechRecognitionTask?
    
    func toggleRecording() {
        if self.audioEngine.isRunning {
            self.stopRecording()
        }
        else{
            self.startRecording()
        }
    }
    
    // 音声認識中止処理
    private func stopRecording() {
        self.recognitionTask?.cancel()
        self.recognitionTask?.finish()
        self.recognitionTask = nil
        
        self.recognitionRequest?.endAudio()
        self.recognitionRequest = nil
        
        self.audioEngine.stop()
        let audioSession = AVAudioSession.sharedInstance()
        do {
            try audioSession.setCategory(AVAudioSession.Category.playback)
            try audioSession.setMode(AVAudioSession.Mode.default)
        } catch {
            print("AVAudioSession error")
        }
        self.audioRunning = false
    }
    
    // 音声認識開始処理
    private func startRecording() {
        audioSessionRecordMode()
        recognizeVoice()
        startAudioEngine()
    }
    
    // audioSessionの録音モード
    private func audioSessionRecordMode() {
        // AVAudioSessionのインスタンス化
        let audioSession = AVAudioSession.sharedInstance()
        do {
            // モードとして、音声入力モード
            try audioSession.setCategory(.record, mode: .measurement, options: .duckOthers)
            // AVAudioSessionをアクティブにする（モードは他の非アクティブなアプリを知らせる）
            try audioSession.setActive(true, options: .notifyOthersOnDeactivation)
        } catch {
            print("AVAudioSession error")
        }
    }
    
    // audioEngineの開始メソッド
    private func startAudioEngine() {
        self.audioEngine.prepare()
        do {
            try self.audioEngine.start()
        } catch {
            print("AudioEngine error")
        }
        self.audioRunning = true
    }
    
    // 音声認識の処理の準備と認識開始処理
    private func recognizeVoice() {
        self.speechRecognizer = SFSpeechRecognizer(locale: Locale(identifier: "ja-JP"))
        guard let speechRecognizer = self.speechRecognizer else {
            print("speechRecognizer nil")
            return
        }
        
        self.recognitionTask = SFSpeechRecognitionTask()
        self.recognitionRequest = SFSpeechAudioBufferRecognitionRequest()
        guard let recognitionRequest = self.recognitionRequest else {
            self.stopRecording()
            return
        }
        recognitionRequest.shouldReportPartialResults = true
        if #available(iOS 13, *) {
            recognitionRequest.requiresOnDeviceRecognition = false
        }
        
        // 入力用のノードを取得
        let inputNode = audioEngine.inputNode
        inputNode.removeTap(onBus: 0)
        // 0番のaudio node busを表すインスタンス
        let recordingFormat = inputNode.outputFormat(forBus: 0)
        inputNode.installTap(onBus: 0,
                             bufferSize: 1024,
                             format: recordingFormat) { (buffer: AVAudioPCMBuffer, _: AVAudioTime) in
            recognitionRequest.append(buffer)
        }
        
        self.voiceText = ""
        self.recognitionTask = speechRecognizer.recognitionTask(with: recognitionRequest) { result, error in
            if(error != nil){
                print (String(describing: error))
                self.stopRecording()
                return
            }
            var isFinal = false
            if let result = result {
                isFinal = result.isFinal
                self.voiceText = result.bestTranscription.formattedString
                print(result.bestTranscription.formattedString)
            }
            if isFinal {
                print("recording time limit")
                self.stopRecording()
                inputNode.removeTap(onBus: 0)
            }
        }
    }
}
