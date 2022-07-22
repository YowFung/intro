part of intro;

class IntroStepTarget extends StatefulWidget {

  final int step;
  final IntroStepWillActivateCallback? onStepWillActivate;
  final IntroStepWillDeactivateCallback? onStepWillDeactivate;
  final IntroController controller;
  final Widget child;
  final IntroHighlightDecoration? highlightDecoration;
  final VoidCallback? onTargetTap;
  final VoidCallback? onTargetLoad;
  final VoidCallback? onTargetDispose;
  final IntroCardBuilder cardBuilder;
  final IntroCardDecoration? cardDecoration;

  IntroStepTarget({
    Key? key,
    required this.step,
    this.onStepWillActivate,
    this.onStepWillDeactivate,
    required this.controller,
    required TextSpan cardContents,
    this.cardDecoration,
    this.highlightDecoration,
    this.onTargetLoad,
    this.onTargetDispose,
    this.onTargetTap,
    required this.child,
  })
      : assert(step > 0 && step <= controller.stepCount,
          "The [step: $step] out of range 1..${controller.stepCount}"),
        cardBuilder = IntroStepCard._buildDefaultCard(cardContents),
        super(key: key);

  IntroStepTarget.custom({
    Key? key,
    required this.step,
    this.onStepWillActivate,
    this.onStepWillDeactivate,
    required this.controller,
    required this.cardBuilder,
    this.cardDecoration,
    this.highlightDecoration,
    this.onTargetLoad,
    this.onTargetDispose,
    this.onTargetTap,
    required this.child,
  })
      : assert(step > 0 && step <= controller.stepCount,
          "The [step: $step] out of range 1..${controller.stepCount}"),
        super(key: key);

  @override
  State<IntroStepTarget> createState() => _IntroStepTargetState();
}

class _IntroStepTargetState extends State<IntroStepTarget> with WidgetsBindingObserver {

  late Size _physicalSize;

  @override
  void initState() {
    super.initState();
    _physicalSize = WidgetsBinding.instance.window.physicalSize;
    WidgetsBinding.instance.addObserver(this);
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      widget.controller._setTarget(this);
      widget.onTargetLoad?.call();
    });
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    widget.onTargetDispose?.call();
    widget.controller._unsetTarget(this);
    super.dispose();
  }

  @override
  void didUpdateWidget(IntroStepTarget oldWidget) {
    super.didUpdateWidget(oldWidget);
    _updateTarget();
  }

  @override
  void didChangeMetrics() {
    final newSize = WidgetsBinding.instance.window.physicalSize;
    if (newSize != _physicalSize) {
      _physicalSize = newSize;
      _updateTarget();
    }
  }

  void _updateTarget() {
    widget.controller._setTarget(this);
    if (widget.controller._isOpened && widget.controller.currentStep == widget.step) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        widget.controller.refresh();
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      key: widget.controller.getStepKey(widget.step),
      child: widget.child,
    );
  }
}