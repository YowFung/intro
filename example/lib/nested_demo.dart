import 'package:flutter/material.dart';
import 'package:intro/intro.dart';

import 'block.dart';

final introCtrl1 = IntroController(stepCount: 5);
final introCtrl2 = IntroController(stepCount: 3);

class NestedDemoPage extends StatelessWidget {
  const NestedDemoPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Nested Usage")),
      floatingActionButton: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          ElevatedButton(
            onPressed: () => introCtrl1.start(context),
            child: const Text("Start Demo Flow 1"),
          ),
          const SizedBox(width: 20),
          ElevatedButton(
            onPressed: () => introCtrl2.start(context),
            child: const Text("Start Demo Flow 2"),
          ),
        ],
      ),
      body: Intro(
        controller: introCtrl1,
        cardDecoration: const IntroCardDecoration(
          showPreviousButton: false,
          tapBarrierToContinue: true,
          textStyle: TextStyle(
            color: Colors.lime,
            fontSize: 16,
          ),
          align: IntroCardAlign.outsideBottomLeft,
        ),
        highlightDecoration: IntroHighlightDecoration(
          border: Border.all(color: Colors.lime, width: 2),
        ),
        child: Intro(
          controller: introCtrl2,
          cardDecoration: const IntroCardDecoration(
            showPreviousButton: false,
            tapBarrierToContinue: true,
            textStyle: TextStyle(
              color: Colors.lightBlueAccent,
              fontSize: 16,
            ),
            align: IntroCardAlign.outsideBottomRight,
          ),
          highlightDecoration: IntroHighlightDecoration(
            border: Border.all(color: Colors.lightBlueAccent, width: 2),
          ),
          child: Container(
            alignment: Alignment.center,
            margin: const EdgeInsets.only(bottom: 150),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                IntroStepTarget(
                  step: 1,
                  controller: introCtrl1,
                  cardContents: TextSpan(
                    text: "Demo Flow 1\n"
                        "Step: 1/${introCtrl1.stepCount}",
                  ),
                  child: const Block(
                    label: "A",
                    color: Colors.pink,
                    size: Size(80, 80),
                  ),
                ),
                IntroStepTarget(
                  step: 2,
                  controller: introCtrl1,
                  cardContents: TextSpan(
                    text: "Demo Flow 1\n"
                        "Step: 2/${introCtrl1.stepCount}",
                  ),
                  child: IntroStepTarget(
                    step: 3,
                    controller: introCtrl2,
                    cardContents: TextSpan(
                      text: "Demo Flow 2\n"
                          "Step: 3/${introCtrl2.stepCount}",
                    ),
                    cardDecoration: const IntroCardDecoration(
                      showCloseButton: true,
                    ),
                    child: const Block(
                      label: "B",
                      color: Colors.orange,
                      size: Size(120, 120),
                    ),
                  ),
                ),
                IntroStepTarget(
                  step: 3,
                  controller: introCtrl1,
                  cardContents: TextSpan(
                    text: "Demo Flow 1\n"
                        "Step: 3/${introCtrl1.stepCount}",
                  ),
                  child: IntroStepTarget(
                    step: 2,
                    controller: introCtrl2,
                    cardContents: TextSpan(
                      text: "Demo Flow 2\n"
                          "Step: 2/${introCtrl2.stepCount}",
                    ),
                    child: const Block(
                      label: "C",
                      color: Colors.teal,
                      size: Size(60, 60),
                    ),
                  ),
                ),
                IntroStepTarget(
                  step: 4,
                  controller: introCtrl1,
                  cardContents: TextSpan(
                    text: "Demo Flow 1\n"
                        "Step: 4/${introCtrl1.stepCount}",
                  ),
                  child: IntroStepTarget(
                    step: 1,
                    controller: introCtrl2,
                    cardContents: TextSpan(
                      text: "Demo Flow 2\n"
                          "Step: 1/${introCtrl2.stepCount}",
                    ),
                    child: const Block(
                      label: "D",
                      color: Colors.black,
                      size: Size(100, 100),
                    ),
                  ),
                ),
                IntroStepTarget(
                  step: 5,
                  controller: introCtrl1,
                  cardContents: TextSpan(
                    text: "Demo Flow 1\n"
                        "Step: 5/${introCtrl1.stepCount}",
                  ),
                  cardDecoration: const IntroCardDecoration(
                    showCloseButton: true,
                  ),
                  child: const Block(
                    label: "E",
                    color: Colors.purple,
                    size: Size(120, 120),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
