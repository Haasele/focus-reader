# Focus Reader

---

Focus Reader is an App, that enables reading a ebook, pdf or .txt file via the RSVP method.

---

The App is build in Flutter and should work on every Flutter supported Platform. I successfully tested the Application on Linux, MacOS, Android and as a Web Application.

Currently the iOS Application builds, but i can't test it yet because of missing Codesign Requirements (thanks Apple).

The Web Application is also working, but the ebook Viewer is currently disabled because of compatibility issues.


## How to Build it yourself?

flutter apps are easy to deploy, you just need the Flutter program for your platform (Windows, Linux, MacOS)

On Windows you can use chocolately
```
choco install flutter
```

On MacOS you can use brew
```
brew install flutter
```

On Linux it is recommended to use the snap package - Snap should work on every Distro and easily lets you update flutter
```
sudo snap install flutter --classic
```

After setting up flutter, you need to clone the repository
```
git clone https://github.com/haasele/focus-reader
```

After that cd into the directory
```
cd focus-reader
```

Then install all needed packages
```
flutter pub get
```

Now you are set up and able to build the App.
Please keep in mind, that you are not able to build flutter for MacOS on non-MacOS devices, you can't build it for Windows on non-Windows devices and you can't build for Linux on non-Linux devices.

However your are always able to build an APK for Android with
```
flutter build apk --release
```

And your able to build for the web with
```
flutter build web
```

You could also build for iPhones/iPads with
```
flutter build ios
```
But you need a Developer Account to run the App correctly

---

Platform slecific builds are

Windows
```
flutter build windows
```

Linux
```
flutter build linux
```

MacOS
```
flutter build macos
```

---

### Have fun!