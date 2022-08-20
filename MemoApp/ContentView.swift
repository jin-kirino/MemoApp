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

    // AddMemoViewを管理
    @State private var addMemoView: Bool = false
    // EditMemoViewを管理
//    @State private var editMemoView: Bool = false
    // Buttonのグラデーションの配色の設定
    private let graddientView = AngularGradient(
        gradient: Gradient(colors: [.black, .blue, .green]), center: .center)

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
                    Text("なし")
                        .font(.title)
                        .fontWeight(.bold)
                } else {
                    List {
                        ForEach(fetchedMemoList) { memo in
                            NavigationLink(destination: EditMemoView(memo: memo)) {
                                VStack {
                                    Text(memo.content ?? "")
                                        .font(.title)
                                        .frame(maxWidth: .infinity, alignment: .leading)
                                        .lineLimit(2)
                                    Text(memo.stringDateAt)
                                        .font(.caption)
                                        .frame(maxWidth: .infinity, alignment: .leading)
                                        .lineLimit(1)
                                }// VStack
                            }// NavigationLink
                        }// ForEach
                        .onDelete(perform: deleteMemo)
                    }// List
                }// if-else
                VStack {
                    Spacer()
                    HStack {
                        Spacer()
                        Button {
                            // addMemoViewを表示
                            addMemoView.toggle()
                        } label: {
                            Image(systemName: "plus")
                                .frame(width: 70, height: 70)
                                .imageScale(.large)
                                .background(graddientView)
                                .foregroundColor(.white)
                                .clipShape(Circle())
                        }// Button
                        .padding(.trailing, 20.0)
                        .padding(.bottom, 10.0)
                        .sheet(isPresented: $addMemoView) {
                            AddMemoView()
                        }// sheet
                    }// HStack
                }// VStack
            }// ZStack
            .navigationTitle("メモの一覧")
        }// NagvigationView
    }// body

    private func deleteMemo(offsets: IndexSet) {
        offsets.forEach { index in
            context.delete(fetchedMemoList[index])
        }
        // 保存しておく
        try? context.save()
    }// deleteMemo
}// ContentView

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView().environment(\.managedObjectContext, PersistenceController.preview.container.viewContext)
    }
}
