//
//  ContentView.swift
//  MemoApp
//
//  Created by 神　樹里乃 on 2022/07/21.
//

import SwiftUI
import CoreData

struct ContentView: View {

    @State private var memo: String = ""
    @State private var memos: [String] = []

    init() {
        // UINavigationBarAppearanceを使ってnavigationTitleをカスタマイズ
        let appearance = UINavigationBarAppearance()
        appearance.configureWithOpaqueBackground()
        // 背景に黒を指定
        appearance.backgroundColor = .white
        // 文字色に白を指定
        appearance.titleTextAttributes = [.foregroundColor: UIColor.black]
        appearance.largeTitleTextAttributes = [.foregroundColor: UIColor.black]
        UINavigationBar.appearance().standardAppearance = appearance
        UINavigationBar.appearance().scrollEdgeAppearance = appearance
    }

    // 被管理オブジェクトコンテキスト(ManagedObjectContext)の取得
    // データベースから引っ張ってきたコードデータ、必ずMOCと紐づいている
//    @Environment(\.managedObjectContext) private var viewContext
    // データベースよりデータを取得
//    @FetchRequest(
        // key:日付、ascending: true→昇順（新しいのが下）で並べ替える
//        sortDescriptors: [NSSortDescriptor(keyPath: \Item.timestamp, ascending: true)],
//        animation: .default)
//    private var items: FetchedResults<Item>

    var body: some View {
        NavigationView {
            ZStack {
                Color.gray
                    .ignoresSafeArea()
                VStack {
                    List {
                        ForEach(memos, id: \.self) { memo in
                            Text("\(memo)")
                        }// ForEach
                        .onDelete(perform: removeRows)
                    }// List
                }// VStack
            }// ZStack
            .navigationBarTitle("メモの一覧")
        }// NavigationView
    }// body

    // 行を削除する関数
    func removeRows(at offsets: IndexSet) {
        memos.remove(atOffsets: offsets)
    }// removeRows
}// ContentView

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView().environment(\.managedObjectContext, PersistenceController.preview.container.viewContext)
    }
}
