# Smart House

### Requirement Doc:
https://hackmd.io/@terminal1/assessment-mobile-native

### Room API:
http://private-1e863-house4591.apiary-mock.com/

### Weather API:
https://www.metaweather.com/api/location/2165352/

### Architecture: MVVM

###3-party libraries: 
Alarmofire 
SVProgressHUD 
RxSwift
RxCocoa

###Modules:
NetworkManager(sessionManager)

DataRepository()

ApiService(networkManager)

TemperaturePoller(apiService)

HomepageViewModel(apiservice, dataRepository)

RoomViewModel(apiService, dataRepository)

### Models:
House

Room

Fixture


