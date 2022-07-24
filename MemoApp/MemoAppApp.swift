//
//  MemoAppApp.swift
//  MemoApp
//
//  Created by 神　樹里乃 on 2022/07/21.
//

import SwiftUI

@main
struct MemoAppApp: App {
    // NSPersistentContainer（各クラスをラッピングして使えるようにするクラス）の初期化
    let persistenceController = PersistenceController.shared

    var body: some Scene {
        WindowGroup {
            ContentView()
                // 環境変数 @Environment(\.managedObjectContext)にNSManagedObjectContextを登録する処理
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
    }
}
