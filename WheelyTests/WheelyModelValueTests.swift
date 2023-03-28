//
//  WheelyModelTests.swift
//  WheelyTests
//
//  Created by Antony Gardiner on 27/03/23.
//

import XCTest
@testable import Wheely

final class WheelyModelValueTests: XCTestCase {
	
	override func setUpWithError() throws {
		// Put setup code here. This method is called before the invocation of each test method in the class.
	}
	
	override func tearDownWithError() throws {
		// Put teardown code here. This method is called after the invocation of each test method in the class.
	}
	
	func testEncodeDecode() throws {
		
		// Given
		let model = WheelyValue(name: "Bob", color: .red)
		
		let encoder = JSONEncoder()
		let jsonData = try encoder.encode(model)
		
		// When
		let decoder = JSONDecoder()
		let decodedModel = try decoder.decode(WheelyValue.self, from: jsonData)

		// Then
		XCTAssertEqual(model, decodedModel)
		
	}
	
	
	
}
