//
//  EditMemo.swift
//  MemoApp
//
//  Created by 神　樹里乃 on 2022/07/30.
//
//
 import SwiftUI

 struct EditMemoView: View {
     @Environment(\.managedObjectContext) private var context
     @Environment(\.dismiss) var dismiss
     @State var content: String = ""
     @State var date: Date = Date()
     var memo: Memo

     // イニシャライザ
     init(memo: Memo) {
         self.memo = memo
         _content = State(initialValue: memo.content ?? "")
         _date = State(initialValue: memo.date ?? Date())
     }
    // Buttonのグラデーションの配色の設定
    private let graddientView = LinearGradient(gradient: Gradient(colors: [.black, .blue, .green]), startPoint: .leading, endPoint: .trailing)

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
            // 元々選択されていた日付を表示させておく
            DatePicker("", selection: $date, displayedComponents: .date)
                // タイトルいらないから
                .labelsHidden()
                .foregroundColor(.blue)
                .padding()
            Button {
                // 編集した内容を初期画面に表示
                saveMemo()
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

     private func saveMemo() {
         memo.content = content
         memo.date = date
         // 保存しとく
         try? context.save()
         // シート閉じる
         dismiss()
     }// saveMemo
}// EditMemoView

// struct EditMemoView_Previews: PreviewProvider {
//    static var previews: some View {
//        EditMemoView(memo: Memo(), content: content, date: date)
//    }
// }
