import UIKit
import AVFoundation

public enum Sound {
    case access, swap, insert, merge, button
}

public class MusicHelper {
    
    var accessSoundPlayer: AVAudioPlayer?
    var swapSoundPlayer: AVAudioPlayer?
    var insertSoundPlayer: AVAudioPlayer?
    var mergeSoundPlayer: AVAudioPlayer?
    var buttonSoundPlayer: AVAudioPlayer?
    
    init() {
        
        guard
            let accessURL = Bundle.main.url(forResource: "click", withExtension: "wav"),
            let swapURL = Bundle.main.url(forResource: "insert", withExtension: "wav"),
            let insertURL = Bundle.main.url(forResource: "insert", withExtension: "wav"),
            let mergeURL = Bundle.main.url(forResource: "insert", withExtension: "wav"),
            let buttonURL = Bundle.main.url(forResource: "swap", withExtension: "wav")
            else {
                print("error fetching music file from Music Helper Class")
                return
        }
        
        do {
            
        try AVAudioSession.sharedInstance().setCategory(AVAudioSessionCategoryPlayback)
        try AVAudioSession.sharedInstance().setActive(true)
            
            accessSoundPlayer = try AVAudioPlayer(contentsOf: accessURL, fileTypeHint: AVFileTypeWAVE)
            swapSoundPlayer = try AVAudioPlayer(contentsOf: swapURL, fileTypeHint: AVFileTypeWAVE)
            insertSoundPlayer = try AVAudioPlayer(contentsOf: insertURL, fileTypeHint: AVFileTypeWAVE)
            mergeSoundPlayer = try AVAudioPlayer(contentsOf: mergeURL, fileTypeHint: AVFileTypeWAVE)
            buttonSoundPlayer = try AVAudioPlayer(contentsOf: buttonURL, fileTypeHint: AVFileTypeWAVE)
            
            buttonSoundPlayer?.prepareToPlay()
            swapSoundPlayer?.prepareToPlay()
            insertSoundPlayer?.prepareToPlay()
            mergeSoundPlayer?.prepareToPlay()
            buttonSoundPlayer?.prepareToPlay()

        } catch let error as NSError {
            print("error: \(error.localizedDescription)")
            return
        }
    }
    
    
    
    func playSound(_ sound: Sound) {

        switch sound {
        case .access:
            accessSoundPlayer?.play()
        case .button:
            buttonSoundPlayer?.play()
        case .insert:
            insertSoundPlayer?.play()
        case .merge:
            mergeSoundPlayer?.play()
        case .swap:
            swapSoundPlayer?.play()
        }
        
    }
    
}
