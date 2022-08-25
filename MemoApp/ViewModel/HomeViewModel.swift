//
//  HomeViewModel.swift
//  MemoApp
//
//  Created by 神　樹里乃 on 2022/08/21.
//

import SwiftUI
import CoreData

// CoreDataへの追加、編集の機能
class HomeViewModel: ObservableObject {
    // メモ内容を格納する変数
    @Published var content: String = ""
    // 日付を格納する変数
    @Published var date: Date = Date()
    // テーブルを管理
    @Published var memo: Memo!
    // 追加・編集シートを管理
    @Published var isNewData = false

    // CoreDataにメモ内容を保存
    func writeMemo(context: NSManagedObjectContext) {
        // 《編集》テーブルにデータがある時
        if memo != nil {
            // contentを更新
            memo.content = content
            // dateを更新
            memo.date = date
            // DBの内容を上書き保存
            try? context.save()

            // まっさらな状態に戻す
            memo = nil
            // シートを表示
            isNewData.toggle()
            // 初期値に戻す
            content = ""
            date = Date()
            return
        }// if
        // 《追加》デーブルにデータがない
        let newMemo = Memo(context: context)
        // メモ内容を格納
        newMemo.content = content
        // 日付を格納
        newMemo.date = date

        do {
            try context.save()
            isNewData.toggle()
            content = ""
            date = Date()

        } catch {
            print(error.localizedDescription)
        }
    }// writeMemo

    func editMemo(editMemo: Memo) {
        memo = editMemo

        content = editMemo.content!
        date = editMemo.date!
        isNewData.toggle()
    }// EditMemo
}// HomeViewModel
