import Foundation

func createStrings(_ number: Int) -> [String] {
	var results = [String]()
	
	for index in 1...number {
		results.append("\(index)/\(number)")
	}
	
	return results
}

func milliseconds(_ seconds: TimeInterval) -> String {
	String(String((seconds * 1000)).prefix(6))
}
