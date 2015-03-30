//
//  PlaySoundsViewController.swift
//  PitchShifter
//
//  Created by allan bittan on 3/29/15.
//  Copyright (c) 2015 ab. All rights reserved.
//
import UIKit
import AVFoundation


class PlaySoundsViewController: UIViewController {

    
    var audioPlayer: AVAudioPlayer!
    var receivedAudio: RecordedAudio!
    var audioEngine: AVAudioEngine!
    var audioFile: AVAudioFile!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        audioEngine = AVAudioEngine()
        audioFile = AVAudioFile(forReading: receivedAudio.filePathUrl, error: nil)
        audioPlayer = AVAudioPlayer(contentsOfURL: receivedAudio.filePathUrl, error: nil)
        audioPlayer.enableRate = true
    }
    
    func stopPlayingAudio(){
        audioPlayer.stop()
        audioEngine.stop()
        audioEngine.reset()
    }

    @IBAction func PlaySoundSlow(sender: UIButton) {
        PlayAudioFile(0.5);
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func PlaySoundFast(sender: UIButton) {
        PlayAudioFile(2.0);
        
    }

    @IBAction func PlaySoundStop(sender: UIButton) {
        stopPlayingAudio()
    }
    
    func PlayAudioFile(playBackSpeed: Float){
        stopPlayingAudio()
        audioPlayer.rate = playBackSpeed;
        audioPlayer.currentTime = 0.0;
        audioPlayer.play();
    }
    
    @IBAction func PlaySoundChipmonk(sender: UIButton) {
        playAudioWithVariablePitch(1000)
    }
    
    
    func playAudioWithVariablePitch(pitch: Float)
    {
        stopPlayingAudio()
        
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
    
    func playAudioWithReverb(){

        stopPlayingAudio()
        
        var audioPlayerNode = AVAudioPlayerNode()
        audioEngine.attachNode(audioPlayerNode)
        
        var reverbEffect = AVAudioUnitReverb()
        
        reverbEffect.loadFactoryPreset(AVAudioUnitReverbPreset.Plate)
        reverbEffect.wetDryMix = 70
        
        audioEngine.attachNode(reverbEffect)
        audioEngine.connect(audioPlayerNode, to: reverbEffect, format: nil)
        audioEngine.connect(reverbEffect, to: audioEngine.outputNode, format: nil)
        
        audioPlayerNode.scheduleFile(audioFile, atTime: nil, completionHandler: nil)
        audioEngine.startAndReturnError(nil)
        audioPlayerNode.play()
    }
    
    func playAudioWithEcho(){
        stopPlayingAudio()

        var audioPlayerNode = AVAudioPlayerNode()
        audioEngine.attachNode(audioPlayerNode)
        
        var echoEffect = AVAudioUnitDelay()
        
        echoEffect.delayTime = NSTimeInterval(0.10)
        echoEffect.wetDryMix = 25.0
        
        audioEngine.attachNode(echoEffect)
        audioEngine.connect(audioPlayerNode, to: echoEffect, format: nil)
        audioEngine.connect(echoEffect, to: audioEngine.outputNode, format: nil)
        
        audioPlayerNode.scheduleFile(audioFile, atTime: nil, completionHandler: nil)
        audioEngine.startAndReturnError(nil)
        audioPlayerNode.play()
    }
    
    @IBAction func PlaySoundReverb(sender: UIButton) {
        playAudioWithReverb()
    }
    @IBAction func PlaySoundEcho(sender: UIButton) {
        playAudioWithEcho()
    }
    
    
    @IBAction func PlaySoundDarthVader(sender: UIButton) {
        playAudioWithVariablePitch(-1000)
    }
}
