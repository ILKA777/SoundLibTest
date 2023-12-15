//
//  Settings.swift
//  SciTuner
//
//  Created by Denis Kreshikhin on 8/9/17.
//  Copyright © 2017 Denis Kreshikhin. All rights reserved.
//

import Foundation
import RealmSwift

@objcMembers
class Settings: Object {
    @objc static let processingPointCount: UInt = 128
    @objc static let sampleRate: Double = 44100
    @objc static let sampleCount: Int = 2048
    @objc static let spectrumLength: Int = 32768
    @objc static let showFPS = true
    @objc static let previewLength: Int = 5000
    
    @objc static let fMin: Double = 16.0
    @objc static let fMax: Double = Settings.sampleRate / 2.0
    
    @objc dynamic var fret: Fret = .openStrings
    @objc dynamic var stringIndex: Int = 0
    
    var pitch: Pitch {
        set { self.pitch_ = newValue.rawValue }
        get { return Pitch(rawValue: self.pitch_) ?? .standard }
    }
    
    var instrument: Instrument {
        set { self.instrument_ = newValue.rawValue }
        get { return Instrument(rawValue: self.instrument_) ?? .guitar }
    }
    
    var tuning: Tuning {
        set { self.tuning_ = newValue.id }
        get { return Tuning(instrument: instrument, id: self.tuning_) ?? Tuning(standard: instrument)}
    }
    
    var filter: Filter {
        set { self.filter_ = newValue.rawValue }
        get { return Filter(rawValue: self.filter_) ?? .on }
    }
    
    @objc private dynamic var pitch_: String = Pitch.standard.rawValue
    @objc private dynamic var instrument_: String = Instrument.guitar.rawValue
    @objc private dynamic var tuning_: String = Instrument.guitar.rawValue
    @objc private dynamic var filter_: String = Filter.off.rawValue
    
    static func shared() -> Settings {
        let realm = try! Realm()
        
        print("SHARED")
        
        if let settings = realm.objects(Settings.self).first {
            return settings
        }
        
        let settings = Settings()
        
        try! realm.write {
            realm.add(settings)
        }
        
        return settings
    }
    
    static override func ignoredProperties() -> [String] {
        return ["fret"]
    }
    
}
