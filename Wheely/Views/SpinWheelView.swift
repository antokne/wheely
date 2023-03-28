//
//  SpinWheelView.swift
//  Wheely
//
//  Created by Antony Gardiner on 28/03/23.
//

import SwiftUI

struct SpinWheelView: View {
	
	@EnvironmentObject var viewModel: WheelyViewModel

	@State private var showingEdit = false
	
	@State var rotation: CGFloat = 0.0
	@State var lastRotation: CGFloat = 0.0
	@State var animation: Animation = Animation.timingCurve(0, 0.5, 0.0, 0.99, duration: 5.0)
	
	var body: some View {
		NavigationStack {
			if viewModel.count > 0 {
				GeometryReader { gr in
					ZStack {
						let width = gr.size.width
						WheelView(rotation: $rotation, segments: $viewModel.model.values)
							.frame(width: width, height: width)
							.rotationEffect(.degrees(rotation))
							.gesture(
								DragGesture().onChanged({ (value) in
									rotation = viewModel.calculateDragRotation(value.startLocation, value.location, using: width)
									rotation += lastRotation
								}).onEnded({ (value) in
									// Keep track of this so next track leaves off from last point.
									lastRotation = rotation
									
									// Ideally this would also start the wheel spinning.
									// Needed more time to do this. Need to figure out a vector
									// that indcates direction and speed to make the spin realistic.
								})
							)
						WheelPointer()
							.rotationEffect(Angle(degrees: -90))
							.offset(x: gr.size.width / 2 - 20, y: 0)
					}
				}
				Button("Spin") {
					spin()
				}
				.buttonStyle(.borderedProminent)
			}
			else {
				Text(viewModel.wheelyListNoItems)
			}
		}
		.toolbar {
			ToolbarItem(placement: .navigationBarTrailing) {
				Button("Edit") {
					showEdit()
				}
			}
		}
		.sheet(isPresented: $showingEdit) {
			NavigationStack {
				WheelyValuesListView()
					.environmentObject(viewModel)
			}
			
		}
		.onAppear {
			if viewModel.count == 0 {
				showEdit()
			}
		}
		.padding()
	}

	func spin() {
		let selectedIndex = viewModel.generatedSelectedIndex()
		let rotateAmount = viewModel.calculateRotation(selecting: selectedIndex)
		withAnimation(animation) {
			rotation += rotateAmount
		}
		
		lastRotation = rotation
	}
	
	func showEdit() {
		showingEdit = true
	}
}

struct SpinWheelView_Previews: PreviewProvider {
	static var previews: some View {
		let viewModel = WheelyViewModel()
			.add(name: "", color: Color.red)
			.add(name: "", color: .orange)
			.add(name: "", color: .yellow)
			.add(name: "", color: .gray)
			.add(name: "", color: .blue)
			.add(name: "", color: .indigo)
			.add(name: "", color: .purple)
			.add(name: "", color: .cyan)
		SpinWheelView()
			.environmentObject(viewModel)
	}
}

struct SpinWheelView_Previews_NothingAdded: PreviewProvider {
	static var previews: some View {
		let viewModel = WheelyViewModel()
		SpinWheelView()
			.environmentObject(viewModel)
	}
}
