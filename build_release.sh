#!/bin/bash
flutter clean
flutter build apk -t lib/main_release.dart --release --split-per-abi
dolphin build/app/outputs/flutter-apk/