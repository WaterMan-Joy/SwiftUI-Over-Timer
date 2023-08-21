//
//  TimerView.swift
//  OverGoogleTimer
//
//  Created by 김종희 on 2023/08/21.
//

import SwiftUI

struct TimerView: View {
    
    @ObservedObject var viewModel = TimerViewModel()
    
        // 시작하는 각도
        var startPercent: CGFloat = 0
        
        // 원의 색상
        var color: Color = .red
        // 원의 배경 색상
        var backgroundColor: Color = .black
    
    var body: some View {
        VStack {
            GeometryReader { geometryProxy in
                    ZStack(alignment: .center) {
                        Circle()
                            .foregroundColor(self.color)
                        
                        Path { path in
                            let size = geometryProxy.size
                            let center = CGPoint(x: size.width / 2.0,
                                                 y: size.height / 2.0)
                            let radius = min(size.width, size.height) / 2.0
                            path.move(to: center)
                            path.addArc(center: center,
                                        radius: radius,
                                        startAngle: .init(degrees: Double(self.startPercent)),
                                        endAngle: .init(degrees: Double(self.viewModel.endPercent)),
                                        clockwise: true)
                        }
                        .rotation(.init(degrees: 270))
                        .foregroundColor(self.backgroundColor)
                        .frame(width: geometryProxy.size.width,
                               height: geometryProxy.size.height,
                               alignment: .center)
                        
                        Circle()
                            .stroke(style: StrokeStyle(lineWidth: 10, dash: [2]))
                            .foregroundColor(.white)
                            .padding(.all, 8)
                        
                        Text(viewModel.endPercent == 0 ? "GO 1HOUR " : "FOCUS")
                            .foregroundColor(.white)
                            .font(.system(size: 30, weight: .semibold, design: .monospaced))
                            .onTapGesture {
                                if viewModel.endPercent == 0 {
                                    viewModel.goTimer()
                                } else {
                                    viewModel.stopTimer()
                                }
                            }
                    }
                }
            .padding()
            .background(.black)
        }
    }
}

struct TimerView_Previews: PreviewProvider {
    static var previews: some View {
        TimerView()
    }
}
