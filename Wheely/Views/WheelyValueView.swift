//
//  WheelyValueView.swift
//  Wheely
//
//  Created by Antony Gardiner on 27/03/23.
//

import SwiftUI

/// A simple view showing title and colour.
struct WheelyValueView: View {
	
	@State var value: WheelyValue
	
	var body: some View {
		VStack {
			HStack {
				Text(value.name)
					.font(.title2)
				Spacer()
				Circle()
					.foregroundColor(value.color)
					.shadow(color: .black, radius: 2)
					.frame(width: 40)
			}
			.padding()
		}
	}
}

struct WheelyValueView_Previews: PreviewProvider {
	static var previews: some View {
		WheelyValueView(value: WheelyValue(name: "Bobby", color: .red))
	}
}
