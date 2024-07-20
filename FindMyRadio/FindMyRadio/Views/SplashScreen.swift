import SwiftUI

struct SplashScreenView: View {
  @State private var isActive = false
  @State private var opacity = 0.0
  var body: some View {
    VStack {
      Image(systemName: "antenna.radiowaves.left.and.right")
        .resizable()
        .frame(width: 100, height: 100)
        .foregroundColor(.blue)
        .opacity(opacity)
        .onAppear {
          withAnimation(.easeIn(duration: 1.0)) {
            self.opacity = 1.0
          }
        }
      Text("FindMyRadio")
        .font(.largeTitle)
        .fontWeight(.bold)
        .foregroundColor(.blue)
    }
    .onAppear {
      DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
        withAnimation {
          self.isActive = true
        }
      }
    }
    .fullScreenCover(isPresented: $isActive) {
      ContentView()
    }
  }
}

struct SplashScreenView_Previews: PreviewProvider {
  static var previews: some View {
    SplashScreenView()
  }
}
