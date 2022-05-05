//
//  SignInView.swift
//  DesignCodeiOS15
//
//  Created by mk on 2022/05/05.
//

import SwiftUI

struct SignInView: View {
	
	@EnvironmentObject var model: Model
	
	enum Field: Hashable { case email; case password }
	@FocusState var focusedField: Field?
	
	@State var email = ""
	@State var password = ""
	@State var emailY: CGFloat = 0
	@State var passwordY: CGFloat = 0
	
	@State var circleY: CGFloat = 120
	@State var circleColor: Color = .blue
	
	@State var appear = [false, false, false]
	
	var body: some View {
		
		VStack(alignment: .leading, spacing: 16) {
			
			Text("Sign in")
				.font(.largeTitle.bold())
				.opacity(appear[0] ? 1 : 0)
				.offset(y: appear[0] ? 0 : 20)
			
			Text("Access 120+ hours of courses, tutorials and livestreams")
				.font(.headline)
				.opacity(appear[1] ? 1 : 0)
				.offset(y: appear[1] ? 0 : 20)
			
			TextField("Email", text: $email)
				.inputStyle(icon: "mail")
				.textContentType(.emailAddress)
				.keyboardType(.emailAddress)
				.autocapitalization(.none)
				.disableAutocorrection(true)
				.focused($focusedField, equals: .email)
				.shadow(color: focusedField == .email ? .primary.opacity(0.3) : .clear, radius: 10, x: 0, y: 3)
				.overlay(geometry)
				.onPreferenceChange(CirclePreferenceKey.self) { value in
					emailY = value
					circleY = value
				}
			
			SecureField("Password", text: $password)
				.inputStyle(icon: "lock")
				.textContentType(.password)
				.focused($focusedField, equals: .password)
				.shadow(color: focusedField == .password ? .primary.opacity(0.3) : .clear, radius: 10, x: 0, y: 3)
				.overlay(geometry)
				.onPreferenceChange(CirclePreferenceKey.self) { value in
					passwordY = value
				}
				
			Button {
				
			} label: {
				
				Text("Sign in")
					.frame(maxWidth: .infinity)
			}
			.font(.headline)
			.blendMode(.overlay)
			.buttonStyle(.angular)
			.tint(.accentColor)
			.controlSize(.large)
			.shadow(color: Color("Shadow").opacity(0.2), radius: 30, x: 0, y: 30)
			
			Group {
				
				Divider()
				
				HStack {
					
					Text("No account?")
					
					Button {
						model.selectedModal = .signUp
					} label: {
						Text("**Sign up**")
					}
				}
				.font(.footnote)
				.foregroundColor(.secondary)
				.accentColor(.secondary)
			}
			.opacity(appear[2] ? 1 : 0)
			.offset(y: appear[2] ? 0 : 20)
		}
		.padding(20)
		.background(.ultraThinMaterial, in: RoundedRectangle(cornerRadius: 30, style: .continuous))
		.background(
			Circle()
				.fill(circleColor)
				.frame(width: 68, height: 68)
				.frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .topLeading)
				.offset(y: circleY))
		.coordinateSpace(name: "container")
		.strokeStyle(cornerRadius: 30)
		.onChange(of: focusedField) { value in
			withAnimation {
				if value == .email {
					circleY = emailY
					circleColor = .blue
				}
				else {
					circleY = passwordY
					circleColor = .red
				}
			}
		}
		.onAppear {
			withAnimation(.spring().delay(0.1)) {
				appear[0] = true
			}
			withAnimation(.spring().delay(0.2)) {
				appear[1] = true
			}
			withAnimation(.spring().delay(0.3)) {
				appear[2] = true
			}
		}
	}
	
	var geometry: some View {
		
		GeometryReader { proxy in
			Color.clear.preference(key: CirclePreferenceKey.self, value: proxy.frame(in: .named("container")).minY)
		}
	}
}

struct SignInView_Previews: PreviewProvider {
	
    static var previews: some View {
		
		ZStack {
			SignInView()
				.environmentObject(Model())
		}
    }
}
