//
//  TabBar.swift
//  DesignCodeiOS15
//
//  Created by mk on 2022/04/17.
//

import SwiftUI

struct TabBar: View {
	
	@State var selectedTab: Tab = .home
	@State var color: Color = .teal
	@State var tabItemWidth: CGFloat = 0
	
    var body: some View {
        
		ZStack(alignment: .bottom) {
			
			Group {
				switch selectedTab {
					case .home:
						ContentView()
					case .explore:
						AccountView()
					case .notification:
						AccountView()
					case .library:
						AccountView()
				}
			}
			.frame(maxWidth: .infinity, maxHeight: .infinity)
			
			HStack {
				Spacer()
				buttons
			}
			.padding(.top, 14)
			.frame(height: 88, alignment: .top)
			.background(.ultraThinMaterial, in:
							RoundedRectangle(cornerRadius: 34, style: .continuous))
			.background(background)
			.overlay(overlay)
			.strokeStyle(cornerRadius: 34)
			.frame(maxHeight: .infinity, alignment: .bottom)
			.ignoresSafeArea()
		}
    }
	
	var buttons: some View {
		
		ForEach(tabItems) { item in
			Button {
				withAnimation(.spring(response: 0.3, dampingFraction: 0.7)) {
					selectedTab = item.tab
					color = item.color
				}
			} label: {
				VStack(spacing: 0) {
					Image(systemName: item.icon)
						.symbolVariant(.fill)
						.font(.body.bold())
						.frame(width: 44, height: 29)
					Text(item.text)
						.font(.caption2)
						.lineLimit(1)
				}
				.frame(maxWidth: .infinity)
			}
			.foregroundStyle(selectedTab == item.tab ? .primary : .secondary)
			.blendMode(selectedTab == item.tab ? .overlay : .normal)
			.overlay {
				GeometryReader { proxy in
					//Text("\(proxy.size.height)")
					//tabItemWidth = proxy.size.width
					Color.clear.preference(key: TabPreferenceKey.self, value: proxy.size.width)
				}
			}
			.onPreferenceChange(TabPreferenceKey.self) { value in
				tabItemWidth = value
			}
		}
	}
	
	var background: some View {
		
		HStack {
			if selectedTab == .library { Spacer() }
			if selectedTab == .explore { Spacer() }
			if selectedTab == .notification { Spacer(); Spacer() }
			Circle().fill(color).frame(width: tabItemWidth)
			if selectedTab == .home { Spacer() }
			if selectedTab == .explore { Spacer();Spacer() }
			if selectedTab == .notification { Spacer() }
		}
		.padding(.horizontal, 8)
	}
	
	var overlay: some View {
		
		HStack {
			if selectedTab == .library { Spacer() }
			if selectedTab == .explore { Spacer() }
			if selectedTab == .notification { Spacer();Spacer() }
			Rectangle()
				.fill(color)
				.frame(width: 28, height: 5)
				.cornerRadius(3)
				.frame(width: tabItemWidth)
				.frame(maxHeight: .infinity, alignment: .top)
			if selectedTab == .home { Spacer() }
			if selectedTab == .explore { Spacer(); Spacer() }
			if selectedTab == .notification { Spacer() }
		}
		.padding(.horizontal, 8)
	}
}

struct TabBar_Previews: PreviewProvider {
    static var previews: some View {
		TabBar()
			.previewInterfaceOrientation(.portrait)
    }
}
