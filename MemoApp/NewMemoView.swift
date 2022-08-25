//
//  NewMemoView.swift
//  MemoApp
//
//  Created by 神　樹里乃 on 2022/08/25.
//

import SwiftUI

struct NewMemoView: View {

    @ObservedObject var viewModel: HomeViewModel
    @Environment(\.managedObjectContext) var context
    // Buttonのグラデーションの配色の設定
    let graddientView = LinearGradient(gradient: Gradient(colors: [.black, .blue, .green]), startPoint: .leading, endPoint: .trailing)

    var body: some View {
        VStack {
            HStack {
                Text("メモの追加")
                    .font(.largeTitle)
                    .fontWeight(.bold)
                    .multilineTextAlignment(.trailing)
                    .padding([.top, .leading])
                Spacer()
            }// HStack
            // メモの内容を表示させておく
            TextEditor(text: $viewModel.content)
            // 区切り線
            Divider()
            HStack {
                Text("いつのメモ？")
                    .font(.largeTitle)
                    .fontWeight(.bold)
                    .multilineTextAlignment(.trailing)
                    .padding([.top, .leading])
                Spacer()
            }// HStack
            // 日付を選択
            // 元々選択されていた日付を表示させておく
            DatePicker("", selection: $viewModel.date, displayedComponents: .date)
                // タイトルいらないから
                .labelsHidden()
                .foregroundColor(.blue)
                .padding()
            Button {
                // 編集した内容を初期画面に表示
                viewModel.writeMemo(context: context)
            } label: {
                Text("＋ 追加")
                    .frame(maxWidth: .infinity)
                    .frame(height: 50)
                    .foregroundColor(.white)
                    .background(graddientView)
                    .cornerRadius(10)
            }// Button
            .padding()
        }// VStack
    }
}

// struct NewMemoView_Previews: PreviewProvider {
//    static var previews: some View {
//        NewMemoView()
//    }
// }
