//
//  TimerViewModel.swift
//  OverGoogleTimer
//
//  Created by 김종희 on 2023/08/21.
//

import Foundation
import AVFoundation

class TimerViewModel: ObservableObject {
    
    @Published var endPercent: CGFloat = 0
    
    var audioPlayer: AVAudioPlayer?
    
    func getAudio() {
        guard let url = Bundle.main.url(forResource: "clock", withExtension: "mp3") else {
            return
        }
        do {
            audioPlayer = try AVAudioPlayer(contentsOf: url)
            audioPlayer?.play()
        } catch {
            print(error.localizedDescription)
        }
    }
    
    func stopTimer() {
        self.endPercent = 360
    }
    
    func goTimer() {
        Timer.scheduledTimer(withTimeInterval: 1.0, repeats: true) { timer in
            if self.endPercent < 360 {
                self.endPercent += 0.1
            } else {
                self.endPercent = 0
                timer.invalidate()
                self.getAudio()
            }
        }
    }
    
}
