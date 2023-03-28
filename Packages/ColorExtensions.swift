//
//  ColorExtensions.swift
//  Wheely
//
//  Created by Antony Gardiner on 27/03/23.
//

import Foundation
import SwiftUI
import UIKit

extension Color {
	
	/// Convience init method to contruct a color from hex value
	/// - Parameters:
	///   - hex: an Int value of a hex color to use
	///   - opacity: opacity
	public init(hex: Int, opacity: Double = 1.0) {
		let red: Double = (Double((hex & 0xff0000) >> 16)) / 255.0
		let green = Double((hex & 0xff00) >> 8) / 255.0
		let blue = Double((hex & 0xff) >> 0) / 255.0
		self.init(.sRGB, red: red, green: green, blue: blue, opacity: opacity)
	}
	
	/// Convert a Color to it's approximate hex int value
	/// Have not included hex valus that contain opacity.
	/// - Returns: a hex calculated value returned as an Int
	public func toHex() -> Int {
		var hexValue = 0
		
		let uiColor = UIColor(self)
		
		var red: CGFloat = 0
		var green: CGFloat = 0
		var blue: CGFloat = 0
		var alpha: CGFloat = 0
		
		guard uiColor.getRed(&red, green: &green, blue: &blue, alpha: &alpha) else {
			return hexValue
		}
		
		hexValue |= Int((red * 1000000).rounded() / 1000000 * 255) << 16
		hexValue |= Int((green * 1000000).rounded() / 1000000 * 255) << 8
		hexValue |= Int((blue * 1000000).rounded() / 1000000 * 255) << 0

		return hexValue
	}
	
	public static func randomColor() -> Color {
		let red = Double(Int.random(in: 0..<255)) / 255.0
		let green = Double(Int.random(in: 0..<255)) / 255.0
		let blue = Double(Int.random(in: 0..<255)) / 255.0
		return Color(red: red, green: green, blue: blue)
	}
}
