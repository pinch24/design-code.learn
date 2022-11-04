//
//  SeatsView.swift
//  MovieBooking
//
//  Created by mk on 2022/10/28.
//

import SwiftUI

struct SeatsView: View {
	@Environment(\.dismiss) var dismiss
	
	@State var animated = false
	@State var showButton = false
	
    var body: some View {
		VStack(spacing: 0) {
			HStack {
				CircleButton(action: {
					dismiss()
				}, image: "arrow.left")
				
				Spacer()
				
				Text("Choose Seats")
					.font(.title3)
					.foregroundColor(.white)
					.fontWeight(.bold)
				
				Spacer()
				
				CircleButton(action: {}, image: "calendar")
			}
			.padding(.top, 46)
			.padding(.horizontal, 20)
			
			Image("frontSeat")
				.padding(.top, 55)
				.glow(color: Color("pink"), radius: 20)
			
			Image("seats")
				.frame(height: 240)
				.padding(.top, 60)
				.padding(.horizontal, 20)
				.onTapGesture {
					withAnimation(.spring()) {
						showButton = true
					}
				}
			
			HStack(spacing: 2) {
				StatusUI()
				StatusUI(color: Color("magenta"), text: "Reserved")
				StatusUI(color: Color("cyan"), text: "Selected")
			}
			.padding(.top, 60)
			
			ZStack(alignment: .topLeading) {
				Circle()
					.frame(width: 200, height: 200)
					.foregroundColor(Color("purple"))
					.blur(radius: animated ? 70 : 100)
					.offset(x: animated ? -100 : 20, y: animated ? -20 : 20)
					.task {
						withAnimation(.easeInOut(duration: 7).repeatForever()) {
							animated.toggle()
						}
					}
				
				Circle()
					.frame(width: 200, height: 200)
					.foregroundColor(Color("lightBlue"))
					.blur(radius: animated ? 50 : 100)
					.offset(x: animated ? 50 : 70, y: animated ? 70 : 30)
				
				Circle()
					.frame(width: 200, height: 200)
					.foregroundColor(Color("pink"))
					.blur(radius: animated ? 50 : 100)
					.offset(x: animated ? 150 : 170, y: animated ? 90 : 100)
				
				VStack(alignment: .leading, spacing: 30) {
					HStack(spacing: 10) {
						Image(systemName: "calendar")
						Text("November 4, 2022")
						Circle()
							.frame(width: 6, height: 6)
						Text("6 p.m.")
					}
					
					HStack(spacing: 10) {
						Image(systemName: "ticket.fill")
						Text("VIP Section")
						Circle()
							.frame(width: 6, height: 6)
						Text("Seat 9, 10")
					}
					
					HStack(spacing: 10) {
						Image(systemName: "cart.fill")
						Text("Total: $30")
					}
				}
				.padding(42)
				.font(.subheadline)
			}
			.frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .topLeading)
			.clipped()
			.foregroundColor(.white)
			.background(.ultraThinMaterial)
			.padding(.top, 50)
			.offset(y: showButton ? 0 : 250)
		}
		.frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .top)
		.background(Color("backgroundColor"))
		.ignoresSafeArea()
		.navigationBarBackButtonHidden(true)
    }
}

struct SeatView_Previews: PreviewProvider {
    static var previews: some View {
        SeatsView()
    }
}
