import SwiftUI

struct RadioButtonsView: View {
    @ObservedObject var viewModel: RadioButtonsViewModel = RadioButtonsViewModel()
    
    let jobs = ["戦士", "武闘家", "僧侶", "魔法使い", "商人", "遊び人", "盗賊", "賢者"]
    
    var body: some View {
        VStack {
            Text("職業を選んでください")
//            verticalLayout()
            listLayout()
        }
    }
    
    private func verticalLayout() -> some View {
        return VStack (alignment: .leading) {
            ForEach(jobs, id: \.self) { job in
                radioButtonView(job: job)
                    .onTapGesture {
                        self.viewModel.updateSelectedJob(selectedJob: job)
                    }
            }
        }
    }
    
    // ラジオボタンと項目名のView
    private func radioButtonView(job: String) -> some View {
        return HStack {
            Button {
                self.viewModel.updateSelectedJob(selectedJob: job)
            } label: {
                Image(systemName: self.viewModel.getRadioButtonImage(job: job))
                    .font(.system(size: 20))
            }
            Text(job)
                .font(.system(size: 20))
        }
    }
    
    private func listLayout() -> some View {
        return List {
            ForEach(jobs, id: \.self) { job in
                radioButtonCell(job: job)
                    .contentShape(Rectangle())
                    .onTapGesture {
                        self.viewModel.updateSelectedJob(selectedJob: job)
                    }
            }
        }
    }
    
    // ラジオボタンと項目名のセル（セル全体がタップ対象領域）
    private func radioButtonCell(job: String) -> some View {
        return HStack {
            Image(systemName: self.viewModel.getRadioButtonImage(job: job))
                .font(.system(size: 20))
                .foregroundColor(self.viewModel.getRadioButtonColor(job: job))
            Text(job)
                .font(.system(size: 20))
            Spacer()
        }
    }
    
    
}
