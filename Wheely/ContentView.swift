//
//  ContentView.swift
//  Wheely
//
//  Created by Antony Gardiner on 28/03/23.
//

import SwiftUI

struct ContentView: View {
	
	static let modelUrl = URL.documentsDirectory.appending(component: "wheely-model").appendingPathExtension("json")
	@ObservedObject var wheelyViewModel = WheelyViewModel(with: ContentView.modelUrl)

	var body: some View {
		NavigationStack {
			SpinWheelView()
				.environmentObject(wheelyViewModel)
		}
		.navigationBarTitleDisplayMode(.inline)
	}
}

struct ContentView_Previews: PreviewProvider {
	static var previews: some View {
		ContentView()
	}
	
}
