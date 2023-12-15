import SwiftUI
import AudioKitUI

struct TunerView: View {
    @StateObject var conductor = TunerConductor()
    @State private var isMicrophoneEnabled = true
    
    var body: some View {
        VStack {
            HStack {
                Text("Frequency")
                Spacer()
                Text("\(conductor.data.pitch, specifier: "%0.1f")")
            }.padding()
            
            HStack {
                Text("Amplitude")
                Spacer()
                Text("\(conductor.data.amplitude, specifier: "%0.1f")")
            }.padding()
            
            HStack {
                Text("Note Name")
                Spacer()
                Text("\(conductor.data.noteNameWithSharps) / \(conductor.data.noteNameWithFlats)")
            }.padding()
            
            Toggle(isOn: $isMicrophoneEnabled, label: {
                Text("Microphone Enabled")
            })
            .padding(.horizontal)
            .toggleStyle(SwitchToggleStyle(tint: .accentColor))
            .onChange(of: isMicrophoneEnabled) { newValue in
                if newValue {
                    conductor.start()
                } else {
                    conductor.stop()
                }
            }
            
            NodeRollingView(conductor.tappableNodeA).clipped()
            
            NodeOutputView(conductor.tappableNodeB).clipped()
            
            NodeFFTView(conductor.tappableNodeC).clipped()
        }
        .onAppear {
            conductor.start()
            
        }
        .onDisappear {
            conductor.stop()
        }
        .navigationTitle("TuningFork (AudioKit)")
    }
}

