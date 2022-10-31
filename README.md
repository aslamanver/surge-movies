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

![](demo/screencast.gif)

## Developer Contributions

1. Clone the projest `git clone git@github.com:aslamanver/surge-movies.git`

2. Run `cd surge-movies`

3. Replace API_KEY that obrained from [https://www.themoviedb.org](https://www.themoviedb.org)

4. Run `echo "const apiKey = 'YOUR_API_KEY';" | cat > lib/secrets/keys.dart`

5. Run this for Android build  `./install.sh build`

6. If you want to install Android APK run `./install.sh install`

```
✓  Built build/app/outputs/flutter-apk/app-release.apk (18.7MB).
```

## ci

1. GitHub Actions - [.github/workflows/dart.yml](.github/workflows/dart.yml)

