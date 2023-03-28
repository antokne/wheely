//
//  WheelyModelTests.swift
//  WheelyTests
//
//  Created by Antony Gardiner on 27/03/23.
//

import XCTest
@testable import Wheely

final class WheelyModelTests: XCTestCase {

	let tempFolder = FileManager.default.temporaryDirectory.appending(component: "wheely-model").appendingPathExtension("json")

	override func setUpWithError() throws {
	}
	
	override func tearDownWithError() throws {
		// Clean up
		try? FileManager.default.removeItem(at: tempFolder)
	}
	
	func testSaveLoad() throws {

		// Given
		XCTAssertFalse(FileManager.default.fileExists(atPath: tempFolder.path()))
		let wheelyModel = try WheelyModel(from: tempFolder)
		
		wheelyModel.add(value: WheelyValue(name: "bob", color: .red))
		wheelyModel.add(value: WheelyValue(name: "pet", color: .yellow))
		
		XCTAssertEqual(wheelyModel.values.count, 2)
		do {
			try wheelyModel.save()
			XCTAssertTrue(FileManager.default.fileExists(atPath: tempFolder.path()))
		} catch {
			XCTFail("Filed to write to file \(tempFolder)")
		}
		
		// When
		do {
			let loadedWheelyModel = try WheelyModel(from: tempFolder)
			
			
			// Then
			XCTAssertEqual(loadedWheelyModel.values.count, wheelyModel.values.count)
			XCTAssertEqual(loadedWheelyModel.values, wheelyModel.values)
			
		} catch {
			XCTFail("Filed to read to file \(tempFolder)")
		}
	}
	
	func testMove() throws {
		
		// Given
		let wheelyModel = try WheelyModel(from: tempFolder)
		
		let value = WheelyValue(name: "bob", color: .red)
		wheelyModel.add(value: value)
		wheelyModel.add(value: WheelyValue(name: "pet", color: .yellow))
		
		// When
		wheelyModel.move(fromOffsets: IndexSet(integer: 0), toOffset: 2)
		
		// Then
		XCTAssertEqual(value, wheelyModel.values[1])
		
	}
}
