import SwiftUI

struct ContentView: View {
    @StateObject private var weatherViewModel = WeatherViewModel()
    @StateObject private var locationManager = LocationManager()
    @State private var weatherManager = WeatherManager()
    
    @State private var cityField: String = ""
    @State private var cityName: String = "Lviv"
    @State private var conditionName: String = "sun.max"
    @State private var temp: String = "25.0"

    var body: some View {
        VStack {
            
            HStack {
                TextField("Search", text: $cityField)
                    .padding(.all, 10)
                    .background(Color.white)
                    .overlay(
                        RoundedRectangle(cornerRadius: 10)
                            .stroke(Color.black, lineWidth: 1)
                    )
                
                Spacer()
                
                Button(action: {
                    print("Search button tapped. Searching for \(cityField)")
                    cityName = cityField
                    cityField = ""
                    weatherManager.fetchWeather(cityName: cityName)
                }) {
                    Image(systemName: "arrow.right.square")
                        .resizable()
                        .frame(width: 40, height: 40)
                        .foregroundColor(.black)
                }
            }
            .padding(.bottom, 200)
            
            VStack {
                HStack {
                    Spacer()
                    Image(systemName: conditionName)
                        .resizable()
                        .frame(width: 40, height: 40)
                    Text("\(temp)°C")
                        .font(.largeTitle)
                }
                
                HStack {
                    Spacer()
                    Text(cityName)
                        .foregroundStyle(.secondary)
                        .font(.title2)
                }
            }
            
            Spacer()
        }
        .padding()
        .onAppear {
            weatherManager.delegate = weatherViewModel
            locationManager.startUpdatingLocation()
            updateWeatherInfo()
        }
        .onChange(of: locationManager.latitude) { _, _ in
            weatherManager.fetchWeather(latitude: locationManager.latitude, longitude: locationManager.longitude)
            updateWeatherInfo()
        }
        .onChange(of: locationManager.authorizationStatus) { _, _ in
            if locationManager.authorizationStatus == .authorizedWhenInUse || locationManager.authorizationStatus == .authorizedAlways {
                locationManager.startUpdatingLocation()
            } else {
                print("Location access denied or restricted.")
            }
        }
        .onChange(of: weatherViewModel.weather) { _, _ in
            updateWeatherInfo()
        }
    }
    
    private func updateWeatherInfo() {
        if let weather = weatherViewModel.weather {
            temp = weather.temperatureString
            cityName = weather.cityName
            conditionName = weather.conditionName
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
