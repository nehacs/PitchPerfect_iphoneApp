//
//  PlaySoundsViewController.swift
//  Pitch Perfect
//
//  Created by Neha Agarwal on 6/17/15.
//  Copyright (c) 2015 Neha Agarwal. All rights reserved.
//

import AVFoundation
import UIKit

class PlaySoundsViewController: UIViewController {

    @IBOutlet weak var stopButton: UIButton!
    var audioPlayer:AVAudioPlayer!
    var audioEngine:AVAudioEngine!
    var receivedAudio:RecordedAudio!
    var audioFile:AVAudioFile!

    override func viewDidLoad() {
        super.viewDidLoad()
        stopButton.hidden = false
        audioPlayer = AVAudioPlayer(contentsOfURL: receivedAudio.filePathUrl, error:nil);
        audioPlayer.enableRate = true
        audioEngine = AVAudioEngine()
        audioFile = AVAudioFile(forReading: receivedAudio.filePathUrl, error: nil)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    

    @IBAction func playSlowAudio(sender: UIButton) {
        playWithSpecifiedRate(0.5)
    }
    
    @IBAction func playFastAudio(sender: UIButton) {
        playWithSpecifiedRate(1.5)
    }
    
    // Plays the audio at the specified rate. 
    // Can be used to slow down or speed up the playing of audio.
    func playWithSpecifiedRate(rate:float_t) {
        audioPlayer.stop()
        audioEngine.stop()
        audioEngine.reset()
        audioPlayer.rate = rate
        audioPlayer.play()
    }
    
    @IBAction func playChipmunkAudio(sender: UIButton) {
        playWithAdjustedPitch(1000)
    }

    @IBAction func playDarthVaderAudio(sender: UIButton) {
        playWithAdjustedPitch(-1000)
    }
    
    // Plays the audio with the given adjusted pitch. 
    // Can be used to play an audio at a higher or lower pitch.
    func playWithAdjustedPitch(pitch: float_t) {
        audioPlayer.stop()
        audioEngine.stop()
        audioEngine.reset()
        
        var audioPlayerNode = AVAudioPlayerNode()
        audioEngine.attachNode(audioPlayerNode)
        
        var changePitchEffect = AVAudioUnitTimePitch()
        changePitchEffect.pitch = pitch
        audioEngine.attachNode(changePitchEffect)
        
        audioEngine.connect(audioPlayerNode, to: changePitchEffect, format: nil)
        audioEngine.connect(changePitchEffect, to: audioEngine.outputNode, format: nil)
        
        audioPlayerNode.scheduleFile(audioFile, atTime: nil, completionHandler: nil)
        audioEngine.startAndReturnError(nil)
        
        audioPlayerNode.play()
    }
    
    @IBAction func stopPlayingAudio(sender: UIButton) {
        audioPlayer.stop()
    }
}
