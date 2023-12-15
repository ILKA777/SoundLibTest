struct ZenTunerData {
    let pitch: Frequency
    let closestNote: ScaleNote.Match
}

extension ZenTunerData {
    init(pitch: Double = 440) {
        self.pitch = Frequency(floatLiteral: pitch)
        self.closestNote = ScaleNote.closestNote(to: self.pitch)
    }
}
