# intro

An application wizard package. 

With this package, you can implement a step-by-step guide to help you demonstrate your software or introduce your product.

![general_usage_demo](./images/general.gif)

![nested_usage_demo](./images/nested.gif)

![nested_usage_demo](./images/advanced.gif)



## Features

- Step by step demonstration
- Control the presentation process
- Highlight the target widget
- Automatically calculates the card display position and alignment
- Customizable style and behavior
- Supports nesting of multiple presentation processes
- Link between different pages or dialogs
- Full platform support
  - [x] Windows
  - [x] macOS
  - [x] Android
  - [x] iOS
  - [x] Linux
  - [x] Web



## Getting started

Add this package to your project.

```shell
flutter pub add intro
```

Import it in your code.

```dart
import 'package:intro/intro.dart';
```

Register the `Intro` widget at the earliest possible widget tree node.

Provide a `IntroController` that has specified the `stepCount`. The `stepCount` refers to the total number of steps in the presentation process.

```dart
runApp(Intro(
  controller: IntroController(stepCount: 5),
  child: MaterialApp(
  	home: HomePage(),
  ),
));
```

Wrap the `IntroStepTarget` widget around each of your target widgets that you need to introduce.

```dart
IntroStepTarget(
  step: step,
  controller: Intro.of(context).controller,
  cardContents: TextSpan(
  	text: "The introductory text of this step.",
  ),
	child: targetWidget,
);
```

Start the presentation process at the right time.

```dart
Intro.of(context).controller.start(context);
```



## General Usage

![genera_usage_1](images/general_usage_1.png)

![genera_usage_2](images/general_usage_2.png)

![genera_usage_3](images/general_usage_3.png)

![genera_usage_4](images/general_usage_4.png)

![genera_usage_5](images/general_usage_5.png)

![genera_usage_6](images/general_usage_6.png)

![genera_usage_7](images/general_usage_7.png)

![genera_usage_8](images/general_usage_8.png)

![genera_usage_9](images/general_usage_9.png)

![genera_usage_10](images/general_usage_10.png)

![genera_usage_11](images/general_usage_11.png)

![genera_usage_12](images/general_usage_12.png)

![genera_usage_13](images/general_usage_13.png)



## Nested Usage

You can define multiple [Intro] widgets and each one uses a separate [IntroController].



> **Note:**
>
> 1. The same target widget may be used in different presentation processes.
> 2. The same target widget can define different introduction card in different presentation flows.
> 3. Each presentation flow is controlled through its own [IntroController].



## Advanced Usage

To see the full demonstration or more advanced features, read the example code please.
