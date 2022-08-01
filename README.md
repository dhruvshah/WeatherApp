### Introduction  
A simple project created using SwiftUI to show the use of Weather Forecast Data using REST Api in an iOS application.
Openning the app you'll see a list of Cities along with current temperature. If you tap on city section, some more details about the weather and weekly forecast are shown.
User can scroll down to see more weekly forecast details.
Ability to view temperature in Celcius or Farenheit based on switch state.

#### Demo Screenshots
- Home Screen List of Cities View

<img src="https://user-images.githubusercontent.com/2280633/182059305-d5ce646b-24c1-4b51-b0fc-3fb4d643ea64.png" width=20% height=20% /> `  ` <img src="https://user-images.githubusercontent.com/2280633/182059312-0e892d0d-bf74-4ccf-a842-05c30e810755.png" width=20% height=20% /> `  `

- Weekly Weather Forecast View for the particular city
<img src="https://user-images.githubusercontent.com/2280633/182059327-93f3795a-3ff7-44b9-b740-fd153a4560eb.png" width=20% height=20% />


### Technical specs
Language: Swift
Networking: URLSession
Design Architecture: MVVM
ViewModels and ViewData for storing UI state
Protocol for search types, used for generics in data manager.
Swift standard coding/decoding for custom objects

### Features
- List of Cities and current temperature
- Weather and weekly Forecast Detail view
- Unit tests covering view models and binding
- Async Image for image icon fetching

## Followed Architectures
1. MVVM (Model-View-ViewModel) with binding
Model: Holds the application data models
View: It displays a representation of the model and receives the user's interaction with the view (clicks, keyboard, gestures, etc.), and it forwards the handling of these to the view model via the data binding (properties, event callbacks, etc.) that is defined to link the view and view model.
ViewModel: Holds the business logic exposing public properties and functions

## Requirement
Xcode 13.0+
macOS Catalina 10.15 or BigSur 11.6

### Getting Started
Copy and Clone the project
Build and run the project

### Things to add on for improvement
- Add core data for offline capability
- Ability to add new cities and allow to move and edit to manage these cities
- Add Image Caching to display weather icons (for eg. update SDWebImage or Kingfisher pod)
- Hourly Forecast Update and render some more details on weather app
- More Unit tests

### Author
Dhruv Shah 

