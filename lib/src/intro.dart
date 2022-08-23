part of intro;

typedef TopLayerBuilder = Widget Function(BuildContext, IntroController);

/// Demo flow widget.
///
/// Please register this widget at the earliest possible widget tree node.
class Intro extends InheritedWidget {
  static Intro of(BuildContext context) {
    final instance = context.dependOnInheritedWidgetOfExactType<Intro>();
    if (instance == null) {
      throw IntroException("Can't get instance of Intro. "
          "Make sure you have defined a `Intro` widget in the widget tree "
          "before the widget related to this context.");
    }
    return instance;
  }

  static const _defaultBarrierColor = Color(0xC6000000);

  static const _defaultAnimationDuration = Duration(milliseconds: 300);

  static const _defaultHighlightDecoration = IntroHighlightDecoration(
    padding: EdgeInsets.all(2),
    border: Border.fromBorderSide(BorderSide(
      color: Colors.white,
      width: 2.0,
    )),
    radius: BorderRadius.all(Radius.circular(5)),
  );

  static const _defaultCardDecoration = IntroCardDecoration(
    margin: EdgeInsets.all(10),
    radius: BorderRadius.all(Radius.circular(5)),
    textStyle: TextStyle(
      color: Color(0xDCFFFFFF),
      fontSize: 16.0,
      height: 1.2,
    ),
  );

  /// The controller of this demo flow.
  final IntroController controller;

  final Color barrierColor;
  final Duration animationDuration;
  final IntroHighlightDecoration highlightDecoration;
  final IntroCardDecoration cardDecoration;
  final TopLayerBuilder? topLayerBuilder;

  Intro({
    Key? key,
    required Widget child,
    required this.controller,
    Color? barrierColor,
    this.topLayerBuilder,
    Duration? animationDuration,
    IntroHighlightDecoration? highlightDecoration,
    IntroCardDecoration? cardDecoration,
  })  : assert(animationDuration == null || !animationDuration.isNegative),
        barrierColor = barrierColor ?? _defaultBarrierColor,
        animationDuration = animationDuration ?? _defaultAnimationDuration,
        highlightDecoration =
            _defaultHighlightDecoration.mergeTo(highlightDecoration),
        cardDecoration = _defaultCardDecoration.mergeTo(cardDecoration),
        super(key: key, child: child) {
    controller._intro = this;
  }

  @override
  bool updateShouldNotify(covariant InheritedWidget oldWidget) =>
      child != oldWidget.child;

  void dispose() {
    controller.dispose();
    controller._intro = null;
  }
}
