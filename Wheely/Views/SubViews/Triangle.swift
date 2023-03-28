//
//  Triangle.swift
//  Wheely
//
//  Created by Antony Gardiner on 28/03/23.
//

import SwiftUI

/// A simple triagle shape
struct Triangle: Shape {
	public func path(in rect: CGRect) -> Path {
		var path = Path()
		path.move(to: CGPoint(x: rect.midX, y: rect.minY))
		path.addLine(to: CGPoint(x: rect.minX, y: rect.maxY))
		path.addLine(to: CGPoint(x: rect.maxX, y: rect.maxY))
		path.addLine(to: CGPoint(x: rect.midX, y: rect.minY))
		return path
	}
}


