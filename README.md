# Surge Movies - v1.0.0

Surge Movies is a mobile app that let you explore the best-rated movies in the world.

![](assets/icon.png)

[surge-movies](https://aslamanver.github.io/surge-movies/) | [Create Issue](https://github.com/aslamanver/surge-movies/issues/new)

[![Build Status](https://github.com/aslamanver/surge-movies/actions/workflows/dart.yml/badge.svg)](https://github.com/aslamanver/surge-movies/actions)

<hr/>

## Features

- This app is totally free to use
- Offline functionality is enabled
- Up to 10,000 movies to explore

## Demo

- app-v1.0.0.apk [Download](demo/app-v1.0.0.apk)

- [Demo Video](https://drive.google.com/file/d/1EiRIgDZli3-TBoIy1AGnGUlxL0m6qis-/view?usp=share_link)

![](demo/screencast.gif)

## Developer Contributions

> [![Build Status](https://github.com/aslamanver/surge-movies/actions/workflows/dart.yml/badge.svg)](https://github.com/aslamanver/surge-movies/actions)
If the build status is passing, there is no error with any build configurations and dependencies.

1. Clone the project `git clone git@github.com:aslamanver/surge-movies.git`

2. Run `cd surge-movies`

3. Replace API_KEY obtained from [https://www.themoviedb.org](https://www.themoviedb.org)

4. Run `echo "const apiKey = 'YOUR_API_KEY';" | cat > lib/secrets/keys.dart`

5. Run this for Android build  `./install.sh build`

6. If you want to install Android APK run `./install.sh install`

```
✓  Built build/app/outputs/flutter-apk/app-release.apk (18.7MB).
```

## CI/CD

1. GitHub Actions - [.github/workflows/dart.yml](https://github.com/aslamanver/surge-movies/blob/master/.github/workflows/dart.yml)

