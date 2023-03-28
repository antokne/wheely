//
//  WheelyViewModel.swift
//  Wheely
//
//  Created by Antony Gardiner on 27/03/23.
//

import Foundation
import SwiftUI

protocol WheelyViewModelStringsProtocol {
	var wheelyListTitle: String { get }
	var wheelyListCloseTitle: String { get }
	var wheelyListNoItems: String { get }
	var wheelyListAddItem: String { get }
}

class WheelyViewModel : ObservableObject {
	
	@Published var model: WheelyModel
		
	@Published var hasChanged: Int = 0
	@Published var count: Int = 0

	/// Not really used but this could be used to notify the user of any errors.
	@Published var errorMessage: String? = nil
	
	var pointerColor: Color = Color.black
	
	/// The current selected item
	@Published var selectedIndex: Int?
	
	init() {
		self.model = WheelyModel()
	}
	
	init(with fileUrl: URL) {
		do {
			self.model = try WheelyModel(from: fileUrl)
		} catch {
			self.model = WheelyModel() // empty model
		}
		updateState()
	}
	
	@discardableResult
	/// Add a value with the specified values. used in previews
	/// - Parameters:
	///   - name: value name/title
	///   - color: colour to use
	/// - Returns: instance
	func add(name: String, color: Color) -> WheelyViewModel {
		model.add(value: WheelyValue(name: name, color: color))
		updateState()
		return self
	}
	
	@discardableResult
	func add(value: WheelyValue) -> WheelyViewModel {
		model.add(value: value)
		updateState()
		return self
	}
	
	func move(from source: IndexSet, to destination: Int) {	
		model.move(fromOffsets: source, toOffset: destination)
		updateState()
	}
	
	func delete(at offsets: IndexSet) {
		model.delete(at: offsets)
		try? model.save()
		updateState()
	}
	
	func save() {
		// Should check resut and handle error.
		try? model.save()
	}
	
	func updateState() {
		hasChanged += 1
		count = model.values.count
	}
	
	/// Randomly select a segment from the values
	/// - Returns: the index selected
	func generatedSelectedIndex() -> Int {
		selectedIndex = Int.random(in: (0...model.values.count))
		return selectedIndex ?? -1
	}
	
	/// Calculates the random amount to rotate
	/// - Returns: the amount in degress.
	/// - Parameter selectedIndex: the segment to stop rotating on
	func calculateRotation(selecting selectedIndex: Int) -> Double {
		
		let segments = model.values
		
		// randomly choose between 10 and 20 rotations
		let rotations = Double(Int.random(in: 10..<20))
		
		// mulitply by 360 to get this in degress
		var randomAmount = rotations * 360
		
		// Add a random amount base on the segment that will be picked
		randomAmount += Double((360 / segments.count)) * Double(selectedIndex)
		return randomAmount
	}
	
	func calculateDragRotation(_ startLocation: CGPoint, _ location: CGPoint, using width: Double) -> Double {
		
		// calculate the rotation for current location
		let locationTheta = atan2(location.x - width / 2, width / 2 - location.y)
		
		// same for start location
		let startLocationTheta = atan2(startLocation.x - width / 2, width / 2 - startLocation.y)
		
		// Get the difference and convert radins to degress.
		var theta = (locationTheta - startLocationTheta) * 180 / .pi
		
		// if the amount is less than zero we have rotated more that once. add one full rotation to make positive
		if theta < 0 {
			theta += 360
		}
		return theta
		
	}
}

extension WheelyViewModel : WheelyViewModelStringsProtocol {
	
	var wheelyListAddItem: String {
		"Add"
	}

	var wheelyListCloseTitle: String {
		"Close"
	}
	
	var wheelyListTitle: String {
		"Wheel Values"
	}
	
	var wheelyListNoItems: String {
		"Please add some values"
	}
	
}


