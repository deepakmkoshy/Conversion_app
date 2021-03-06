// Copyright 2018 The Chromium Authors. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

// You can read about packages here: https://flutter.io/using-packages/
import 'package:conversion_app/category_route.dart';
import 'package:flutter/material.dart';
import 'package:splashscreen/splashscreen.dart';

// You can use a relative import, i.e. `import 'category.dart';` or
// a package import, as shown below.
// More details at http://dart-lang.github.io/linter/lints/avoid_relative_lib_imports.html
import 'category_route.dart';

// TODO: Pass this information into your custom [Category] widget
/*const _categoryName = 'Cake';
const _categoryIcon = Icons.cake;
const _categoryColor = Colors.green;*/

/// The function that is called when main.dart is run.
void main() {
  runApp(UnitConverterApp());
}

/// This widget is the root of our application.

class UnitConverterApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Unit Converter',
      theme: ThemeData(
        fontFamily: 'Raleway',
        textTheme: Theme.of(context).textTheme.apply(
              bodyColor: Colors.black,
              displayColor: Colors.grey[600],
              fontFamily: 'Raleway',
            ),
        primaryColor: Colors.grey[500],
        textSelectionHandleColor: Colors.green[500],
      ),
      home: SplashScreen(
        seconds: 2,
        navigateAfterSeconds: CategoryRoute(),
        image: Image.asset(
          'assets/icons/icon.png',
          width: 100,
        ),
        photoSize: 120,
        backgroundColor: Colors.white70,
        loadingText: Text(
          'Make sure network is Connected for getting Currency Exchange Rates!',
          textAlign: TextAlign.center,
        ),
      ),
    );
  }
}
