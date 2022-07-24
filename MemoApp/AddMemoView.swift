//
//  AddMemoView.swift
//  MemoApp
//
//  Created by 神　樹里乃 on 2022/07/24.
//

import SwiftUI

struct AddMemoView: View {
//    struct MemoData {
//            // ない時もある「なし」と表示する
//            var memo: String?
//            var date: Date?
//    }// MemoData

    @State var newMemo: String = ""
    var body: some View {
        VStack {
            Text("メモの追加")
        }
    }
}

struct AddMemoView_Previews: PreviewProvider {
    static var previews: some View {
        AddMemoView()
    }
}
