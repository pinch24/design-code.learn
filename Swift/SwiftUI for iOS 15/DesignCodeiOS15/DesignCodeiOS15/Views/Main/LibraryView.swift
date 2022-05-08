//
//  LibraryView.swift
//  DesignCodeiOS15
//
//  Created by mk on 2022/05/08.
//

import SwiftUI

struct LibraryView: View {
	
	var body: some View {
		
		ZStack {
			
			Color("Background")
				.ignoresSafeArea()
			
			ScrollView {
				
				CertificateView()
					.frame(height: 220)
					.background(
						RoundedRectangle(cornerRadius: 30, style: .continuous)
							.fill(.linearGradient(colors: [.purple, .blue], startPoint: .topLeading, endPoint: .bottomTrailing))
							.padding(20)
							.offset(y: -30))
					.background(
						RoundedRectangle(cornerRadius: 30, style: .continuous)
							.fill(.linearGradient(colors: [.teal, .blue], startPoint: .topLeading, endPoint: .bottomTrailing))
							.padding(40)
							.offset(y: -60))
					.padding(20)
				
				Text("History".uppercased())
					.titleStyle()
				
				coursesSection
				
				Text("Topics".uppercased())
					.titleStyle()
				
				topicsSection
				
				Text("Certificates".uppercased())
					.titleStyle()
			}
			.safeAreaInset(edge: .top) {
				Color.clear.frame(height: 70)
			}
			.overlay(NavigationBar(hasScrolled: .constant(true), title: "Library"))
			.background(Image("Blob 1").offset(x: -100, y: -400))
		}
	}
	
	var coursesSection: some View {
		
		ScrollView(.horizontal, showsIndicators: false) {
			
			HStack {
				ForEach(courses) { course in
					SmallCourseItem(course: course)
				}
			}
			.padding(.horizontal, 20)
			
			Spacer()
		}
	}
	
	var topicsSection: some View {
		
		VStack {
			ForEach(topics) { topic in
				ListRow(topic: topic)
			}
		}
		.padding(20)
		.background(.ultraThinMaterial, in: RoundedRectangle(cornerRadius: 30, style: .continuous))
		.strokeStyle(cornerRadius: 30)
		.padding(.horizontal, 20)
	}
}

struct LibraryView_Previews: PreviewProvider {
	
    static var previews: some View {
		
        LibraryView()
    }
}
