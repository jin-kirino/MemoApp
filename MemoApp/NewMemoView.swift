//
//  NewData.swift
//  MemoApp
//
//  Created by 神　樹里乃 on 2022/08/25.
//

import SwiftUI

struct NewData: View {
    @ObservedObject var viewModel: HomeViewModel
    @Environment(\.managedObjectContext) var context
    
    var body: some View {
        Text(/*@START_MENU_TOKEN@*/"Hello, World!"/*@END_MENU_TOKEN@*/)
    }
}

// struct NewData_Previews: PreviewProvider {
//    static var previews: some View {
//        NewData()
//    }
// }
