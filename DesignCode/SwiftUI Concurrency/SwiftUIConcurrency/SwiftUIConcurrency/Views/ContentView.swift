//
//  ContentView.swift
//  SwiftUIConcurrency
//
//  Created by mk on 2023/01/19.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
		TabView {
			HomeView()
				.tabItem {
					Image(systemName: "house")
					Text("Learn now")
			}
		}
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
