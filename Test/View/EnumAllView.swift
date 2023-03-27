import SwiftUI

struct EnumAllView: View {
    var body: some View {
        Spacer()
        ForEach(MagicAttribute.allCases, id:\.self) { attribute in
            Text(attribute.rawValue)
            Spacer()
        }
    }
}
