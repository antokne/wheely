//
//  ColorTests.swift
//  WheelyTests
//
//  Created by Antony Gardiner on 27/03/23.
//

import XCTest
import SwiftUI
@testable import Wheely

final class ColorTests: XCTestCase {
	
	override func setUpWithError() throws {
		// Put setup code here. This method is called before the invocation of each test method in the class.
	}
	
	override func tearDownWithError() throws {
		// Put teardown code here. This method is called after the invocation of each test method in the class.
	}
	
	func testHexColorFFFFFF() throws {
		
		// Given
		let hex = 0xFFFFFF
		
		// When
		let color = Color(hex: hex)
		let toHex = color.toHex()

		// Then
		XCTAssertEqual(hex, toHex)
	}

	func testHexColorBlack() throws {
		
		// Given
		let hex = 0x000000
		
		// When
		let color = Color(hex: hex)
		let toHex = color.toHex()

		// Then
		XCTAssertEqual(hex, toHex)
	}

	func testHexColorGray() throws {
		
		// Given
		let hex = 0x999999
		
		// When
		let color = Color(hex: hex)
		let toHex = color.toHex()

		// Then
		XCTAssertEqual(hex, toHex)
	}

	
}
