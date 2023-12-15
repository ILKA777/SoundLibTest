import SwiftUI

struct NoteTicks: View {
    let tunerData: ZenTunerData
    let showFrequencyText: Bool

    var body: some View {
        NoteDistanceMarkers()
            .overlay(
                CurrentNoteMarker(
                    frequency: tunerData.pitch,
                    distance: tunerData.closestNote.distance,
                    showFrequencyText: showFrequencyText
                )
            )
    }
}
