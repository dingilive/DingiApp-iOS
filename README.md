# DingiApp-iOS

# Integrating Dingi Maps SDK for iOS into your application

### Installation

This is the recommended workflow for integrating the SDK into an application:

1. Download DingiMap iOS SDK from [here](https://s3-us-west-2.amazonaws.com/dingimap-sdk/DingiMap.framework.zip) and unzip it.

1. Open the project editor, select your application target, then go to the General tab. Drag DingiMap.framework into the “Embedded Binaries” section. (Don’t drag it into the “Linked Frameworks and Libraries” section; Xcode will add it there automatically.) In the sheet that appears, make sure “Copy items if needed” is checked, then click Finish.

1. In the Build Phases tab, click the + button at the top and select “New Run Script Phase”. Enter the following code into the script text field:

```bash
bash "${BUILT_PRODUCTS_DIR}/${FRAMEWORKS_FOLDER_PATH}/DingiMap.framework/strip-frameworks.sh"
```

### Configuration

1. DingiMap vector tiles require a DingiMap account and API access token. In the project editor, select the application target, then go to the Info tab. Under the “Custom iOS Target Properties” section, set `DingiMapAccessToken` to your access token. You can obtain an access token from the [DingiMap account page](https://www.dingi.tech/).


### Usage

In a storyboard or XIB, add a view to your view controller. (Drag View from the Object library to the View Controller scene on the Interface Builder canvas.) In the Identity inspector, set the view’s custom class to `DingiMapView`. If you need to manipulate the map view programmatically:

1. Switch to the Assistant Editor.
1. Import the `DingiMap` module.
1. Connect the map view to a new outlet in your view controller class. (Control-drag from the map view in Interface Builder to a valid location in your view controller implementation.) The resulting outlet declaration should look something like this:

```objc
// ViewController.m
@import DingiMap;

@interface ViewController : UIViewController

@property (strong) IBOutlet DingiMapView *mapView;

@end
```

```swift
// ViewController.swift
import DingiMap

class ViewController: UIViewController {
    @IBOutlet var mapView: DingiMapView!
}
```
