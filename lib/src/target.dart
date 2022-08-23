part of intro;

/// A widget that wraps the target widget for a step.
class IntroStepTarget extends StatefulWidget {
  /// The code of target step.
  final int step;

  /// The controller of this demo flow.
  final IntroController controller;

  /// The target widget will be warped.
  final Widget child;

  /// A builder to build the intro card widget.
  final IntroCardBuilder cardBuilder;

  /// Decoration for highlighted widget.
  final IntroHighlightDecoration? highlightDecoration;

  /// Decoration for intro card.
  final IntroCardDecoration? cardDecoration;

  /// A callback that will be called when the demo flow reaches the current step.
  ///
  /// The current step is finally activated only when this callback execution is complete.
  ///
  /// The `fromStep` tells you from which step it jumped to the current step.
  /// In particular, the value of `fromStep` is '0' means that this is the beginning.
  final IntroStepWillActivateCallback? onStepWillActivate;

  /// A callback that will be called when the demo flow leaves the current step.
  ///
  /// The current step is finally deactivated only when this callback execution is complete.
  ///
  /// The `willToStep` tells you which step it will to jump to.
  /// In particular, the value of `willToStep` is '0' means that this is the ending.
  final IntroStepWillDeactivateCallback? onStepWillDeactivate;

  /// It will be called when tap the highlighted widget.
  final VoidCallback? onHighlightTap;

  /// It will be called when the target widget was built.
  final VoidCallback? onTargetLoad;

  /// It will be called when the target widget was disposed.
  final VoidCallback? onTargetDispose;

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
    this.onHighlightTap,
    required this.child,
  })  : assert(step > 0 && step <= controller.stepCount,
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
    this.onHighlightTap,
    required this.child,
  })  : assert(step > 0 && step <= controller.stepCount,
            "The [step: $step] out of range 1..${controller.stepCount}"),
        super(key: key);

  @override
  State<IntroStepTarget> createState() => _IntroStepTargetState();
}

class _IntroStepTargetState extends State<IntroStepTarget>
    with WidgetsBindingObserver {

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      widget.controller._setTarget(this);
      widget.onTargetLoad?.call();
    });
  }

  @override
  void dispose() {
    widget.onTargetDispose?.call();
    WidgetsBinding.instance.removeObserver(this);
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
    _updateTarget();
  }

  void _updateTarget() {
    widget.controller._setTarget(this);
    if (widget.controller._isOpened &&
        widget.controller.currentStep == widget.step) {
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
