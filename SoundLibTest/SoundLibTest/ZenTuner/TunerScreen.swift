import MicrophonePitchDetector
import SwiftUI

struct TunerScreen: View {
    @ObservedObject private var pitchDetector = MicrophonePitchDetector()
    @AppStorage("modifierPreference")
    private var modifierPreference = ModifierPreference.preferSharps
    @AppStorage("selectedTransposition")
    private var selectedTransposition = 0
    @State private var isMicrophoneEnabled = true
    
    var body: some View {
        VStack {
            Toggle(isOn: $isMicrophoneEnabled, label: {
                Text("Microphone Enabled")
            })
            .padding()
            .toggleStyle(SwitchToggleStyle(tint: .accentColor))
            .padding(.horizontal)
            
            Spacer()
            
            ZenTunerView(
                tunerData: ZenTunerData(pitch: Double(Float(pitchDetector.pitch))),
                modifierPreference: modifierPreference,
                selectedTransposition: selectedTransposition
            )
            .opacity(pitchDetector.didReceiveAudio && isMicrophoneEnabled ? 1 : 0.5)
            .animation(.easeInOut, value: pitchDetector.didReceiveAudio)
            .onChange(of: isMicrophoneEnabled) { newValue in
                Task {
                    if newValue {
                        do {
                            try await pitchDetector.activate()
                        } catch {
                            print(error)
                        }
                    } else {
                        pitchDetector.deactivate()
                    }
                }
            }
            .alert(isPresented: $pitchDetector.showMicrophoneAccessAlert) {
                MicrophoneAccessAlert()
            }
        }
        .onAppear {
            Task {
                do {
                    try await pitchDetector.activate()
                } catch {
                    print(error)
                }
            }
            
        }
        .onDisappear {
            Task {
                pitchDetector.deactivate()
            }
        }
        .navigationTitle("ZenTuner")
    }
}

struct TunerScreen_Previews: PreviewProvider {
    static var previews: some View {
        TunerScreen()
    }
}

