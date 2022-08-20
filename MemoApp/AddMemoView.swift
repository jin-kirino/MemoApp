//
//  AddMemoView.swift
//  MemoApp
//
//  Created by 神　樹里乃 on 2022/07/24.
//

import SwiftUI

 struct AddMemoView: View {
     @Environment(\.managedObjectContext) private var context
     @Environment(\.dismiss) var dismiss
     @State private var content: String = ""
     @State private var date: Date = Date()

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
            TextEditor(text: $content)
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
            DatePicker("", selection: $date, displayedComponents: .date)
                // タイトルいらないから
                .labelsHidden()
                .foregroundColor(.blue)
                .padding()
            Button {
                // 初期画面にメモを追加
               addMemo()
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

     private func addMemo() {
         let memo = Memo(context: context)
         memo.content = content
         memo.date = Date()

         try? context.save()

         dismiss()
     }// addMemo
}// AddMemoView

 struct AddMemoView_Previews: PreviewProvider {
    static var previews: some View {
        AddMemoView()
    }
 }
