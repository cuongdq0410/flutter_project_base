# Bloc Base

## Getting Started

### Configuration Environment Running

- ANDROID STUDIO Step 1 : Open "Edit Configuration in Android Studio"
  Step 1 : Open "Edit Configuration in Android Studio"

Step 2 : Create new Configuration with build flavor value is :

+ Develop Environment : dev
  ``` fvm flutter build ios --flavor stag --dart-define=FLAVOR=dev -t ./lib/main.dart ```
  ``` fvm flutter build apk --flavor stag --dart-define=FLAVOR=dev -t ./lib/main.dart ```
+ Staging Environment : stag
  ``` fvm flutter build ios --flavor stag --dart-define=FLAVOR=stag -t ./lib/main.dart ```
  ``` fvm flutter build apk --flavor stag --dart-define=FLAVOR=stag -t ./lib/main.dart ```
+ Production Environment : prod
  ``` fvm flutter build ios --flavor prod --dart-define=FLAVOR=prod -t ./lib/main.dart ```
  ``` fvm flutter build apk --flavor prod --dart-define=FLAVOR=prod -t ./lib/main.dart ```

###These step need to run before can run app in code

- Multi-languages
  Step 1 : run terminal "flutter clean"

Step 2 : run terminal "flutter pub get"

Step 3 : run terminal "flutter pub global activate intl_utils"

Step 4 : run terminal "flutter pub global run intl_utils:generate"

- Assets,Json generate
  Step 5 : run terminal "dart pub global activate flutter_gen"

Step 6 : run terminal "flutter pub run build_runner build"

### Project architecture (Clean Architecture Approach)

1. Why:
    * We want to separate what type of database that we use for storage (might want to change it later on)
    * To adhere SOLID principles since we are using OOP for this project.
    * Ensuring UI layers don't know what is going on at data layer at all.
    * Might want to separate each layers into different packages.
2. Presentation - Domain - Data.
3. Presentation layer consist of
    * Widgets
    * BLoC
        * Bloc only manages UI state based on business logic
4. Domain layer (Business logic layer)
    * Repositories (interfaces aka idea how the logic would behave)
    * Entities (or models which what UI needs)
    * Usecases (user stories)
        * Typically one function, but can be more if they are functionality related.
        * Remember, one class for one responsibility.
5. Data layer
    * Data Sources
        * remotes (API)
        * locals (Database)
    * Models
        * request
        * response
    * Repositories (Implementation from Domain layer)
6. More insight of layers
   ![image](https://miro.medium.com/max/772/0*sfCDEb571WD-7EfP.jpg)
7. The inner layer should **NOT** know what the outer layer has / do.
8. Reference:
    1. https://github.com/ResoCoder/flutter-tdd-clean-architecture-course
    2. https://github.com/ShadyBoukhary/flutter_clean_architecture (We don't use this plugin)
    3. https://blog.cleancoder.com/uncle-bob/2012/08/13/the-clean-architecture.html



This project is implementing [json_serializable](https://pub.dev/packages/json_serializable). It use
build_runner to generate files. If you make a change to these files, you need to re-run the
generator using build_runner:

```
flutter pub run build_runner build
```

generator using build_runner and remove conflict file :

```
flutter packages pub run build_runner build --delete-conflicting-outputs
```

## Injections

1. We are using `GetIt` for injections. It is fun because we can start the service locator and use
   it everywhere when needed because they are injected at top-level in main.dart.
2. Only use it upon initialization


For non widget usage, manually inject the object on initialization.

## How to change version number and version code :

- Go to pubspec.yaml => line version to change :
- Example : 1.0.10+3 => Version name : 1.0.10, Version code : 3

[warring]: in first time run `chmod +x sh_file_name` for add permission .sh file!