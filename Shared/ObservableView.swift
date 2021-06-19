import SwiftUI
import Observable

struct ObservableView: View {
	var numberOfStrings: Float
	var setTime: (TimeInterval) -> ()
	
	@Observable var currentMessage: String?
	
	var body: some View {
		NavigationView {
			VStack(spacing: 0) {
				Observing($currentMessage) {
					observingBody
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
			.navigationBarTitle("@Observable", displayMode: .inline)
		}
		.navigationViewStyle(StackNavigationViewStyle())
	}
	
	var observingBody: some View {
		let beforeDate = Date()
		
		let body = Group {
			if let currentMessage = currentMessage {
				(Text("Message: ").bold() + Text(currentMessage).foregroundColor(.secondary))
			} else {
				(Text("Message: ").bold() + Text("Not Selected").italic().foregroundColor(.secondary))
			}
		}
		
		setTime(Date().timeIntervalSince(beforeDate))
		
		return body
	}
}

struct ObservableView_Previews: PreviewProvider {
	static var previews: some View {
		ObservableView(numberOfStrings: 100, setTime: { _ in })
	}
}
