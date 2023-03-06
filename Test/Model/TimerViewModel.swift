import Foundation
import Combine

class TimerViewModel: NSObject, ObservableObject {
    // カウントダウン処理を行う処理の頻度
    private var countDownProcessInterval: TimeInterval = 0.001
    // タイマー
    private var timer: AnyCancellable?
    // タイムリミットの時刻
    private var futureDate: Date = Date()
    
    // 残り時間
    @Published var timeLimit: Double
    // カウントダウンのON/OFF
    @Published var isCountDown: Bool = false
    
    init(defaultTimeLimit: Int) {
        self.timeLimit = Double(defaultTimeLimit)
    }
    
    // 残り時間の表示を更新する
    func updateTime() {
        let remin = Calendar.current.dateComponents([.second, .nanosecond], from: Date(), to: futureDate)
        let second = Double(remin.second ?? 0)
        let nanosecond = Double(remin.nanosecond ?? 0)
        // nanosecondは9桁の整数のため、10の9乗で割る。そのあとsecondに足す。
        self.timeLimit = second + nanosecond/pow(10, 9)
    }
    
    // タイマーを開始する
    func startTimer() {
        self.isCountDown = true
        // countDownProcessIntervalの頻度でupdateTimeメソッドの処理を行う
        self.timer = Timer.publish(every: countDownProcessInterval,
                                   on: .main,
                                   in: .common).autoconnect()
            .sink(receiveValue: { _ in
                self.updateTime()
            })
        // 現在時刻＋残り時間をタイムリミットに設定する（こうすることで、タイマーの一時停止ができる）
        self.futureDate = Calendar.current.date(byAdding: .second, value: Int(self.timeLimit), to: Date()) ?? Date()
        let nanosecond = self.timeLimit.truncatingRemainder(dividingBy: 1)
        self.futureDate = self.futureDate.addingTimeInterval(nanosecond)
    }
    
    // タイマーを一時停止する（処理上はカウントダウン処理を取り消す）
    func pauseTimer() {
        self.timer?.cancel()
    }
    
    // タイマーを止める
    func stopTimer() {
        self.timer = nil
    }
}
