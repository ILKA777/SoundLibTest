//
//  TunaViewController.swift
//  SoundLibTest
//
//  Created by Илья on 30.10.2023.
//

import UIKit
import AVFAudio
import Tuna

class TunaViewController: UIViewController {
    var audioSession: AVAudioSession!
    var pitchEngine: PitchEngine!
    var isOn = false
    
    @IBOutlet weak var microphoneSwitch: UISwitch!
    @IBOutlet weak var infoLabel: UILabel!
    @IBOutlet weak var soundCircle: UIView!
    
    func start(){
        isOn = true
        pitchEngine.start()
    }
    
    func stop(){
        isOn = false
        pitchEngine.stop()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        pitchEngine = PitchEngine { result in
            switch result {
            case .success(let pitch):
                print(pitch)
                self.infoLabel.text = String(Int(pitch.wave.frequency))
                let alphaValue = CGFloat(pitch.wave.frequency / 1000) // задаем значение прозрачности в зависимости от частоты
                self.soundCircle.alpha = alphaValue
            case .failure(let error):
                print(error)
            }
        }
        audioSession = AVAudioSession.sharedInstance()
        try? audioSession.setCategory(.record, mode: .default)
        try? audioSession.setActive(true)
        microphoneSwitch.addTarget(self, action: #selector(didMicrophoneSwitchIsOn), for: .touchUpInside)
        soundCircle.layer.cornerRadius = soundCircle.bounds.height / 2 // делаем soundCircle кругом
    }
    
    // MARK: - Actions
    
    @IBAction func didMicrophoneSwitchIsOn(_ sender: UISwitch) {
        let currentStatus = audioSession.recordPermission
        switch currentStatus {
        case .undetermined:
            // Запрашиваем разрешение на использование микрофона
            audioSession.requestRecordPermission { [weak self] (allowed) in
                if allowed {
                    self?.start() // Включаем микрофон при разрешении
                }
            }
        case .denied:
            stop() // Отключаем микрофон при отказе
        case .granted:
            if sender.isOn {
                start()
            } else {
                stop()
            }
        @unknown default:
            break
        }
    }
}
