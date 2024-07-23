# FindMyRadio

FindMyRadio is a SwiftUI app that allows users to discover and listen to radio stations based on their location. The app features a map view, media player, radio station list, and a favorites section.

# Important Note:
This app runs on a server created by me and is hosted on a free service at render.com. This means the server will automatically shut down for inactivity and may take up to 1 minute to boot back up on a new server request. Before using the app enter this url into your browser to ping the server to wake up and wait one minute: https://radio-srvr.onrender.com/radio?lat=50.00?long=50.00


## Table of Contents

- [Features](#features)
- [Installation](#installation)
- [Usage](#usage)
- [Testing](#testing)
- [Customization](#customization)
- [App Icon](#app-icon)
- [Acknowledgements](#acknowledgements)
- [Contributing](#contributing)
- [License](#license)

## Features

- **Map View**: Displays the user's location and nearby radio stations.
- **Media Player**: Controls for playing and stopping the radio stream.
- **Radio Station List**: Displays a list of available radio stations.
- **Favorites**: Allows users to save and manage their favorite radio stations.
- **Splash Screen**: An introductory screen displayed when the app launches.

## Installation

1. **Clone the Repository**:
    ```bash
    git clone https://github.com/yourusername/FindMyRadio.git
    cd FindMyRadio
    ```

2. **Open the Project in Xcode**:
    ```bash
    open FindMyRadio.xcodeproj
    ```

3. **Install Dependencies**:
    Ensure you have the latest version of Xcode and Swift installed.

## Usage

### Running the App

1. **Launch Xcode**: Open the `FindMyRadio.xcodeproj` file in Xcode.
2. **Build and Run**: Select the target device or simulator and click the Run button.

### Features Overview

#### Splash Screen

- The splash screen is displayed when the app launches.
- Automatically transitions to the main content after 2 seconds.

#### Map View

- Displays the user's current location.
- Shows nearby radio stations as pins on the map.

#### Media Player

- Provides play and stop controls for the selected radio station.

#### Radio Station List

- Displays a list of available radio stations based on the user's location.
- Allows users to play a radio station or mark it as a favorite.

#### Favorites

- Users can view and manage their favorite radio stations in the Favorites tab.

## Testing

### Unit Tests

- **Location**: `FindMyRadioTests/RadioViewModelTests.swift`
- **Running Tests**:
    1. Open the `FindMyRadio.xcodeproj` in Xcode.
    2. Select the `FindMyRadioTests` scheme.
    3. Press `Cmd+U` to run the tests.

### UI Tests

- **Location**: `FindMyRadioUITests/FindMyRadioUITests.swift`
- **Running Tests**:
    1. Open the `FindMyRadio.xcodeproj` in Xcode.
    2. Select the `FindMyRadioUITests` scheme.
    3. Press `Cmd+U` to run the tests.

### Adding Mock Data

To use mock data in tests, the `RadioViewModel` can accept a data fetcher dependency. This allows you to inject mock data for testing purposes.

Example of a mock data fetcher:
```swift
private func mockDataFetcher(lat: Double, lon: Double) -> AnyPublisher<[RadioStation], Error> {
    let mockData = [
        RadioStation(stationuuid: "123", name: "Mock Station 1", url: nil, url_resolved: nil, country: nil, countrycode: nil, state: nil, language: nil, tags: nil, favicon: nil, iso_3166_2: nil, lastchangetime: nil, lastchangetime_iso8601: nil, lastchecktime: nil, lastchecktime_iso8601: nil, lastcheckoktime: nil, lastcheckoktime_iso8601: nil, lastlocalchecktime: nil, lastlocalchecktime_iso8601: nil, clicktimestamp: nil, clicktimestamp_iso8601: nil, ssl_error: nil, geo_lat: nil, geo_long: nil, has_extended_info: nil),
        RadioStation(stationuuid: "456", name: "Mock Station 2", url: nil, url_resolved: nil, country: nil, countrycode: nil, state: nil, language: nil, tags: nil, favicon: nil, iso_3166_2: nil, lastchangetime: nil, lastchangetime_iso8601: nil, lastchecktime: nil, lastchecktime_iso8601: nil, lastcheckoktime: nil, lastcheckoktime_iso8601: nil, lastlocalchecktime: nil, lastlocalchecktime_iso8601: nil, clicktimestamp: nil, clicktimestamp_iso8601: nil, ssl_error: nil, geo_lat: nil, geo_long: nil, has_extended_info: nil)
    ]
    return Just(mockData)
        .setFailureType(to: Error.self)
        .eraseToAnyPublisher()
}
```

## Customization

### Splash Screen

- **Location**: `SplashScreenView.swift`
- **Description**: Customize the splash screen with your app's logo and desired animations.

### App Icon

- **Creating an Icon**: Design an app icon (1024x1024) using a graphic design tool.
- **Generating Sizes**: Use [App Icon Generator](https://appicon.co/) to create all required icon sizes.
- **Adding to Xcode**:
    1. Open `Assets.xcassets` in Xcode.
    2. Create a new `AppIcon` set.
    3. Drag and drop the generated icons into the appropriate slots.

### Project Structure

- **`FindMyRadioApp.swift`**: The main entry point of the app.
- **`ContentView.swift`**: The main content view containing the map, media player, and tabs.
- **`RadioViewModel.swift`**: The view model handling radio data fetching and favorites management.
- **`RadioStation.swift`**: The model representing a radio station.
- **`SplashScreenView.swift`**: The splash screen view displayed on app launch.

## Acknowledgements

- **Radio Browser API**: This app uses the [Radio Browser API](https://api.radio-browser.info/) to fetch data on radio stations. A big thank you to the creators of the Radio Browser API for providing this valuable service.

## Contributing

1. Fork the repository.
2. Create a new branch (`git checkout -b feature-branch`).
3. Make your changes.
4. Commit your changes (`git commit -am 'Add new feature'`).
5. Push to the branch (`git push origin feature-branch`).
6. Create a new Pull Request.

## License

This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for details.

---

Feel free to adjust the content according to your project's specifics and add any additional sections you find necessary.
