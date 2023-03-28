//
//  WheelPointer.swift
//  Wheely
//
//  Created by Antony Gardiner on 28/03/23.
//

import SwiftUI

/// A pointer for the wheel
struct WheelPointer: View {
	var color: Color = Color.black
	var body: some View {
		Triangle().frame(width: 50, height: 50)
			.foregroundColor(color)
			.shadow(color: .white, radius: 5)
	}
}

struct WheelPointer_Previews: PreviewProvider {
	static var previews: some View {
		WheelPointer(color: .red)
	}
}
