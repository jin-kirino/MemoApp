//
//  ContentView.swift
//  MemoApp
//
//  Created by 神　樹里乃 on 2022/07/21.
//

import SwiftUI
import CoreData

struct ContentView: View {
    // 被管理オブジェクトコンテキスト（ManagedObjectContext）の取得
    @Environment(\.managedObjectContext) private var context
    // データの取得
    @FetchRequest(
        entity: Memo.entity(), sortDescriptors: [NSSortDescriptor(keyPath: \Memo.date, ascending: false)],
        animation: .default
    ) private var fetchedMemoList: FetchedResults<Memo>
    // HomeViewModelのデータを定義
    @StateObject var viewModel = HomeViewModel()
    // Buttonのグラデーションの配色の設定
    private let gradationView = AngularGradient(
        gradient: Gradient(colors: [.gradationFrom, .gradationTo]), center: .center)

    init() {
        // UINavigationBarAppearanceを使ってnavigationTitleをカスタマイズ
        let appearance = UINavigationBarAppearance()
        appearance.configureWithOpaqueBackground()
        // 背景に白を指定
        appearance.backgroundColor = .white
        // 文字色に黒を指定
        appearance.titleTextAttributes = [.foregroundColor: UIColor.black]
        appearance.largeTitleTextAttributes = [.foregroundColor: UIColor.black]
        UINavigationBar.appearance().standardAppearance = appearance
        UINavigationBar.appearance().scrollEdgeAppearance = appearance
    }

    var body: some View {
        NavigationView {
            ZStack {
                if fetchedMemoList.isEmpty {
                    // もしデータがなかったら「なし」
                    Text("なし")
                        .font(.title)
                        .fontWeight(.bold)
                } else {
                    // データがあったらリストに表示
                    List {
                        // コアデータ内のデータを一つずつmemoで取り出す
                        ForEach(fetchedMemoList) { memo in
                            // ボタンの機能をつける
                            Button {
                                // NewMemoViewを表示（編集バージョン）
                                viewModel.editMemo(editMemo: memo)
                            } label: {
                                VStack {
                                    // メモの内容
                                    Text(memo.content ?? "")
                                        .font(.title)
                                        .frame(maxWidth: .infinity, alignment: .leading)
                                        .lineLimit(2)
                                    // メモの日付
                                    Text(memo.stringDateAt)
                                        .font(.caption)
                                        .frame(maxWidth: .infinity, alignment: .leading)
                                        .lineLimit(1)
                                }// VStack
                            }// Button
                        }// ForEach
                        .onDelete { indexSet in
                            deleteMemo(offsets: indexSet)
                        }// onDelete
                    }// List
                }// if-else
                VStack {
                    Spacer()
                    HStack {
                        Spacer()
                        Button {
                            // NewMemoViewを表示(追加バージョン)
                            viewModel.isNewData.toggle()
                        } label: {
                            Image(systemName: "plus")
                                .frame(width: 70, height: 70)
                                .imageScale(.large)
                                .background(gradationView)
                                .foregroundColor(.white)
                                .clipShape(Circle())
                        }// Button
                        .padding(.trailing, 20.0)
                        .padding(.bottom, 10.0)
                        .sheet(isPresented: $viewModel.isNewData) {
                            NewMemoView(viewModel: viewModel)
                        }// sheet
                    }// HStack
                }// VStack
            }// ZStack
            .navigationTitle("メモの一覧")
        }// NagvigationView
    }// body
    // メモ削除メソッド
    private func deleteMemo(offsets: IndexSet) {
        offsets.forEach { index in
            context.delete(fetchedMemoList[index])
        }// forEach
        // 保存しておく
        try? context.save()
    }// deleteMemo
}// ContentView

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView().environment(\.managedObjectContext, PersistenceController.preview.container.viewContext)
    }
}
