//
//  EditMemo.swift
//  MemoApp
//
//  Created by 神　樹里乃 on 2022/07/30.
//

import SwiftUI

struct EditMemoView: View {
    // ContentViewに渡す配列
    @Binding var memos: [String]
    // TextEditorの内容
    @State var alradyMemo: String = ""
    // DatePickerの管理
    @State private var slectionDate = Date()
    // 環境変数の取得
    @Environment(\.dismiss) var dismiss
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
            TextEditor(text: $alradyMemo)
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
            DatePicker("", selection: $slectionDate, displayedComponents: .date)
                // タイトルいらないから
                .labelsHidden()
                .foregroundColor(.blue)
                .padding()
            Button {
                // 初期画面にメモを追加
                memos.append(alradyMemo)
                // シートを閉じる
                dismiss()
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
    }// body
}

// struct EditMemoView_Previews: PreviewProvider {
//    static var previews: some View {
//        EditMemoView()
//    }
// }
