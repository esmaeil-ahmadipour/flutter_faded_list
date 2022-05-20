![Screenshot](https://github.com/esmaeil-ahmadipour/flutter_faded_list/blob/master/img/banner.png?raw=true "Flutter Faded List Banner")
# Flutter Faded List plugin

This package helps you display a list of your widgets with the blurred image in the first item.

![Screenshot](https://github.com/esmaeil-ahmadipour/flutter_faded_list/blob/master/img/flutter_faded_list.gif?raw=true "Flutter Faded List Demo")

### Installation

To use this plugin, add flutter_faded_list in your `pubspec.yaml`

```
dependencies:
  flutter_faded_list: ^0.0.3
```

Or install automatically using this command

```
$ flutter pub add flutter_faded_list
```

### Simple to use

```dart
import 'package:flutter_faded_list/flutter_faded_list.dart';

...
               FadedHorizontalList(
                  blankSpaceWidth: 200,
                  bodyColor: const Color(0xffAD4516),
                  imageWidget: Image.network("https://i.picsum.photos/id/478/536/354.jpg?hmac=adxYyHX8WcCfHkk07quT2s92fbC7vY2QttaeBztwxgI"),
                  children: [
                    for (var i = 0; i < 10; ++i)
                      const Padding(
                      padding: const EdgeInsets.all(70.0),
                      child:Text("  Hello World!  ")),
                  ],
                ),
...
```

### And bonus widget 🎉
Use this widget in FadedHorizontalList for headerWidget property .

```dart
import 'package:flutter_faded_list/flutter_faded_list.dart';

FadedHeaderWidget(title: Text("Sample Header Title")),
...