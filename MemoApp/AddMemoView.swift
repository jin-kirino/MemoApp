//
//  AddMemoView.swift
//  MemoApp
//
//  Created by 神　樹里乃 on 2022/07/24.
//

import SwiftUI

struct AddMemoView: View {
    struct MemoData {
        // ない時もある「なし」と表示する
        var memo: String?
        var date: Date?
    }// MemoData

    @State var newMemo: String = ""
    // キーボード表示
    @FocusState private var focusedField: Bool
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
            TextEditor(text: $newMemo)
                .focused($focusedField)
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
            DatePicker("", selection: $slectionDate, displayedComponents: .date)
                // タイトルいらないから
                .labelsHidden()
                .foregroundColor(.blue)
                .padding()
            Button {
                // 初期画面にメモを追加
                // シートを閉じる
                dismiss()
            } label: {
                Text("＋ 追加")
                    .frame(width: 300)
                    .padding()
            }
            .foregroundColor(.white)
            .background(graddientView)
            .cornerRadius(10)
        }// VStack
        // キーボードを表示
        .onTapGesture {
            focusedField = true
        }
    }// body
}// AddMemoView

struct AddMemoView_Previews: PreviewProvider {
    static var previews: some View {
        AddMemoView()
    }
}
