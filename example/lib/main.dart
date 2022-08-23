import 'dart:math';
import 'package:flutter/material.dart';
import 'package:intro/intro.dart';
import 'block.dart';
import 'nested_demo.dart';

void main() {
  return runApp(Intro(
    controller: IntroController(stepCount: 12),
    cardDecoration: IntroCardDecoration(
      tapBarrierToContinue: true,
      showPreviousButton: false,
      nextButtonStyle: ButtonStyle(
        backgroundColor:
            MaterialStateColor.resolveWith((states) => Colors.lightBlue),
        shape: MaterialStateProperty.resolveWith(
            (states) => const RoundedRectangleBorder()),
      ),
      closeButtonStyle: ButtonStyle(
        backgroundColor:
            MaterialStateColor.resolveWith((states) => Colors.lime),
        shape: MaterialStateProperty.resolveWith(
            (states) => const RoundedRectangleBorder()),
      ),
    ),
    topLayerBuilder: (context, controller) {
      return Padding(
        padding: const EdgeInsets.only(top: 20, left: 20),
        child: TextButton(
          onPressed: controller.close,
          style: ButtonStyle(
            foregroundColor: MaterialStateColor.resolveWith((states) => Colors.white70),
            backgroundColor: MaterialStateColor.resolveWith((states) => Colors.white24),
          ),
          child: const Text("Exit"),
        ),
      );
    },
    child: MaterialApp(
      title: 'Intro Demo',
      routes: {
        "home": (context) => const HomePage(),
        "nested": (context) => const NestedDemoPage(),
      },
      initialRoute: "home",
    ),
  ));
}

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  var _color = Colors.pink;
  final _scrollController = ScrollController();

  IntroController get controller => Intro.of(context).controller;

  @override
  void initState() {
    super.initState();
    Future.delayed(const Duration(seconds: 2), () {
      controller.start(context);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Intro Demo Home Page")),
      body: SingleChildScrollView(
        controller: _scrollController,
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            ElevatedButton(
              onPressed: () => controller.start(context),
              child: const Text("Start Demo Flow"),
            ),
            const SizedBox(height: 10),
            _buildStep1(const Block(
              label: "The first step",
            )),
            const SizedBox(height: 10),
            _buildStep2(const Block(
              label: "Decoration for intro card",
            )),
            const SizedBox(height: 10),
            _buildStep3(const Block(
              label: "Decoration for highlighted widget",
            )),
            const SizedBox(height: 10),
            _buildStep4(const Block(
              label: "Customized intro card",
            )),
            const SizedBox(height: 10),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                _buildStep5(ElevatedButton(
                  onPressed: _openNestedPage,
                  child: const Text("Nested Demo"),
                )),
                const SizedBox(width: 10),
                _buildStep6(ElevatedButton(
                  onPressed: _openDialog,
                  child: const Text("Dialog"),
                )),
              ],
            ),
            const SizedBox(height: 10),
            _buildStep8(Block(
              textColor: _color,
              label: "Change state (color)",
            )),
            const SizedBox(height: 10),
            _buildStep9(const Block(
              label: "Rotate your phone, or resize this window",
            )),
            const SizedBox(height: 10),
            _buildStep10(const Block(
              label: "Scroll this page",
            )),
            const SizedBox(height: 10),
            _buildStep11(const Block(
              size: Size(double.infinity, 400),
              label: "Display the intro card inside the large widget",
              fontSize: 22.0,
            )),
            const SizedBox(height: 10),
            _buildStep12(const Block(
              size: Size(300, 50),
              label: "The last step",
            )),
          ],
        ),
      ),
    );
  }

  Widget _buildStep1(Widget child) {
    return IntroStepTarget(
      step: 1,
      controller: controller,
      cardContents: TextSpan(
        text: "Welcome to use this package.\n"
            "This is the first step and there are ${controller.stepCount} steps here.",
      ),
      child: child,
    );
  }

  Widget _buildStep2(Widget child) {
    return IntroStepTarget(
      step: 2,
      controller: controller,
      cardContents: const TextSpan(
        children: [
          TextSpan(text: "Notice the style of the intro card here.\n\n"),
          TextSpan(
            text: "By the way",
            style: TextStyle(
              fontStyle: FontStyle.italic,
              decoration: TextDecoration.underline,
            ),
          ),
          TextSpan(text: ", you can use "),
          TextSpan(
            text: "rich text",
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 20.0,
              color: Colors.pinkAccent,
            ),
          ),
          TextSpan(text: " here. 👀"),
        ],
      ),
      cardDecoration: IntroCardDecoration(
        backgroundColor: Colors.white24,
        padding: const EdgeInsets.all(15),
        margin: const EdgeInsets.all(5),
        showCloseButton: true,
        showPreviousButton: true,
        border: Border.all(
          color: Colors.white38,
          width: 2.0,
        ),
        radius: BorderRadius.zero,
        textStyle: const TextStyle(
          color: Colors.yellowAccent,
          fontFamily: "Segoe Print",
          shadows: [
            Shadow(offset: Offset(3, 3), blurRadius: 1.0),
          ],
        ),
        previousButtonLabel: "←",
        closeButtonLabel: "×",
        nextButtonLabel: "→",
        previousButtonStyle: ButtonStyle(
          backgroundColor:
              MaterialStateColor.resolveWith((states) => Colors.blueGrey),
          textStyle:
              MaterialStateTextStyle.resolveWith((states) => const TextStyle(
                    inherit: true,
                    fontSize: 24.0,
                    fontFamily: "STHupo",
                  )),
        ),
        closeButtonStyle: ButtonStyle(
          backgroundColor:
              MaterialStateColor.resolveWith((states) => Colors.pink),
          textStyle:
              MaterialStateTextStyle.resolveWith((states) => const TextStyle(
                    inherit: true,
                    fontSize: 24.0,
                    fontFamily: "STHupo",
                  )),
        ),
        nextButtonStyle: ButtonStyle(
          backgroundColor:
              MaterialStateColor.resolveWith((states) => Colors.green),
          textStyle:
              MaterialStateTextStyle.resolveWith((states) => const TextStyle(
                    inherit: true,
                    fontSize: 24.0,
                    fontFamily: "STHupo",
                  )),
        ),
      ),
      child: child,
    );
  }

  Widget _buildStep3(Widget child) {
    return IntroStepTarget(
      step: 3,
      controller: controller,
      cardContents: const TextSpan(
        text: "Notice the style of the highlighted widget here.",
      ),
      highlightDecoration: const IntroHighlightDecoration(
        border: Border.fromBorderSide(BorderSide(
          color: Colors.pink,
          width: 3.0,
        )),
        radius: BorderRadius.all(Radius.circular(80)),
        padding: EdgeInsets.all(20),
      ),
      child: child,
    );
  }

  Widget _buildStep4(Widget child) {
    return IntroStepTarget.custom(
      step: 4,
      controller: controller,
      highlightDecoration: IntroHighlightDecoration(
        radius: const BorderRadius.only(
          topLeft: Radius.circular(8),
          topRight: Radius.circular(8),
        ),
        border: Border.all(
          color: Colors.teal,
          width: 5.0,
        ),
        padding: const EdgeInsets.all(10),
      ),
      cardDecoration: const IntroCardDecoration(
        align: IntroCardAlign.outsideBottomLeft,
        margin: EdgeInsets.zero,
        textStyle: TextStyle(
            color: Colors.white,
            fontSize: 15,
            fontFamily: "Comic Sans MS",
            shadows: [
              Shadow(
                color: Colors.black87,
                offset: Offset(1, 1),
                blurRadius: 3.0,
              ),
            ]),
      ),
      cardBuilder: (context, param, decoration) {
        return Container(
          width: 475,
          height: 275,
          decoration: const BoxDecoration(
            color: Colors.teal,
            borderRadius: BorderRadius.only(
              topRight: Radius.circular(8),
              bottomLeft: Radius.circular(8),
              bottomRight: Radius.circular(8),
            ),
          ),
          padding: const EdgeInsets.all(15),
          child: Row(
            children: [
              Expanded(
                child: Stack(
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Icon(Icons.heart_broken,
                                size: 40, color: Colors.redAccent),
                            const SizedBox(width: 20),
                            Expanded(
                              child: Text(
                                "If you don't like the default style of intro card. "
                                "You can customize it use [IntroStepTarget.custom] constructor "
                                "and specify the [cardBuilder] field.",
                                style: decoration.textStyle,
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 20),
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Icon(Icons.sports_handball,
                                size: 40, color: Colors.orangeAccent),
                            const SizedBox(width: 20),
                            Expanded(
                              child: Builder(
                                builder: (context) {
                                  final rect = param.targetRect;
                                  final left = rect.left.toStringAsFixed(0);
                                  final top = rect.top.toStringAsFixed(0);
                                  final width = rect.width.toStringAsFixed(0);
                                  final height = rect.height.toStringAsFixed(0);
                                  return Text(
                                    "You can use the [IntroParams] argument to get the step status "
                                    "or to control the demo flow. Such as the offset of target widget is "
                                    "($left, $top) and size is $width×$height.",
                                    style: decoration.textStyle,
                                  );
                                },
                              ),
                            )
                          ],
                        ),
                        const SizedBox(height: 20),
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Icon(Icons.draw,
                                size: 40, color: Colors.greenAccent),
                            const SizedBox(width: 20),
                            Expanded(
                              child: Text(
                                "The [IntroCardDecoration] argument comes from the context, "
                                "and you can use some of its properties.",
                                style: decoration.textStyle,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                    Container(
                      constraints: const BoxConstraints.expand(),
                      alignment: Alignment.center,
                      child: Transform.rotate(
                        angle: -pi / 8,
                        child: const Text(
                          "   CUSTOMIZATION",
                          style: TextStyle(
                            fontSize: 40.0,
                            color: Colors.white24,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(width: 20),
              const VerticalDivider(color: Colors.white38),
              Column(
                children: [
                  MaterialButton(
                    onPressed: () {
                      param.controller.previous();
                    },
                    minWidth: 40,
                    height: 50,
                    color: Colors.white24,
                    elevation: 0,
                    hoverElevation: 0,
                    highlightElevation: 0,
                    child: const Icon(Icons.arrow_upward,
                        color: Colors.white, size: 25),
                  ),
                  const SizedBox(height: 20),
                  MaterialButton(
                    onPressed: () {
                      param.controller.next();
                    },
                    minWidth: 40,
                    height: 50,
                    color: Colors.white24,
                    elevation: 0,
                    hoverElevation: 0,
                    highlightElevation: 0,
                    child: const Icon(Icons.arrow_downward,
                        color: Colors.white, size: 25),
                  ),
                  Expanded(child: Container()),
                  Container(
                    decoration: BoxDecoration(
                        border: Border.all(
                      color: Colors.white38,
                    )),
                    padding:
                        const EdgeInsets.symmetric(horizontal: 3, vertical: 2),
                    child: Text(
                      "${param.step}/${param.controller.stepCount}",
                      style: const TextStyle(color: Colors.white38),
                    ),
                  ),
                ],
              )
            ],
          ),
        );
      },
      child: child,
    );
  }

  Widget _buildStep5(Widget child) {
    return IntroStepTarget(
      step: 5,
      controller: controller,
      cardContents: const TextSpan(
        text: "Tap this button to open the nested demo page.\n"
            "When you return back this page, the demo flow will continue.",
      ),
      highlightDecoration: const IntroHighlightDecoration(
        cursor: SystemMouseCursors.click,
      ),
      onHighlightTap: _openNestedPage,
      child: child,
    );
  }

  Widget _buildStep6(Widget child) {
    return IntroStepTarget(
      step: 6,
      controller: controller,
      cardContents: const TextSpan(
        text: "Tap this button to open a dialog.\n"
            "Current demo flow will continue after you close that dialog.",
      ),
      highlightDecoration: const IntroHighlightDecoration(
        cursor: SystemMouseCursors.click,
      ),
      onHighlightTap: controller.next,
      onStepWillDeactivate: (willToStep) async {
        if (willToStep == 7) {
          _openDialog();
          await Future.delayed(const Duration(milliseconds: 100));
        }
      },
      child: child,
    );
  }

  Widget _buildStep7(Widget child) {
    return IntroStepTarget(
      step: 7,
      controller: controller,
      cardContents: const TextSpan(
        text: "This is a dialog.\n"
            "It will be closed automatically in 3 seconds.",
      ),
      highlightDecoration: const IntroHighlightDecoration(
        radius: BorderRadius.all(Radius.circular(120)),
        padding: EdgeInsets.all(40),
      ),
      onStepWillDeactivate: (willToStep) {
        Navigator.pop(context);
      },
      onTargetLoad: () {
        if (!controller.isOpened) {
          Future.delayed(const Duration(milliseconds: 500), () {
            controller.start(context, initStep: 7);
          });
        }
        Future.delayed(const Duration(seconds: 3), () {
          if (controller.currentStep == 7) {
            controller.next();
          }
        });
      },
      child: child,
    );
  }

  Widget _buildStep8(Widget child) {
    return IntroStepTarget(
      step: 8,
      controller: controller,
      cardContents: const TextSpan(
        text: "Tap to this label to change its color.",
      ),
      highlightDecoration: const IntroHighlightDecoration(
        cursor: SystemMouseCursors.click,
      ),
      onHighlightTap: () {
        setState(() {
          final colors = [Colors.pink, Colors.teal, Colors.purple];
          var index = colors.indexOf(_color) + 1;
          if (index >= colors.length) {
            index = 0;
          }
          _color = colors[index];
        });
      },
      child: child,
    );
  }

  Widget _buildStep9(Widget child) {
    return IntroStepTarget(
      step: 9,
      controller: controller,
      cardContents: const TextSpan(
        text: "Intro card and highlighted widget will refresh automatically.",
      ),
      child: child,
    );
  }

  Widget _buildStep10(Widget child) {
    return IntroStepTarget(
      step: 10,
      controller: controller,
      cardContents: const TextSpan(
        text: "The page will scroll to the bottom",
      ),
      onStepWillActivate: (fromStep) {
        if (fromStep == 9) {
          _scrollController
              .animateTo(
            _scrollController.position.maxScrollExtent,
            duration: const Duration(milliseconds: 200),
            curve: Curves.linear,
          )
              .then((_) {
            controller.refresh();
          });
        }
      },
      child: child,
    );
  }

  Widget _buildStep11(Widget child) {
    return IntroStepTarget(
      step: 11,
      controller: controller,
      cardContents: const TextSpan(
        text: "If the automatically calculated alignment\n"
            "doesn't show up in the right position, you\n"
            "can specify it manually.",
      ),
      cardDecoration: const IntroCardDecoration(
        align: IntroCardAlign.insideBottomLeft,
        backgroundColor: Colors.black26,
        padding: EdgeInsets.all(20),
      ),
      child: child,
    );
  }

  Widget _buildStep12(Widget child) {
    return IntroStepTarget(
      step: 12,
      controller: controller,
      cardContents: const TextSpan(
        text: "This is the last step.\n"
            "Click the [Close] button to close it.",
      ),
      child: child,
    );
  }

  void _openNestedPage() {
    controller.close();
    Future.delayed(controller.intro.animationDuration, () {
      Navigator.pushNamed(context, "nested").then((value) {
        Future.delayed(const Duration(milliseconds: 500), () {
          controller.start(context, initStep: 5);
        });
      });
    });
  }

  void _openDialog() {
    showDialog(
      context: context,
      barrierDismissible: false,
      barrierColor: Colors.black54,
      builder: (context) {
        return Material(
          type: MaterialType.transparency,
          child: Center(
            child: _buildStep7(Container(
              width: 320,
              height: 200,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(10),
                boxShadow: const [
                  BoxShadow(
                    color: Colors.black54,
                    offset: Offset(2, 2),
                    blurRadius: 8.0,
                  ),
                ],
              ),
              alignment: Alignment.center,
              child: const Text(
                "Hello!",
                style: TextStyle(fontSize: 50.0),
              ),
            )),
          ),
        );
      },
    );
  }
}
