//
//  ContentView.swift
//  DesignCodeiOS16
//
//  Created by mk on 2023/01/01.
//

import SwiftUI

struct ContentView: View {
	@AppStorage("selectedMenu") var selectedMenu: Menu = .compass
	@GestureState var press = false
	@State var showMenu = false
	
	var longPress: some Gesture {
		LongPressGesture(minimumDuration: 1)
			.updating($press) { currentState, gestureState, transaction in
				gestureState = currentState
			}
			.onEnded { value in
				showMenu = true
			}
	}
	
	var body: some View {
		ZStack {
			Color(.systemBackground)
				.ignoresSafeArea()
			
			switch selectedMenu {
				case .compass:
					MessageView()
				case .card:
					Text("Card")
				case .charts:
					DetailView()
				case .radial:
					Text("Radial")
				case .halfsheet:
					MenuView()
				case .gooey:
					Text("Gooey")
				case .actionbutton:
					Text("Action Button")
			}
		}
		.onTapGesture {}
		.gesture(longPress)
		.sheet(isPresented: $showMenu) {
			MenuView()
				.presentationDetents([.medium, .large])
		}
	}
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
