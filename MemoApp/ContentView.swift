//
//  ContentView.swift
//  MemoApp
//
//  Created by 神　樹里乃 on 2022/07/21.
//

import SwiftUI
import CoreData

struct ContentView: View {
    // Listで表示
    @State var memos: [String] = []
    // AddMemoViewを管理
    @State private var addMemoView: Bool = false
    // EditMemoViewを管理
    @State private var editMemoView: Bool = false
    // 一旦メモの内容
    @State var newMemo: String = ""
    // Buttonのグラデーションの配色の設定
    let graddientView = AngularGradient(
        gradient: Gradient(colors: [.black, .blue, .green]), center: .center)

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

    var body: some View {
        NavigationView {
            ZStack {
                if memos.isEmpty {
                    ZStack {
                        // 自作のグレー
                        Color("backgroundColor")
                            .ignoresSafeArea()
                        Text("なし")
                            .font(.title)
                            .fontWeight(.bold)
                    }
                } else {
                    List {
                        ForEach(memos, id: \.self) { memo in
                            Button {
                                editMemoView.toggle()
                            } label: {
                                Text("\(memo)")
                            }
                            .sheet(isPresented: $editMemoView) {
                                EditMemoView()
                            }// sheet
                        }// ForEach
                        .onDelete(perform: removeRows)
                    }// List
                    .listStyle(.plain)
                }// if else
                VStack {
                    Spacer()
                    HStack {
                        Spacer()
                        Button {
                            // AddMemoViewを表示
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
                            AddMemoView(memos: $memos)
                        }// sheet
                    }// HStack
                }// VStack
            }// ZStack
            .navigationTitle("メモの一覧")
        }// NagvigationView
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
