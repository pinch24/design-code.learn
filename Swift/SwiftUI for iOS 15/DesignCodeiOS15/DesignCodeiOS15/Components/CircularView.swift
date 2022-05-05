//
//  CircularView.swift
//  DesignCodeiOS15
//
//  Created by mk on 2022/05/06.
//

import SwiftUI

struct CircularView: View {
	
	@State var appear = false
	
	var value: CGFloat = 0.2
	
    var body: some View {
		
        Circle()
			.trim(from: 0, to: value)
			.stroke(style: StrokeStyle(lineWidth: 4, lineCap: .round))
			.fill(.angularGradient(colors: [.purple, .pink, .purple], center: .center, startAngle: .degrees(0), endAngle: .degrees(360)))
			.rotationEffect(.degrees(270))
			.onAppear {
				withAnimation(.spring().delay(0.5)) {
					appear = true
				}
			}
			.onDisappear {
				appear = false
			}
    }
}

struct CircularView_Previews: PreviewProvider {
	
    static var previews: some View {
		
        CircularView()
    }
}
