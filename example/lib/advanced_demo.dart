import 'package:flutter/material.dart';
import 'package:intro/intro.dart';

class AdvancedDemoPage extends StatefulWidget {
  const AdvancedDemoPage({Key? key}) : super(key: key);

  @override
  State<AdvancedDemoPage> createState() => _AdvancedDemoPageState();
}

class _AdvancedDemoPageState extends State<AdvancedDemoPage> {
  final introCtrl = IntroController(stepCount: 6);

  @override
  void dispose() {
    super.dispose();
    introCtrl.dispose();
  }

  Widget _newPageBuilder(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("New Page")),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(Icons.face, size: 80, color: Colors.teal),
            const SizedBox(height: 20),
            IntroStepTarget(
              step: 2,
              controller: introCtrl,
              cardContents: TextSpan(
                text: "Step: 2/${introCtrl.stepCount}\n\n"
                    "Now you are in a new page.\n"
                    "Please tap the highlight area to back to\nthe previous page and continue next step.",
              ),
              onTargetTap: introCtrl.next,
              onStepWillDeactivate: (willToStep) {
                if (willToStep == 3) {
                  Navigator.pop(context);
                }
              },
              child: ElevatedButton(
                onPressed: () async {
                  Navigator.pop(context);
                  await Future.delayed(const Duration(milliseconds: 300),
                      () async {
                    await introCtrl.start(context, initStep: 3);
                  });
                },
                child: const Text("Continue"),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _dialogBuilder(BuildContext context) {
    return Material(
      type: MaterialType.transparency,
      child: Center(
        child: IntroStepTarget(
          step: 4,
          controller: introCtrl,
          cardContents: TextSpan(
            text: "Step: 4/${introCtrl.stepCount}\n\n"
                "Notice that you now in a dialog and the currently\n"
                "highlighted area is within this dialog.",
          ),
          highlightDecoration: const IntroHighlightDecoration(
            cursor: MouseCursor.defer,
          ),
          onStepWillDeactivate: (willToStep) {
            if (willToStep == 3) {
              Navigator.pop(context);
            }
          },
          child: Container(
            width: 320,
            height: 200,
            decoration: BoxDecoration(
              color: Colors.white,
              border: Border.all(
                color: Colors.black54,
              ),
              borderRadius: BorderRadius.circular(5),
            ),
            child: Column(
              children: [
                const Expanded(
                  child: Center(
                    child: Text(
                      "Do you need to continue?",
                      style: TextStyle(
                        color: Colors.pink,
                        fontSize: 16.0,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
                const Divider(height: 2),
                SizedBox(
                  height: 40,
                  child: Row(
                    children: [
                      Expanded(
                        child: MaterialButton(
                          height: double.infinity,
                          onPressed: () async {
                            Navigator.pop(context);
                          },
                          textColor: Colors.black54,
                          shape: const RoundedRectangleBorder(
                            borderRadius: BorderRadius.only(
                              bottomLeft: Radius.circular(5),
                            ),
                          ),
                          child: const Text("Cancel"),
                        ),
                      ),
                      const VerticalDivider(width: 2),
                      Expanded(
                        child: IntroStepTarget(
                          step: 5,
                          controller: introCtrl,
                          cardContents: TextSpan(
                            text: "Step: 5/${introCtrl.stepCount}\n\n"
                                "Tap the [OK] button to close this dialog and continue next.",
                          ),
                          onStepWillDeactivate: (willToStep) {
                            if (willToStep == 6) {
                              Navigator.pop(context);
                            }
                          },
                          onTargetTap: introCtrl.next,
                          child: MaterialButton(
                            height: double.infinity,
                            onPressed: () async {
                              await introCtrl.start(context, initStep: 5);
                              await introCtrl.next();
                            },
                            textColor: Colors.blue,
                            shape: const RoundedRectangleBorder(
                              borderRadius: BorderRadius.only(
                                bottomRight: Radius.circular(5),
                              ),
                            ),
                            child: const Text("OK"),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Intro(
      controller: introCtrl,
      cardDecoration: IntroCardDecoration(
        align: IntroCardAlign.outsideBottomLeft,
        showPreviousButton: false,
        nextButtonStyle: ButtonStyle(
          shape: MaterialStateProperty.resolveWith(
              (states) => const RoundedRectangleBorder()),
          backgroundColor:
              MaterialStateColor.resolveWith((states) => Colors.cyan),
        ),
        closeButtonStyle: ButtonStyle(
          shape: MaterialStateProperty.resolveWith(
              (states) => const RoundedRectangleBorder()),
          backgroundColor:
              MaterialStateColor.resolveWith((states) => Colors.pink),
        ),
        textStyle: const TextStyle(
          color: Colors.white,
          fontSize: 16.0,
        ),
      ),
      highlightDecoration: IntroHighlightDecoration(
        cursor: SystemMouseCursors.click,
        radius: BorderRadius.circular(5),
        padding: const EdgeInsets.all(2),
      ),
      child: Scaffold(
        appBar: AppBar(title: const Text("Advanced Usage")),
        body: Center(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              IntroStepTarget(
                step: 1,
                controller: introCtrl,
                cardContents: TextSpan(
                  text: "Step: 1/${introCtrl.stepCount}\n\n"
                      "Tap the highlight area to open a new page and continue next step.",
                ),
                onTargetLoad: () {
                  Future.delayed(const Duration(milliseconds: 500), () {
                    introCtrl.start(context);
                  });
                },
                onTargetTap: introCtrl.next,
                onStepWillDeactivate: (willToStep) async {
                  if (willToStep == 2) {
                    Navigator.push(
                        context, MaterialPageRoute(builder: _newPageBuilder));
                    await Future.delayed(const Duration(milliseconds: 50));
                  }
                },
                child: ElevatedButton(
                  onPressed: () async {
                    await introCtrl.start(context, initStep: 1);
                    await introCtrl.next();
                  },
                  child: const Text("Open Page"),
                ),
              ),
              const SizedBox(width: 20),
              IntroStepTarget(
                step: 3,
                controller: introCtrl,
                cardContents: TextSpan(
                  text: "Step: 3/${introCtrl.stepCount}\n\n"
                      "Tap the highlight area to open a dialog and continue next step.",
                ),
                onTargetTap: introCtrl.next,
                onStepWillDeactivate: (willToStep) async {
                  if (willToStep == 4) {
                    showDialog(
                      context: context,
                      barrierDismissible: false,
                      barrierColor: Colors.black54,
                      builder: _dialogBuilder,
                    );
                    await Future.delayed(const Duration(milliseconds: 50));
                  }
                },
                child: ElevatedButton(
                  onPressed: () async {
                    await introCtrl.start(context, initStep: 3);
                    await introCtrl.next();
                  },
                  child: const Text("Open Dialog"),
                ),
              ),
              const SizedBox(width: 20),
              IntroStepTarget(
                step: 6,
                controller: introCtrl,
                cardContents: TextSpan(
                  text: "Step: 6/${introCtrl.stepCount}\n\n"
                      "This is the last step.\nPlease exit this page.",
                ),
                highlightDecoration: const IntroHighlightDecoration(
                  cursor: MouseCursor.defer,
                ),
                child: const Icon(Icons.check_circle,
                    size: 30, color: Colors.green),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
