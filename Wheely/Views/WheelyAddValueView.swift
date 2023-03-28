//
//  WheelyAddValueView.swift
//  Wheely
//
//  Created by Antony Gardiner on 28/03/23.
//

import SwiftUI

/// Add value view
struct WheelyAddValueView: View {
	
	@Environment(\.presentationMode) var presentationMode
	
	@EnvironmentObject var viewModel: WheelyViewModel
	@FocusState private var titleFieldIsFocssed: Bool
	@State var value: WheelyValue = WheelyValue()
	
	var body: some View {
		NavigationStack {
			List {
				TextField("Title", text: $value.name)
					.focused($titleFieldIsFocssed)
				ColorPicker("Choose a color", selection: $value.color, supportsOpacity: false)
			}
		}
		.navigationTitle(viewModel.wheelyListAddItem)
		.navigationBarTitleDisplayMode(.inline)
		.toolbar {
			ToolbarItem(placement: .navigationBarTrailing) {
				Button("Add") {
					viewModel.add(value: value)
					viewModel.save()
					presentationMode.wrappedValue.dismiss()
				}
			}
			ToolbarItem(placement: .navigationBarLeading) {
				Button("Cancel") {
					presentationMode.wrappedValue.dismiss()
				}
			}
		}
		.onAppear {
			// make the title focused so you start typing.
			titleFieldIsFocssed = true
		}
	}
}

struct WheelyAddValueView_Previews: PreviewProvider {
	static var previews: some View {
		WheelyAddValueView()
			.environmentObject(WheelyViewModel())
	}
}
