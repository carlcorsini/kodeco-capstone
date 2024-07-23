import SwiftUI

struct SplashScreenView: View {
  @State private var isActive = false
  @State private var currentPage = 0
  var body: some View {
    if isActive {
      ContentView()
    } else {
      TabView(selection: $currentPage) {
        SplashSlideView(
          imageName: "antenna.radiowaves.left.and.right",
          title: "Welcome to FindMyRadio",
          description: "Find the best radio stations around you."
        )
        .tag(0)
        SplashSlideView(
          imageName: "antenna.radiowaves.left.and.right",
          title: "Discover New Stations",
          description: "Discover new radio stations based on your location."
        )
        .tag(1)
        SplashSlideView(
          imageName: "antenna.radiowaves.left.and.right",
          title: "Easy to Use",
          description: "Our app is easy to use and provides 1000s of radio stations at your fingertips."
        )
        .tag(2)
        SplashSlideView(
          imageName: "antenna.radiowaves.left.and.right",
          title: "Get Started",
          description: "Start using FindMyRadio."
        )
        .tag(3)
      }
      .tabViewStyle(PageTabViewStyle())
      .overlay(
        VStack {
          Spacer()
          if currentPage == 3 {
            Button(action: {
              withAnimation {
                self.isActive = true
              }
            }, label: {
              Text("Get Started")
                .font(.headline)
                .foregroundColor(.white)
                .padding()
                .background(Color.blue)
                .cornerRadius(10)
            })
            .padding(.bottom, 50)
          } else {
            Text("Swipe to continue")
          }
        }
      )
    }
  }
}
struct SplashSlideView: View {
  let imageName: String
  let title: String
  let description: String
  var body: some View {
    VStack {
      Image(systemName: imageName)
        .resizable()
        .frame(width: 100, height: 100)
        .foregroundColor(.blue)
        .padding(.top, 100)
      Text(title)
        .font(.largeTitle)
        .fontWeight(.bold)
        .foregroundColor(.blue)
        .padding(.top, 50)
      Text(description)
        .font(.body)
        .foregroundColor(.gray)
        .multilineTextAlignment(.center)
        .padding()
      Spacer()
    }
  }
}
struct SplashScreenView_Previews: PreviewProvider {
  static var previews: some View {
    SplashScreenView()
  }
}
