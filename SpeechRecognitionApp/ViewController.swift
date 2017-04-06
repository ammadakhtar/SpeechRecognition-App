//
//  ViewController.swift
//  SpeechRecognitionApp
//
//  Created by Ammad on 06/04/2017.
//  Copyright © 2017 Ammad. All rights reserved.
//

import UIKit
import Speech
import AVFoundation

class ViewController: UIViewController , AVAudioPlayerDelegate{
    
    @IBOutlet weak var transcriptionTextField: UITextView!
    @IBOutlet weak var activitySpinner:UIActivityIndicatorView!
    var audoiplayer: AVAudioPlayer!
    override func viewDidLoad() {
        super.viewDidLoad()
        activitySpinner.isHidden = true
        
    }
    func audioPlayerDidFinishPlaying(_ player: AVAudioPlayer, successfully flag: Bool) {
        player.stop()
        activitySpinner.stopAnimating()
        activitySpinner.isHidden = true
    }
    
    func requestSpeechAuth()
    {
        SFSpeechRecognizer.requestAuthorization{ authstatus in
            if authstatus == SFSpeechRecognizerAuthorizationStatus.authorized{
                if let path = Bundle.main.url(forResource: "speech", withExtension: "m4a") {
                    do {
                        let sound = try AVAudioPlayer(contentsOf: path)
                        self.audoiplayer = sound
                        self.audoiplayer.delegate = self
                        sound.play()
                    }
                    catch {
                        print("Error!")
                    }
                    let reconginzer = SFSpeechRecognizer()
                    let request = SFSpeechURLRecognitionRequest(url: path)
                    reconginzer?.recognitionTask(with: request)  { (result,error) in
                        if let error = error {
                            print(error)
                            
                        } else {
                            self.transcriptionTextField.text = result?.bestTranscription.formattedString
                        }
                    }
                    
                }
                
            }
            
        }
    }
    
    @IBAction func soundBtnPressed(_ sender: Any) {
        
    activitySpinner.isHidden = false
    activitySpinner.startAnimating()
    requestSpeechAuth()
    }
    
    
    
}

