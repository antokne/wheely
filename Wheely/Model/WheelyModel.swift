//
//  WheelyModel.swift
//  Wheely
//
//  Created by Antony Gardiner on 27/03/23.
//

import SwiftUI
						
enum WheelyModelError: Error {
	case valueNotFound
	case failedWriteToFile
	case failedToLoadFile
}

public class WheelyModel: ObservableObject {

	var values: [WheelyValue] = []
	
	private var fileUrl: URL? = nil
	
	init() {
		// not file backed.
	}
	
	init(from file: URL) throws {
		fileUrl = file
		try load()
	}
	
	/// Loads from JSON
	/// Ideally this would not do this in the base implementation
	/// would be nicer to have a specific JSON implementation
	/// then later could add other implementations such as Core Data or whatever
	func load() throws {
		
		guard let fileUrl else {
			// no url just does nothing
			return
		}
		
		guard FileManager.default.fileExists(atPath: fileUrl.path()) else {
			return
		}
		
		do {
			let data = try Data(contentsOf: fileUrl)
			
			let decoder = JSONDecoder()
			values = try decoder.decode(Array<WheelyValue>.self, from: data)
			
		} catch {
			throw WheelyModelError.failedToLoadFile
		}
	}
	
	/// Saves date to JSON.
	/// See load
	func save() throws {
		
		guard let fileUrl else {
			// no url just does nothing
			return
		}

		let encoder = JSONEncoder()
		
		do {
			let data = try encoder.encode(values)
			try data.write(to: fileUrl)
		} catch {
			throw WheelyModelError.failedWriteToFile
		}
	}
		
	/// Adds the value to the end of the list. If already exists does nothing
	/// - Parameter value: value to add
	func add(value: WheelyValue) {
		
		guard values.firstIndex(of: value) == nil else {
			return
		}
		
		values.append(value)
	}
		
	func move(fromOffsets source: IndexSet, toOffset destination: Int) {
		values.move(fromOffsets: source, toOffset: destination)
	}
	
	func delete(at offsets: IndexSet) {
		values.remove(atOffsets: offsets)
	}
		
	/// Delete value from list. If it does not exist function does nothing.
	/// - Parameter value: value to delete
	func delete(value: WheelyValue) {
		
		guard let fromIndex = values.firstIndex(of: value) else {
			return
		}
		
		values.remove(at: fromIndex)
	}
	
}
