//
//  AudioManager.swift
//  Hummingbird
//
//  Created by Cole Smith on 9/24/16.
//  Copyright © 2016 Ahmad and Smith. All rights reserved.
//

import UIKit
import AVFoundation

class AudioManager: NSObject, AVAudioRecorderDelegate {
    
    static let sharedManager: AudioManager = AudioManager()
    
    // MARK: - Class Properties
    
    let RECORD_TIME = 10.0
    
    var recordingSession: AVAudioSession!
    var audioRecorder: AVAudioRecorder!
    var recordingTimer: Timer!
    
    override private init() {
        super.init()
    }
    
    // MARK: - Utility Methods
    
    func requestMicrophone() -> Bool {
        recordingSession = AVAudioSession.sharedInstance()
        var status = false
        do {
            try recordingSession.setCategory(AVAudioSessionCategoryPlayAndRecord)
            try recordingSession.setActive(true)
            recordingSession.requestRecordPermission() { allowed in
                DispatchQueue.main.async {
                    if allowed {
                        status = true
                    } else {
                        status = false
                    }
                }
            }
        } catch {
            status = false
        }
        return status
    }
    
    func getDocumentsDirectory() -> URL {
        let paths = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
        let documentsDirectory = paths[0]
        return documentsDirectory
    }
    
    // MARK: - Recording
    
    func record() {
        startRecording()
        recordingTimer = Timer.scheduledTimer(
            timeInterval: RECORD_TIME,
            target: self,
            selector: #selector(AudioManager.finishRecording),
            userInfo: nil,
            repeats: false
        )
    }
    
    func stopRecording() {
        if recordingTimer.isValid {
            recordingTimer.invalidate()
            finishRecording()
        }
    }
    
    // MARK: - Playback
    
    func playFromURL(url:NSURL) {
        print("[ INF ] Playing audio from \(url)")
        
        do {
            let player = try AVAudioPlayer(contentsOf: url as URL)
            player.prepareToPlay()
            player.volume = 1.0
            player.play()
        } catch let error as NSError {
            print("[ ERR ] Could not play audio")
            print(error.localizedDescription)
        } catch {
            print("[ ERR ] AVAudioPlayer init failed")
        }
        
    }
    
    // MARK: -  Private Methods
    
    private func startRecording() {
        let audioFilename = getDocumentsDirectory().appendingPathComponent("CurrentRecording.m4a")
        let settings = [
            AVFormatIDKey: Int(kAudioFormatMPEG4AAC),
            AVSampleRateKey: 12000,
            AVNumberOfChannelsKey: 1,
            AVEncoderAudioQualityKey: AVAudioQuality.high.rawValue
        ]
        
        do {
            audioRecorder = try AVAudioRecorder(url: audioFilename, settings: settings)
            audioRecorder.delegate = self
            audioRecorder.record()
        
        } catch {
            print("[ ERR ] Recording Failed")
            finishRecording()
            
        }
    }
    
    @objc private func finishRecording() {
        audioRecorder.stop()
        audioRecorder = nil
        print("[ INF ] Recording finished")
    }
}
