import SwiftUI
import Observable

struct ContentView: View {
	@Observable var stateTime: TimeInterval?
	@Observable var observableTime: TimeInterval?
	@Observable var numberOfStrings: Float = 10 {
		willSet {
			// Reset statistics
			stateTime = nil
			observableTime = nil
		}
	}
	
    var body: some View {
		VStack(spacing: 0) {
			VStack(alignment: .leading, spacing: 8) {
				Text("Results")
					.bold()
					.font(.largeTitle)
				
				resultView($stateTime) {
					Text("@State")
				}
				
				resultView($observableTime) {
					Observing($stateTime) {
						Observing($observableTime) {
							if let stateTime = stateTime,
							   let observableTime = observableTime {
								Text("@Observable ") + Text("\(Int((1 - observableTime/stateTime) * 100))% faster").italic().foregroundColor(.secondary)
							} else {
								Text("@Observable")
							}
						}
					}
				}
			}
			.padding(8)
			.background(
				RoundedRectangle(cornerRadius: 8, style: .continuous)
					.fill(Color(.systemFill)))
			.padding()
			
			VStack {
				HStack {
					Text("Increase Work")
						.font(.headline)
						.frame(maxWidth: .infinity, alignment: .leading)
					
					Observing($numberOfStrings) {
						Text("\(Int(numberOfStrings)) Strings")
					}
					.font(.system(.body, design: .monospaced))
					.foregroundColor(.secondary)
				}
				
				Observing(bindingOf: $numberOfStrings) { number in
					Slider(value: number, in: 10...1000, step: 1)
				}
			}
			.padding()
			
			Text("Tapping a cell on the left recomputes the whole view body as expected, while tapping an @Observable cell only recomputes the part of the Text after \"Message:\"")
				.bold()
				.frame(maxWidth: .infinity, alignment: .leading)
				.padding([.leading, .bottom, .trailing])
			
			Divider()
				.edgesIgnoringSafeArea([.leading, .trailing])
			
			HStack(spacing: 0) {
				Observing($numberOfStrings) {
					StateView(numberOfStrings: numberOfStrings, setTime: { stateTime = $0 })
				}
				
				Divider()
					.edgesIgnoringSafeArea([.top, .bottom])
				
				Observing($numberOfStrings) {
					ObservableView(numberOfStrings: numberOfStrings, setTime: { observableTime = $0 })
				}
			}
		}
    }
	
	func resultView<Label: View>(_ value: Observable<TimeInterval?>, @ViewBuilder _ label: () -> Label) -> some View {
		VStack(alignment: .leading, spacing: 0) {
			label()
				.font(.headline)
			
			Observing(value) {
				if let time = value.wrappedValue {
					Text("\(milliseconds(time)) ms")
				} else {
					Text("No Result")
						.italic()
						.foregroundColor(.secondary)
				}
			}
			.font(.system(.body, design: .monospaced))
			.frame(maxWidth: .infinity, alignment: .leading)
			.padding(8)
			.background(
				RoundedRectangle(cornerRadius: 8, style: .continuous)
					.fill(Color(.secondarySystemFill)))
		}
	}
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
