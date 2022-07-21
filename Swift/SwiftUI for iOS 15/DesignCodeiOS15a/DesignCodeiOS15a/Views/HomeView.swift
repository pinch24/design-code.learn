//
//  HomeView.swift
//  DesignCodeiOS15a
//
//  Created by mk on 2022/07/12.
//

import SwiftUI

struct HomeView: View {
	
	@Namespace var namespace
	
	@State var show = false
	@State var showStatusBar = true
	@State var hasScrolled = false
	
    var body: some View {
		ZStack {
			Color("Background")
				.ignoresSafeArea()
			
			ScrollView {
				scrollDetection
				
				featured
				
				Text("Courses".uppercased())
					.font(.footnote.weight(.semibold))
					.foregroundColor(.secondary)
					.frame(maxWidth: .infinity, alignment: .leading)
					.padding(.horizontal, 20)
				
				if show == false {
					CourseItem(namespace: namespace, show: $show)
						.onTapGesture {
							withAnimation(.openCard) {
								show.toggle()
								showStatusBar = false
							}
						}
				}
			}
			.coordinateSpace(name: "scroll")
			.safeAreaInset(edge: .top, content: {
				Color.clear.frame(height: 70)
			})
			.overlay(
				NavigationBar(hasScrolled: $hasScrolled, title: "Featured")
			)
			
			if show {
				CourseView(show: $show, namespace: namespace)
					.zIndex(1)
					.transition(.asymmetric(
						insertion: .opacity.animation(.easeInOut(duration: 0.1)),
						removal: .opacity.animation(.easeInOut(duration: 0.3).delay(0.2))))
			}
		}
		.statusBarHidden(showStatusBar == false)
		.onChange(of: show) { newValue in
			withAnimation(.closeCard) {
				if newValue {
					showStatusBar = false
				}
				else {
					showStatusBar = true
				}
			}
		}
    }
	
	var scrollDetection: some View {
		GeometryReader { proxy in
			//Text("\(proxy.frame(in: .named("scroll")).minY)")
			Color.clear.preference(key: ScrollPreferenceKey.self, value: proxy.frame(in: .named("scroll")).minY)
		}
		.frame(height: 0)
		.onPreferenceChange(ScrollPreferenceKey.self, perform: { value in
			withAnimation(.easeInOut) {
				hasScrolled = value < 0 ? true : false
			}
		})
	}
	
	var featured: some View {
		TabView {
			ForEach(courses) { course in
				GeometryReader { proxy in
					let minX = proxy.frame(in: .global).minX
					FeaturedItem(course: course)
						.padding(.vertical, 40)
						.rotation3DEffect(
							.degrees(minX / -10),
							axis: (x: 1, y: 1, z: 0))
						.shadow(color: Color("Shadow").opacity(0.3), radius: 10, x: 0, y: 10)
						.blur(radius: abs(minX / 40))
						.overlay(
							Image(course.image)
								.resizable()
								.aspectRatio(contentMode: .fit)
								.frame(height: 230)
								.offset(x: 32, y: -80)
								.offset(x: minX)
						)
					//Text("\(proxy.frame(in: .global).minX)")
				}
			}
		}
		.tabViewStyle(.page(indexDisplayMode: .never))
		.frame(height: 430)
		.background(
			Image("Blob 1")
				.offset(x: 250, y: -100)
		)
	}
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
			.preferredColorScheme(.dark)
			.previewDevice("iPhone 13 mini")
		
		HomeView()
    }
}
