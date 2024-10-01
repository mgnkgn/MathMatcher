//
//  TimerLineView.swift
//  MathMatch
//
//  Created by Gunes Akgun on 27.09.2024.
//

import SwiftUI

struct TimerLineView: View {
	@State private var hasAppeared = false
	var remainingTime: Int
	var totalTime: Int
		
	var timeFraction: CGFloat {
		return CGFloat(
			remainingTime
		) / CGFloat(
			totalTime
		)
	}
	
	var body: some View {
		VStack{
			GeometryReader { geometry in
				Rectangle()
					.fill(
						LinearGradient(
							gradient: Gradient(
								colors: [
									.red,
									.orange
								]
							),
							startPoint: .leading,
							endPoint: .trailing
						)
					)
					.frame(
						width: geometry.size.width * timeFraction
					)
					.animation(hasAppeared ? .linear(duration: 1) : .none, value: remainingTime)
			}
		}
		.onAppear() {
			DispatchQueue.main.async {
				hasAppeared = true
			}
		}
	}
}

#Preview {
	TimerLineView(
		remainingTime: 40,
		totalTime: 60
	)
}
