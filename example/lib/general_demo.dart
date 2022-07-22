import 'dart:math';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:intro/intro.dart';

class GeneralDemoPage extends StatelessWidget {
  const GeneralDemoPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Intro(
      controller: IntroController(stepCount: 13), // 13 means it has 13 steps.
      child: const _IntroDemo(),
    );
  }
}

class _IntroDemo extends StatefulWidget {
  const _IntroDemo({Key? key}) : super(key: key);

  @override
  State<_IntroDemo> createState() => _IntroDemoState();
}

class _IntroDemoState extends State<_IntroDemo> {
  Intro? _intro;

  @override
  void initState() {
    super.initState();
    Future.delayed(const Duration(milliseconds: 500), () {
      _intro?.controller.start(context);
    });
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _intro = Intro.of(context);
  }

  @override
  void dispose() {
    _intro?.controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("General Usage")),
      body: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              IntroStepTarget(
                step: 1,
                controller: _intro!.controller,
                cardContents: const TextSpan(
                  text: "Welcome to use this package!\n\n"
                      "This is the first step.\n"
                      "Now, please click <Next> button to continue.",
                ),
                child: Container(
                  width: 120,
                  height: 80,
                  color: Colors.amber,
                  alignment: Alignment.center,
                  child: const Text("Step 1 Target"),
                ),
              ),
              const SizedBox(height: 20),
              IntroStepTarget(
                step: 2,
                controller: _intro!.controller,
                cardContents: const TextSpan(
                  text: "This is non-first step.\n\n"
                      "It automatically displays the previous button by default. But\n"
                      "you are free to specify whether it is displayed or not. I will\n"
                      "introduce it to you in the next step.\n\n"
                      "Now please click the <Next> button to continue or<Previous>\n"
                      "button back to previous step.",
                ),
                child: Container(
                  width: 120,
                  height: 80,
                  color: Colors.amber,
                  alignment: Alignment.center,
                  child: const Text("Step 2 Target"),
                ),
              ),
              const SizedBox(height: 20),
              IntroStepTarget(
                step: 3,
                controller: _intro!.controller,
                cardContents: const TextSpan(
                  text:
                      "You can specify the behavior and style of the buttons of this \n"
                      "presentation card, such as labels, fonts, colors, backgrounds,\n"
                      "borders, sizes, and visibility through the [cardDecoration] field.\n\n"
                      "The [cardDecoration] field in this [IntroStepTarget] widget only\n"
                      "affects this step. If you want all steps to look the same effects,\n"
                      "you can set the global decoration in the [Intro] widget.",
                ),
                cardDecoration: IntroCardDecoration(
                  showPreviousButton: true,
                  showNextButton: true,
                  showCloseButton: true,
                  autoHideDisabledButton: false,
                  previousButtonLabel: "Back",
                  nextButtonLabel: "Continue",
                  nextButtonFinishLabel: "Complete",
                  closeButtonLabel: "Close",
                  nextButtonStyle: ButtonStyle(
                    backgroundColor: MaterialStateColor.resolveWith(
                        (states) => Colors.green),
                  ),
                  previousButtonStyle: ButtonStyle(
                    textStyle: MaterialStateTextStyle.resolveWith(
                        (states) => const TextStyle(
                              inherit: false,
                              fontSize: 10,
                              fontStyle: FontStyle.italic,
                            )),
                    foregroundColor: MaterialStateColor.resolveWith(
                        (states) => Colors.black),
                    backgroundColor:
                        MaterialStateColor.resolveWith((states) => Colors.grey),
                  ),
                  closeButtonStyle: ButtonStyle(
                      backgroundColor: MaterialStateColor.resolveWith((states) {
                    if (states.contains(MaterialState.hovered)) {
                      return Colors.blueAccent;
                    } else {
                      return Colors.pinkAccent;
                    }
                  })),
                ),
                child: Container(
                  width: 120,
                  height: 80,
                  color: Colors.amber,
                  alignment: Alignment.center,
                  child: const Text("Step 3 Target"),
                ),
              ),
              const SizedBox(height: 20),
              IntroStepTarget(
                step: 4,
                controller: _intro!.controller,
                cardContents: const TextSpan(
                  text:
                      "You can change the decoration for highlight area and this introduction card.\n\n"
                      "The effect is as you can see now.",
                ),
                cardDecoration: IntroCardDecoration(
                  size: const Size(400, 220),
                  backgroundColor: Colors.blueGrey.withOpacity(0.8),
                  border: Border.all(color: Colors.cyan, width: 3.0),
                  radius: BorderRadius.circular(20),
                  margin: const EdgeInsets.all(40),
                  padding: const EdgeInsets.all(30),
                  textStyle: const TextStyle(
                    fontSize: 16,
                    color: Colors.amber,
                  ),
                  showPreviousButton: true,
                  previousButtonStyle: ButtonStyle(
                    shape: MaterialStateProperty.resolveWith(
                        (states) => const RoundedRectangleBorder()),
                    elevation:
                        MaterialStateProperty.resolveWith((states) => 0.0),
                    backgroundColor: MaterialStateProperty.resolveWith(
                        (states) => Colors.grey),
                    foregroundColor: MaterialStateProperty.resolveWith(
                        (states) => Colors.white),
                    fixedSize: MaterialStateProperty.resolveWith(
                        (states) => const Size(120, 35)),
                  ),
                  nextButtonStyle: ButtonStyle(
                    shape: MaterialStateProperty.resolveWith(
                        (states) => const RoundedRectangleBorder()),
                    elevation:
                        MaterialStateProperty.resolveWith((states) => 0.0),
                    backgroundColor: MaterialStateProperty.resolveWith(
                        (states) => Colors.cyan),
                    foregroundColor: MaterialStateProperty.resolveWith(
                        (states) => Colors.black),
                    fixedSize: MaterialStateProperty.resolveWith(
                        (states) => const Size(120, 35)),
                  ),
                ),
                highlightDecoration: IntroHighlightDecoration(
                  border: const Border.fromBorderSide(BorderSide.none),
                  radius: BorderRadius.circular(90),
                  padding: const EdgeInsets.all(50),
                ),
                child: Container(
                  width: 120,
                  height: 80,
                  color: Colors.amber,
                  alignment: Alignment.center,
                  child: const Text("Step 4 Target"),
                ),
              ),
            ],
          ),
          const SizedBox(width: 20),
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  IntroStepTarget(
                    step: 5,
                    controller: _intro!.controller,
                    cardContents: TextSpan(
                      children: [
                        const TextSpan(text: "You can use rich text here.\n\n"),
                        const TextSpan(text: "Such as "),
                        const TextSpan(
                            text: "bold",
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                            )),
                        const TextSpan(text: ", "),
                        const TextSpan(
                            text: "italic",
                            style: TextStyle(
                              fontStyle: FontStyle.italic,
                            )),
                        const TextSpan(text: ", "),
                        const TextSpan(
                            text: "underline",
                            style: TextStyle(
                              decoration: TextDecoration.underline,
                              decorationStyle: TextDecorationStyle.dashed,
                            )),
                        const TextSpan(text: ", "),
                        const TextSpan(
                            text: "font size",
                            style: TextStyle(fontSize: 40.0)),
                        const TextSpan(text: ", "),
                        const TextSpan(
                            text: "color",
                            style: TextStyle(
                              color: Colors.pink,
                              backgroundColor: Colors.yellow,
                            )),
                        const TextSpan(text: ", emoji(😂👀🐶💖)"),
                        const TextSpan(text: ",\n"),
                        TextSpan(
                          text: "link (click to go to the next step)",
                          style: const TextStyle(
                            decoration: TextDecoration.underline,
                          ),
                          recognizer: TapGestureRecognizer()
                            ..onTap = () {
                              _intro!.controller.next();
                            },
                          mouseCursor: SystemMouseCursors.click,
                        ),
                        const TextSpan(text: " and so on."),
                      ],
                    ),
                    child: Container(
                      width: 190,
                      height: 30,
                      color: Colors.pink,
                      alignment: Alignment.center,
                      child: const Text("Step 5 Target"),
                    ),
                  ),
                  const SizedBox(width: 20),
                  IntroStepTarget(
                    step: 6,
                    controller: _intro!.controller,
                    cardContents: const TextSpan(
                      text:
                          "Notice the alignment of the introduction card with respect to\n"
                          "the highlighted area. By default it automatically calculates where\n"
                          "it should be displayed. But you can specify it manually. For example,\n"
                          "in the next step, I'll show it inside the highlighted area.",
                    ),
                    child: Container(
                      width: 190,
                      height: 30,
                      color: Colors.pink,
                      alignment: Alignment.center,
                      child: const Text("Step 6 Target"),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 20),
              IntroStepTarget(
                step: 7,
                controller: _intro!.controller,
                cardContents: const TextSpan(
                  text: "Shows inside the highlighted area.",
                ),
                cardDecoration: const IntroCardDecoration(
                  align: IntroCardAlign.insideBottomRight,
                  margin: EdgeInsets.all(20),
                  padding: EdgeInsets.all(10),
                  backgroundColor: Colors.black38,
                  radius: BorderRadius.all(Radius.circular(4)),
                  showPreviousButton: true,
                ),
                highlightDecoration: const IntroHighlightDecoration(
                  padding: EdgeInsets.all(2),
                  border: Border.fromBorderSide(BorderSide.none),
                  radius: BorderRadius.zero,
                ),
                child: Container(
                  width: 400,
                  height: 300,
                  color: Colors.teal,
                  alignment: Alignment.center,
                  child: const Text("Step 7 Target"),
                ),
              ),
              const SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  IntroStepTarget(
                    step: 8,
                    controller: _intro!.controller,
                    cardContents: const TextSpan(
                      text:
                          "You can handle tap event in the highlight area.\n\n"
                          "Specify [onTargetTap] callback in [IntroStepTarget] widget. And then try to\n"
                          "tap the highlight area to go back previous step.\n\n"
                          "Additional, you can also set the mouse cursor through [highlightDecoration].",
                    ),
                    onTargetTap: () {
                      _intro!.controller.previous();
                    },
                    highlightDecoration: const IntroHighlightDecoration(
                      cursor: SystemMouseCursors.click,
                    ),
                    child: Container(
                      width: 190,
                      height: 30,
                      color: Colors.pink,
                      alignment: Alignment.center,
                      child: const Text("Step 8 Target"),
                    ),
                  ),
                  const SizedBox(width: 20),
                  IntroStepTarget(
                    step: 9,
                    controller: _intro!.controller,
                    cardContents: const TextSpan(
                        text:
                            "Try to change the window size (if running on desktop platform) or rotate\n"
                            "the screen (if running on mobile platform), it will adjust automatically."),
                    child: Container(
                      width: 190,
                      height: 30,
                      color: Colors.pink,
                      alignment: Alignment.center,
                      child: const Text("Step 9 Target"),
                    ),
                  ),
                ],
              ),
            ],
          ),
          const SizedBox(width: 20),
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              IntroStepTarget(
                step: 10,
                controller: _intro!.controller,
                cardContents: const TextSpan(
                  text:
                      "You can do something through the [onStepWillActivate] or\n"
                      "[onStepWillDeactivate] callback when this step is activating or\n"
                      "deactivating. By the way, these two callbacks support providing a\n"
                      "[Future].\n\n"
                      "This feature is very useful when you need to do something between\n"
                      "the switch steps, such as opening a page, loading an image, sending\n"
                      "a network request, do some preparatory work for the next step or\n"
                      "release resources etc.",
                ),
                onStepWillActivate: (fromStep) async {
                  // TODO: Do something...
                },
                onStepWillDeactivate: (willToStep) async {
                  // TODO: Do something...
                },
                child: Container(
                  width: 120,
                  height: 80,
                  color: Colors.amber,
                  alignment: Alignment.center,
                  child: const Text("Step 10 Target"),
                ),
              ),
              const SizedBox(height: 20),
              IntroStepTarget(
                step: 11,
                controller: _intro!.controller,
                cardContents: const TextSpan(
                  text: "You can do something through the [onTargetLoad] or\n"
                      "[onTargetDispose] call when the target widget was built or\n"
                      "disposed. For example, you can release some resources\n"
                      "when the target widget was disposed.",
                ),
                onTargetLoad: () {
                  // TODO: Do something...
                },
                onTargetDispose: () {
                  // TODO: Do something...
                },
                child: Container(
                  width: 120,
                  height: 80,
                  color: Colors.amber,
                  alignment: Alignment.center,
                  child: const Text("Step 11 Target"),
                ),
              ),
              const SizedBox(height: 20),
              IntroStepTarget.custom(
                step: 12,
                controller: _intro!.controller,
                highlightDecoration: IntroHighlightDecoration(
                  radius: const BorderRadius.only(
                    topRight: Radius.circular(8),
                    bottomRight: Radius.circular(8),
                  ),
                  border: Border.all(
                    color: Colors.teal,
                    width: 5.0,
                  ),
                  padding: EdgeInsets.zero,
                ),
                cardDecoration: const IntroCardDecoration(
                    margin: EdgeInsets.zero,
                    textStyle: TextStyle(
                        color: Colors.white,
                        fontSize: 15,
                        fontFamily: "Comic Sans MS",
                        shadows: [
                          Shadow(
                            color: Colors.black87,
                            blurRadius: 3.0,
                          ),
                        ])),
                cardBuilder: (context, param, decoration) {
                  return Container(
                    width: 500,
                    height: 300,
                    decoration: const BoxDecoration(
                      color: Colors.teal,
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(8),
                        topRight: Radius.circular(8),
                        bottomLeft: Radius.circular(8),
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
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      const Icon(Icons.heart_broken,
                                          size: 40, color: Colors.redAccent),
                                      const SizedBox(width: 20),
                                      Expanded(
                                        child: Text(
                                          "If you don't like the default style of introduction card. "
                                          "You can customize it using [IntroStepTarget.custom] constructor "
                                          "and specify the [cardBuilder] field.",
                                          style: decoration.textStyle,
                                        ),
                                      ),
                                    ],
                                  ),
                                  const SizedBox(height: 20),
                                  Row(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      const Icon(Icons.sports_handball,
                                          size: 40, color: Colors.orangeAccent),
                                      const SizedBox(width: 20),
                                      Expanded(
                                        child: Text(
                                          "You can using the [IntroParams] argument to get the step status "
                                          "or to control the presentation flow.",
                                          style: decoration.textStyle,
                                        ),
                                      )
                                    ],
                                  ),
                                  const SizedBox(height: 20),
                                  Row(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
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
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 3, vertical: 2),
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
                child: Container(
                  width: 120,
                  height: 80,
                  color: Colors.amber,
                  alignment: Alignment.center,
                  child: const Text("Step 12 Target"),
                ),
              ),
              const SizedBox(height: 20),
              IntroStepTarget(
                step: 13,
                controller: _intro!.controller,
                cardContents: TextSpan(children: [
                  const TextSpan(
                      text: "Congratulations on coming the last step.\n\n"
                          "You can find that the label of <Next> button has been became\n"
                          "to  <Finish> automatically. Click it to close this presentation flow.\n\n"
                          "By the way, you can jump to any step via the [IntroController]. Try\n"
                          "to tap the following links back to a former step.\n\n"),
                  TextSpan(
                    text: "Jump to the first step",
                    recognizer: TapGestureRecognizer()
                      ..onTap = () {
                        _intro!.controller.jumpTo(1);
                      },
                    style: const TextStyle(
                      decoration: TextDecoration.underline,
                      color: Colors.blue,
                    ),
                  ),
                  const TextSpan(text: " 👈\n"),
                  TextSpan(
                    text: "Jump to step eleven",
                    recognizer: TapGestureRecognizer()
                      ..onTap = () {
                        _intro!.controller.jumpTo(11);
                      },
                    style: const TextStyle(
                      decoration: TextDecoration.underline,
                      color: Colors.blue,
                    ),
                  ),
                  const TextSpan(text: " 👈\n"),
                ]),
                child: Container(
                  width: 120,
                  height: 80,
                  color: Colors.amber,
                  alignment: Alignment.center,
                  child: const Text("Step 13 Target"),
                ),
              ),
            ],
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          _intro?.controller.start(context);
        },
        child: const Icon(Icons.play_arrow),
      ),
    );
  }
}
