import Foundation

extension Date {
    func transeJapaneseDateString() -> String {
        let format = Date.FormatStyle().locale(Locale(identifier: "ja_JP"))
                    .year()
                    .month(.twoDigits)
                    .day(.twoDigits)
                    .weekday(.abbreviated)
                    .hour(.twoDigits(amPM: .wide))
                    .minute(.twoDigits)
                    .second(.twoDigits)
        return format.format(self)
    }
}
