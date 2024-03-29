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
    // 追加・編集シートを管理
    @Published var isNewData = false
    // テーブルを管理
    var memo: Memo!

    // CoreDataにメモ内容を保存
    func writeMemo(context: NSManagedObjectContext) {
        // 新規の動作、値を代入
        if memo == nil {
            memo = Memo(context: context)
        }
        // メモ内容追加
        memo.content = content
        // 日付追加
        memo.date = date
        // 保存、シート表示、初期化はどっちも一緒
        do {
            try context.save()
            isNewData.toggle()
            content = ""
            date = Date()
            memo = nil
        } catch {
            print(error.localizedDescription)
        }// do-catch
    }// writeMemo
    // メモ編集
    func editMemo(editMemo: Memo) {
        // そのリストを指定
        memo = editMemo
        content = editMemo.content!
        date = editMemo.date!
        isNewData.toggle()
    }// editMemo
}// HomeViewModel
