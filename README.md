# Smart House

### Requirement Doc:
https://hackmd.io/@terminal1/assessment-mobile-native

### Room API:
http://private-1e863-house4591.apiary-mock.com/

### Weather API:
https://www.metaweather.com/api/location/2165352/

### Architecture: MVVM
```
1. There are two screens in the app, the homepage and the room page.
2. each screen has a view controller, a view model class for the screen, and a cell view model class for the cell
3. all the components are loosely coupled, e.g. the ApiService and DataStorage, there's nothing called 'shared'.
```

### 3-party libraries: 
```
Alarmofire - for http request
SVProgressHUD - for showing message to user 
RxSwift - for rx style programming
RxCocoa - for rx style programming for UI elements
```

### Modules:
1. NetworkManager: for general network request, it uses Alarmofire sessionManager to do the real job 

2. DataStorage: for storing data locally 

3. ApiService: provide various api endpoints method for the app

4. TemperaturePoller: for polling the weather data

### Models:
```
House

Room

Fixture

Weather
```

