import SwiftUI

struct ContentView: View {
    @StateObject var cameraViewModel = CameraViewModel()

    var body: some View {
        CameraView()
            .environmentObject(cameraViewModel)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
