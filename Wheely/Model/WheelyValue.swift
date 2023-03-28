//
//  WheelyValue.swift
//  Wheely
//
//  Created by Antony Gardiner on 28/03/23.
//

import Foundation
import SwiftUI

struct WheelyValue: Identifiable {
	
	var id = UUID()
	var name: String
	var color: Color
	
	private enum CodingKeys: CodingKey {
		case name
		case color
	}
	
	init() {
		name = ""
		color = Color.randomColor()
	}
	
	init(name: String, color: Color) {
		self.name = name
		self.color = color
	}
}

extension WheelyValue: Codable {
	init(from decoder: Decoder) throws {
		let container = try decoder.container(keyedBy: CodingKeys.self)
		name = try container.decode(String.self, forKey: .name)
		let colorInt = try container.decode(Int.self, forKey: .color)
		color = Color(hex: colorInt)
	}
	
	func encode(to encoder: Encoder) throws {
		var container = encoder.container(keyedBy: CodingKeys.self)
		try container.encode(name, forKey: .name)
		try container.encode(color.toHex(), forKey: .color)
	}
}

extension WheelyValue: Equatable {
	static func == (lhs: WheelyValue, rhs: WheelyValue) -> Bool {
		return lhs.name == rhs.name && lhs.color.toHex() == rhs.color.toHex()
	}
}
