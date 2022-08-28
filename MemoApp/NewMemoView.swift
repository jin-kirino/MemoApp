//
//  NewMemoView.swift
//  MemoApp
//
//  Created by 神　樹里乃 on 2022/08/25.
//

import SwiftUI

struct NewMemoView: View {
    // 被管理オブジェクトコンテキスト（ManagedObjectContext）の取得
    @ObservedObject var viewModel: HomeViewModel
    // データの取得
    @Environment(\.managedObjectContext) var context
    // Buttonのグラデーションの配色の設定
    static let startColor = Color("startVolor")
    static let finishColor = Color("finishColor")
    private let graddientView = LinearGradient(gradient: Gradient(colors: [Color("startColor"), Color("finishColor")]), startPoint: .leading, endPoint: .trailing)

    var body: some View {
        VStack {
            HStack {
                Text(viewModel.memo == nil ? "メモの追加" : "メモの編集")
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
                Label(viewModel.memo == nil ? "追加" : "編集", systemImage: "plus")
                    .frame(maxWidth: .infinity)
                    .frame(height: 50)
                    .foregroundColor(.white)
                    .background(graddientView)
                    .cornerRadius(10)
            }// Button
            .padding()
        }// VStack
    }// body
}// NewMemoView
