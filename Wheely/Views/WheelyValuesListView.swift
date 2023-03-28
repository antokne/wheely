//
//  WheelyValuesListView.swift
//  Wheely
//
//  Created by Antony Gardiner on 27/03/23.
//

import SwiftUI

struct WheelyValuesListView: View {
	
	@Environment(\.presentationMode) var presentationMode

	@EnvironmentObject var viewModel: WheelyViewModel
	@State private var showingAdd = false

	var body: some View {
		NavigationStack {
			List {
				if viewModel.count > 0 {
					ForEach(viewModel.model.values) { value in
						WheelyValueView(value: value)
					}
					.onMove(perform: onMove)
					.onDelete(perform: onDelete)
				}
				else {
					Text(viewModel.wheelyListNoItems)
				}
			}
			.toolbar {
				ToolbarItem(placement: .navigationBarLeading) {
					Button(viewModel.wheelyListCloseTitle) {
						close()
					}
				}
				ToolbarItem(placement: .navigationBarTrailing) {
					Button(viewModel.wheelyListAddItem) {
						add()
					}
				}
				ToolbarItem(placement: .navigationBarTrailing) {
					if viewModel.count > 0 {
						EditButton()
					}
				}
			}
		}
		.navigationTitle(viewModel.wheelyListTitle)
		.sheet(isPresented: $showingAdd) {
			NavigationStack {
				WheelyAddValueView()
					.environmentObject(viewModel)
			}

		}
		.navigationBarTitleDisplayMode(.inline)
	}
	
	func onMove(from source: IndexSet, to destination: Int) {
		viewModel.move(from: source, to: destination)
	}
	
	private func onDelete(offsets: IndexSet) {
		viewModel.delete(at: offsets)
	}
	
	func close() {
		presentationMode.wrappedValue.dismiss()
	}
	
	func add() {
		showingAdd = true
	}
}

struct WheelyShowValuesView_Previews: PreviewProvider {
	static var previews: some View {
		let viewModel = WheelyViewModel()
			.add(name: "Bobbie", color: .red)
			.add(name: "Holden", color: .blue)
			.add(name: "Drummer", color: .gray)
		WheelyValuesListView()
			.environmentObject(viewModel)
	}
}

struct WheelyShowValuesView_Previews_None: PreviewProvider {
	static var previews: some View {
		WheelyValuesListView()
			.environmentObject(WheelyViewModel())
	}
}
