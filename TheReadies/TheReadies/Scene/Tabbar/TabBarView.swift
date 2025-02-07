//
//  TabBarView.swift
//  TheReadies
//
//  Created by Luke Nguyen on 7/2/25.
//

import SwiftUI

struct TabbarView: View {
    @State var selectedTab = 0
    
    init() {
        UITabBar.appearance().backgroundColor = UIColor.white
    }
    
    var body: some View {
        TabView(selection: $selectedTab) {
            HomeView()
                .tag(0)
                .tabItem {
                    Image(systemName: "books.vertical.fill")
                    Text("Books")
                }
            
            HomeView()
                .tag(1)
                .tabItem {
                    Image(systemName: "chart.line.uptrend.xyaxis")
                    Text("Stats")
                }
        }
        .accentColor(Color(.black))
    }
}

#Preview {
    TabbarView()
}
