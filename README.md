# Wallz

This is Wallz, a Flutter project about a mobile App which consumes APIs from [Wallhaven](https://wallhaven.cc) (you may find api documentation [here](https://wallhaven.cc/help/api)).
This app is intended to offer a mobile experience of the original website, all the contents and resources are up to [Wallhaven](https://wallhaven.cc).

The app will work both on iOS and Android.

## Configuring the project
Wallz is a pretty standard flutter project, so you can clone it and build it 'as is'. 
To prepare your development environment just run (from root directory of the project): 

`flutter pub get`

and you're done.

## Dependencies
Here are some of the main dependencies imported by the app:
 - [Json Serializable](https://pub.dev/packages/json_serializable): all models are written and generated with this library
 - [Gallery Saver](https://pub.dev/packages/gallery_saver): to download wallpapers
 - [Shared Preferences](https://pub.dev/packages/shared_preferences): not used at the moment
 - [Cached Network Image](https://pub.dev/packages/cached_network_image): to render fullscreen images
 - [Photo View](https://pub.dev/packages/photo_view): to handle gesture on fullscreen images

## Screenshots

### Homepage
![Homepage](https://i.ibb.co/jwLJ3vf/Home.png)

### Search grid
![Grid](https://i.ibb.co/KKXQsRM/Grid.png)

### Filters
![Filters](https://i.ibb.co/k8PZyLj/Filters.png)

### Fullscreen wallpaper
![Fullscreen wallpaper](https://i.ibb.co/rw1Rtsw/Wall.png)

### Details
![Details](https://i.ibb.co/RCNs4fH/Details.png)





