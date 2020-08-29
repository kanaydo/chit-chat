# Flutter Base App

A Base Application to create new flutter application, with some custom configuration and project structure. Implementing flutter_bloc as state_management.

## List of Dependencies
- `flutter_bloc`
- `dio`
- `shimmer`
- `simple_animations`
- `flutter_svg`
- `font_awesome_flutter`
- `flare_flutter`
- `timeline_tile`
- `dropdown_search`
- `shared_preferences`
- `flutter_dotenv`


## Configure Project
**Clone the project**
  ```
  https://github.com/kanaydo/flutter_base_app.git
  ```
  
**Get all dependencies**
  ```
  flutter pub get
  ```
  
**Configure build variants**   
  This project currently having 2 variants:
  - `debug`
  - `release`   
  
  
  Please make sure that this configuration done before working on this project.
  - Duplicate `.env.template` become `.env_release` and `.env_debug`
  - Setup all yours environment variable inside both file.
