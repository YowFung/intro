import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:intro/intro.dart';

class NestedDemoPage extends StatefulWidget {
  const NestedDemoPage({Key? key}) : super(key: key);

  @override
  State<NestedDemoPage> createState() => _NestedDemoPageState();
}

class _NestedDemoPageState extends State<NestedDemoPage> {
  final introCtrl1 = IntroController(stepCount: 5);
  final introCtrl2 = IntroController(stepCount: 3);

  @override
  void dispose() {
    super.dispose();
    introCtrl1.dispose();
    introCtrl2.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Nested Usage")),
      body: Intro(
        controller: introCtrl1,
        cardDecoration: const IntroCardDecoration(
          showPreviousButton: false,
          showCloseButton: false,
          textStyle: TextStyle(
            color: Colors.lime,
            fontSize: 16,
          ),
          align: IntroCardAlign.outsideTopLeft,
        ),
        highlightDecoration: IntroHighlightDecoration(
          border: Border.all(color: Colors.lime, width: 2),
        ),
        child: Intro(
          controller: introCtrl2,
          cardDecoration: const IntroCardDecoration(
            showPreviousButton: false,
            showCloseButton: false,
            textStyle: TextStyle(
              color: Colors.lightBlueAccent,
              fontSize: 16,
            ),
            align: IntroCardAlign.outsideTopRight,
          ),
          highlightDecoration: IntroHighlightDecoration(
            border: Border.all(color: Colors.lightBlueAccent, width: 2),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.all(20),
                child: Text.rich(TextSpan(children: [
                  const TextSpan(
                    text: "You can define multiple [Intro] widgets, "
                        "and each one uses a separate [IntroController].\n\n"
                        "Note:\n"
                        "1. The same target widget may be used in different presentation processes.\n"
                        "2. The same target widget can define different introduction card in different presentation flows.\n"
                        "3. Each presentation flow is controlled through its own [IntroController].\n\n"
                        "Presentation Flow 1: \n[ ",
                  ),
                  TextSpan(
                    text: "Start",
                    recognizer: TapGestureRecognizer()
                      ..onTap = () => introCtrl1.start(context),
                    style: const TextStyle(
                      color: Colors.blue,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const TextSpan(text: " ]\n\nPresentation Flow 2: \n[ "),
                  TextSpan(
                    text: "Start",
                    recognizer: TapGestureRecognizer()
                      ..onTap = () => introCtrl2.start(context),
                    style: const TextStyle(
                      color: Colors.blue,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const TextSpan(text: " ]"),
                ])),
              ),
              const Divider(),
              Expanded(
                child: Container(
                  color: Colors.black12,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      IntroStepTarget(
                        step: 1,
                        controller: introCtrl1,
                        cardContents: TextSpan(
                          text: "Presentation Flow 1\n\n"
                              "Step: 1/${introCtrl1.stepCount}",
                        ),
                        child: const Block(
                          label: "A",
                          color: Colors.pink,
                        ),
                      ),
                      IntroStepTarget(
                        step: 2,
                        controller: introCtrl1,
                        cardContents: TextSpan(
                          text: "Presentation Flow 1\n\n"
                              "Step: 2/${introCtrl1.stepCount}",
                        ),
                        child: IntroStepTarget(
                          step: 3,
                          controller: introCtrl2,
                          cardContents: TextSpan(
                            text: "Presentation Flow 2\n\n"
                                "Step: 3/${introCtrl2.stepCount}",
                          ),
                          cardDecoration: const IntroCardDecoration(
                            showCloseButton: true,
                          ),
                          child: const Block(
                            label: "B",
                            color: Colors.orange,
                          ),
                        ),
                      ),
                      IntroStepTarget(
                        step: 3,
                        controller: introCtrl1,
                        cardContents: TextSpan(
                          text: "Presentation Flow 1\n\n"
                              "Step: 3/${introCtrl1.stepCount}",
                        ),
                        child: IntroStepTarget(
                          step: 2,
                          controller: introCtrl2,
                          cardContents: TextSpan(
                            text: "Presentation Flow 2\n\n"
                                "Step: 2/${introCtrl2.stepCount}",
                          ),
                          child: const Block(
                            label: "C",
                            color: Colors.teal,
                          ),
                        ),
                      ),
                      IntroStepTarget(
                        step: 4,
                        controller: introCtrl1,
                        cardContents: TextSpan(
                          text: "Presentation Flow 1\n\n"
                              "Step: 4/${introCtrl1.stepCount}",
                        ),
                        child: IntroStepTarget(
                          step: 1,
                          controller: introCtrl2,
                          cardContents: TextSpan(
                            text: "Presentation Flow 2\n\n"
                                "Step: 1/${introCtrl2.stepCount}",
                          ),
                          child: const Block(
                            label: "D",
                            color: Colors.black,
                          ),
                        ),
                      ),
                      IntroStepTarget(
                        step: 5,
                        controller: introCtrl1,
                        cardContents: TextSpan(
                          text: "Presentation Flow 1\n\n"
                              "Step: 5/${introCtrl1.stepCount}",
                        ),
                        cardDecoration: const IntroCardDecoration(
                          showCloseButton: true,
                        ),
                        child: const Block(
                          label: "E",
                          color: Colors.purple,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class Block extends StatelessWidget {
  final String label;
  final Color color;

  const Block({
    Key? key,
    required this.label,
    required this.color,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 80,
      height: 80,
      color: color,
      alignment: Alignment.center,
      child: Text(label,
          style: const TextStyle(fontSize: 30, color: Colors.white)),
    );
  }
}
