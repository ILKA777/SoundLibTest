//
//  Pitch.swift
//  SciTuner
//
//  Created by Denis Kreshikhin on 8/10/17.
//  Copyright © 2017 Denis Kreshikhin. All rights reserved.
//

import Foundation

enum Pitch: String {
    typealias `Self` = Pitch
    
    case standard = "standard_pitch"
    case scientific = "scientific_pitch"
    
    static let allPitches: [Pitch] = [.standard, .scientific]
    
    func noteAndFrequency() -> (Note, Double) {
        switch self {
        case .standard: return (Note("a4"), 440)
        case .scientific: return (Note("c4"), 256)
        }
    }
    
    func localized() -> String {
        return self.rawValue.localized()
    }
    
    func index() -> Int? {
        return Self.allPitches.firstIndex(of: self)
    }
    
    func frequency(of note: Note) -> Double {
        let (baseNote, baseFrequency) = self.noteAndFrequency()
        let (b, n) = (baseNote.number, note.number)
        
        return baseFrequency * pow(2.0, Double(n - b) / 12.0);
    }
    
    func deviation(note: Note, frequency: Double) -> Double {
        let f0 = self.frequency(of: note)
        let neightbor = note + ((frequency > f0) ? 1 : -1 )
        let fn = self.frequency(of: neightbor)
        
        return (frequency - f0) / abs(fn - f0)
    }
    
    func notePosition(with frequency: Double) -> Double {
        let (baseNote, baseFrequency) = self.noteAndFrequency()
        let b = baseNote.number
        
        return 12.0 * log(frequency / baseFrequency) / log(2) + Double(b)
    }
    
    func band(of tuning: Tuning) -> (fmin: Double, fmax: Double) {
        let sorted = tuning.strings.sorted()
        
        guard let lownote = sorted.first else {
            return (0, Settings.fMax)
        }
        
        guard let highnote = sorted.last else {
            return (0, Settings.fMax)
        }
        
        let fmin = frequency(of: lownote) * 0.618
        let fmax = frequency(of: highnote) * 1.618
        
        return (fmin, fmax)
    }
}
