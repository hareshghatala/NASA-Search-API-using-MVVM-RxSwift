# NASA Search API usage using MVVM RxSwift
This repository demonstrate the NASA's images using search API and demonstrate MVVM architecture with RxSwift

When opening the app, users can see a list of images including name, title and date. All images are fetched from NASA's API. When selecting one of the item from list, users can see details screen containing image, name, title, date and description. 
- Loading and error states are handled using RxSwift observable.
- Images are chached for better performance.
- ViewModel & View bounded using RxSwift Observer & Observable.
- UI is updated when data updated using RxSwift notifier.
- Data passed to next screen and populate UI using RxSwift.


## Technical Specification

>  - [x] Xcode 11 and later 
>  - [x] iOS 13.6
>  - [x] Swift 5
>  - [x] iPhone only app
>  - [x] Storyboard & Segue Navigation
>  - [ ] Unit Tests

### Architecture
MVVM *(Model View ViewModel)*

### Cocoa Pods Used
```RxSwift```
```RxCocoa```

### API provider
```https://images-api.nasa.gov/search?q=%22%22```

---------- 

## Communication

-   If you  **want to contribute**, submit a pull request.
-   For any qustion or suggetions, you can create issue for it. Enjoy The Coding !!!
