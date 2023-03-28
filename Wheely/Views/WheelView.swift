//
//  WheelView.swift
//  Wheely
//
//  Created by Antony Gardiner on 28/03/23.
//

import SwiftUI

struct WheelView: View {
	@Binding var rotation: CGFloat
	@Binding var segments: [WheelyValue]
	
	var body: some View {
		GeometryReader { gr in
			ZStack {
				ForEach(segments.indices, id: \.self) { index in
					ZStack {
						// Create a part of a circle for each segment
						Circle()
							.inset(by: gr.size.width / 4)
							.trim(from: CGFloat(index) * segmentSize, to: CGFloat(index + 1) * segmentSize)
							.stroke(segments[index].color, style: StrokeStyle(lineWidth: gr.size.width / 2))
							.rotationEffect(.radians(.pi * segmentSize))
						
						// Layout the text for this segment
						label(text: segments[index].name, index: CGFloat(index), offset: gr.size.width / 4)
					}
				}
			}
			.animation(.easeInOut(duration: 0.5), value: segments.count)
		}
	}
	
	var segmentSize: CGFloat {
		1 / CGFloat(segments.count)
	}
	
	func rotation(index: CGFloat) -> CGFloat {
		(.pi * (2 * segmentSize * (CGFloat(index + 1))))
	}
	
	func label(text: String, index: CGFloat, offset: CGFloat) -> some View {
		Text(text)
			.rotationEffect(.radians(rotation(index: CGFloat(index))))
			.offset(x: cos(rotation(index: index)) * offset, y: sin(rotation(index: index)) * offset)
			.font(.title2)
			.foregroundColor(.black)
			.shadow(color: .gray, radius: 5)
	}
}

struct WheelView_Previews: PreviewProvider {
	static var rotation: CGFloat = 0.0
	static var previews: some View {
		let segments: [WheelyValue] = [
			WheelyValue(name: "", color: .red),
			WheelyValue(name: "", color: .orange),
			WheelyValue(name: "", color: .yellow),
			WheelyValue(name: "", color: .green),
			WheelyValue(name: "", color: .blue),
			WheelyValue(name: "", color: .indigo),
			WheelyValue(name: "", color: .purple),
			WheelyValue(name: "", color: .pink),
			WheelyValue(name: "", color: .teal),
			WheelyValue(name: "", color: .mint),
			WheelyValue(name: "", color: .brown),
			WheelyValue(name: "", color: .cyan),
		]
		
		WheelView(rotation: .constant(rotation), segments: .constant(segments))
	}
}
