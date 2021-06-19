//
//  StateView.swift
//  ObservableSampleApp
//
//  Created by Nick on 6/19/21.
//

import SwiftUI

struct StateView: View {
	var numberOfStrings: Float
	var setTime: (TimeInterval) -> ()
	
	@State var currentMessage: String?
	
	var body: some View {
		let beforeDate = Date()
		
		let body = NavigationView {
			VStack(spacing: 0) {
				Group {
					if let currentMessage = currentMessage {
						(Text("Message: ").bold() + Text(currentMessage).foregroundColor(.secondary))
					} else {
						(Text("Message: ").bold() + Text("Not Selected").italic().foregroundColor(.secondary))
					}
				}
				.font(.headline)
				.padding()
				.frame(maxWidth: .infinity, alignment: .leading)
				.background(Color(.systemFill))
				
				Divider()
					.edgesIgnoringSafeArea([.leading, .trailing])
				
				List {
					ForEach(createStrings(Int(numberOfStrings)), id: \.self) { string in
						Button("Set to \(string)") {
							currentMessage = string
						}
					}
				}
				.listStyle(PlainListStyle())
			}
			.navigationBarTitle("@State", displayMode: .inline)
		}
			.navigationViewStyle(StackNavigationViewStyle())
		
		setTime(Date().timeIntervalSince(beforeDate))
		
		return body
	}
}

struct StateView_Previews: PreviewProvider {
	static var previews: some View {
		StateView(numberOfStrings: 100, setTime: { _ in })
	}
}
