//
//  TwoColumnSplitView.swift
//  master_detail
//
//  Created by POU LIN on 2023/10/24.
//

import SwiftUI

struct TwoColumnSplitView: View {
    @State private var selectedCategoryId:MenuItem.ID?
    @State private var selectedItem:MenuItem?
    @State private var columnVisiblity = NavigationSplitViewVisibility.all
    @State private var pathStack: [MenuItem] = []
    
    private var dataModel = CoffeeEquipmenModel()
    private let parks = [
        Park(name: "park1", next: Park(name: "park2", next: Park(name: "park3")))
    ]
    
    var body: some View {
        NavigationSplitView(columnVisibility: $columnVisiblity) {
            List(dataModel.mainMenuItems, selection: $selectedCategoryId) { item in
                HStack {
                    Image(item.image)
                        .resizable()
                        .scaledToFit()
                        .frame(width: 50, height: 50)
                    Text(item.name)
                        .font(.system(.title3, design: .rounded))
                        .bold()
                }
            }
            .navigationTitle("Coffee")
        }
        detail : {
            if let selectedCategoryId,
               let categoryItems = dataModel.subMenuItems(for: selectedCategoryId){
                //                List(categoryItems, selection:$selectedItem) { item in
                //                    NavigationLink(value: item) {
                //                        HStack {
                //                            Image(item.image)
                //                                .resizable()
                //                                .scaledToFit()
                //                                .frame(width: 50, height: 50)
                //                            Text(item.name)
                //                                .font(.system(.title3, design: .rounded))
                //                                .bold()
                //                        }
                //                    }
                //                }
                //                .listStyle(.plain)
                //                .navigationBarTitleDisplayMode(.inline)
                //                SplitViewWithStack()
                
                NavigationStack(path: $pathStack) {
                    MenuItemDetail(item: categoryItems[0], next: categoryItems[1])
                        
                        .navigationDestination(for: MenuItem.self) { _item in
                            let _index = categoryItems.firstIndex(of: _item) ?? 0
                            if _index == 0 {
                                MenuItemDetail(item: _item, next: categoryItems[_index + 1])
                            } else {
                                if (_index + 1) >= categoryItems.count {
                                    
                                    MenuItemDetail(item: _item, previous: categoryItems[_index - 1])
                                } else {
                                    MenuItemDetail(item: _item,
                                                   next: categoryItems[_index + 1], previous: categoryItems[_index - 1])
                                }
                            }
                            
                        }
                    
                }.onAppear() {
                    pathStack = .init()
                }
            } else {
                Text("Please select a category")
            }
        }
        //    detail: {
        //        if let selectedItem {
        //            Image(selectedItem.image)
        //                .resizable()
        //                .scaledToFit()
        //            //            SplitViewWithStack()
        //            
        //        }else {
        //            Text("Please select an item")
        //        }
        //    }
        .navigationSplitViewStyle(.balanced)
    }
}

struct MenuItemDetail: View {
    var item: MenuItem
    var next: MenuItem?
    var previous: MenuItem?
    
    var body: some View {
        VStack {
//            Text("\(item.id)")
            Text("\(item.name)")
                .font(/*@START_MENU_TOKEN@*/.title/*@END_MENU_TOKEN@*/)
            HStack{
                if let _previous = previous {
                    NavigationLink("Go \(_previous.name)", value: _previous)
                }
                Spacer()
                if let _next = next {
                    NavigationLink("Go \(_next.name)", value: _next)
                }
            }
        }
        .navigationTitle(item.name)
    }
}

#Preview {
    TwoColumnSplitView()
}
