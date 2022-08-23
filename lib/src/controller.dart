part of intro;

class _GradualOpacity extends StatefulWidget {
  final Duration duration;
  final double startOpacity;
  final double endOpacity;
  final VoidCallback? onAnimationFinished;
  final Widget child;

  _GradualOpacity({
    Key? key,
    required this.duration,
    this.startOpacity = 0.0,
    this.endOpacity = 1.0,
    required this.child,
    this.onAnimationFinished,
  })  : assert(startOpacity >= 0.0 && startOpacity <= 1.0),
        assert(endOpacity >= 0.0 && endOpacity <= 1.0),
        assert(!duration.isNegative),
        super(key: key);

  @override
  State<_GradualOpacity> createState() => _GradualOpacityState();
}

class _GradualOpacityState extends State<_GradualOpacity> {
  late double opacity;
  late Duration duration;

  @override
  void initState() {
    super.initState();
    opacity = widget.startOpacity;
    duration = widget.duration;
    if (widget.endOpacity != widget.startOpacity) {
      WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
        setState(() => opacity = widget.endOpacity);
      });
    }
  }

  @override
  void didUpdateWidget(_GradualOpacity oldWidget) {
    super.didUpdateWidget(oldWidget);
    setState(() {
      duration = Duration.zero;
      opacity = widget.startOpacity;
    });
    Future.delayed(widget.duration, () {
      if (mounted) {
        setState(() {
          duration = widget.duration;
          opacity = widget.endOpacity;
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedOpacity(
      opacity: opacity,
      duration: duration,
      onEnd: widget.onAnimationFinished,
      child: widget.child,
    );
  }
}

/// The controller of demo flow.
class IntroController {
  /// The total number of steps.
  final int stepCount;

  Intro? _intro;
  late final Map<int, GlobalKey> _keys;
  final Map<int, IntroParams> _targets = {};
  int _currentStep = 0;
  bool _isOpened = false;
  bool _opening = false;
  bool _closing = false;
  bool _switching = false;
  OverlayEntry? _overlayEntry;

  IntroController({
    required this.stepCount,
  }) {
    assert(stepCount > 0, "The [stepCount] argument must be greater than 0.");
    _keys = Map.fromEntries(List.generate(stepCount,
        (i) => MapEntry(i + 1, GlobalObjectKey("$hashCode-${i + 1}"))));
  }

  bool get mounted => stepCount > 0 && _keys.length == stepCount;

  /// The `Intro` instance it's attached to.
  Intro get intro {
    if (_intro == null) {
      throw IntroException("Can not get identity of this controller. "
          "Please check whether this controller is bound to the `Intro` widget.");
    }
    return _intro!;
  }

  /// Whether the demo flow is running.
  bool get isOpened => _isOpened;

  /// The code of current step.
  int get currentStep {
    assert(_debugAssertNotDisposed());
    return _currentStep;
  }

  /// Whether has next step.
  bool get hasNextStep {
    assert(_debugAssertNotDisposed());
    return currentStep < stepCount;
  }

  /// Whether has previous step.
  bool get hasPreviousStep {
    assert(_debugAssertNotDisposed());
    return currentStep > 1;
  }

  /// Whether the current step is the first step.
  bool get isFirstStep {
    assert(_debugAssertNotDisposed());
    return currentStep == 1;
  }

  /// Whether the current step is the last step.
  bool get isLastStep {
    assert(_debugAssertNotDisposed());
    return currentStep == stepCount;
  }

  /// The [GlobalKey] of the highlighted widget for this step.
  GlobalKey? get currentStepKey {
    assert(_debugAssertNotDisposed());
    return currentStep == 0 ? null : _keys[currentStep - 1];
  }

  bool _debugAssertNotDisposed() {
    assert(() {
      if (!mounted) {
        throw IntroException(
            "The instance of IntroController has been destroyed, "
            "you shouldn't call any method of it.");
      }
      return true;
    }());
    return true;
  }

  bool _debugAssertOpened() {
    assert(() {
      if (!_isOpened) {
        throw IntroException(
            "Please call [start] method to launch the introduction process first.");
      }
      return true;
    }());
    return true;
  }

  bool _debugAssertStepRange(int step) {
    assert(() {
      if (step <= 0 || step > stepCount) {
        throw IntroException(
            "The [step] value `$step` out of range [1..$stepCount].");
      }
      return true;
    }());
    return true;
  }

  /// Get the [GlobalKey] of the specified [step].
  GlobalKey getStepKey(int step) {
    assert(_debugAssertNotDisposed());
    if (!_keys.containsKey(step)) {
      throw IntroException("Make sure the [step] your given is valid. "
          "Note: the step range of this controller is [1..$stepCount].");
    }
    return _keys[step]!;
  }

  void _setTarget(_IntroStepTargetState target) {
    assert(_debugAssertNotDisposed());
    assert(identical(target.widget.controller, this));

    final step = target.widget.step;
    final context = getStepKey(step).currentContext;
    if (context == null) {
      throw IntroException(
        'The current context is null, because there is no widget in the tree that matches this step.'
        ' Please check your code. If you think you have encountered a bug, please let me know.',
      );
    }

    _targets[step] = IntroParams._(target);
  }

  void _unsetTarget(_IntroStepTargetState target) {
    assert(_debugAssertNotDisposed());
    assert(identical(target.widget.controller, this));

    final step = target.widget.step;
    _targets.remove(step);
  }

  void _onOverlayAnimationFinished() {
    if (_opening) {
      _opening = false;
    }
    if (_closing) {
      _closing = false;
      _isOpened = false;
      _overlayEntry?.remove();
      _overlayEntry = null;
      _currentStep = 0;
    }
  }

  IntroParams? _getCurrentStepParams() {
    if (_currentStep == 0) {
      return null;
    }

    final params = _targets[_currentStep];
    if (params == null) {
      throw IntroException(
          "Can not build introduction overlay for step `$_currentStep`. "
          "It means a [IntroStepTarget] widget using this step has not been rendered. "
          "Please check whether the `IntroStepTarget(step: $_currentStep)` widget has been created "
          "and make sure it has in the widget tree.");
    }
    return params;
  }

  Widget _buildOverlay(BuildContext context) {
    return _GradualOpacity(
      duration: intro.animationDuration,
      startOpacity: _opening ? 0.0 : 1.0,
      endOpacity: _closing ? 0.0 : 1.0,
      onAnimationFinished: _onOverlayAnimationFinished,
      child: MaterialApp(
        theme: ThemeData.dark(),
        home: Material(
          type: MaterialType.transparency,
          child: Stack(
            children: [
              _buildBorder(context),
              _buildHighlight(context),
              _buildCard(context),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildBorder(BuildContext context) {
    final params = _getCurrentStepParams();
    if (params == null) {
      return Container();
    }

    final widget = params._state.widget;
    final rect = params.highlightRect;
    final decoration =
        intro.highlightDecoration.mergeTo(widget.highlightDecoration);
    return AnimatedPositioned(
      duration: intro.animationDuration,
      left: rect.left,
      top: rect.top,
      width: rect.width,
      height: rect.height,
      child: AnimatedContainer(
        duration: intro.animationDuration,
        width: rect.width,
        height: rect.height,
        padding: decoration.padding,
        decoration: BoxDecoration(
          border: decoration.border,
          borderRadius: decoration.radius,
        ),
      ),
    );
  }

  Widget _buildHighlight(BuildContext context) {
    return ColorFiltered(
      colorFilter: ColorFilter.mode(
        intro.barrierColor,
        BlendMode.srcOut,
      ),
      child: Builder(
        builder: (context) {
          final params = _getCurrentStepParams();
          if (params == null) {
            return Container();
          }

          final rect = params.highlightRect;
          final widget = params._state.widget;
          final decoration =
              intro.highlightDecoration.mergeTo(widget.highlightDecoration);
          return Stack(
            children: [
              AnimatedPositioned(
                duration: intro.animationDuration,
                left: 0,
                right: 0,
                top: 0,
                bottom: 0,
                child: AnimatedContainer(
                  duration: intro.animationDuration,
                  decoration: const BoxDecoration(
                    color: Colors.white,
                    backgroundBlendMode: BlendMode.dstOut,
                  ),
                  child: GestureDetector(
                    onTap: () {
                      final decoration = _intro?.cardDecoration.mergeTo(
                          _getCurrentStepParams()
                              ?._state
                              .widget
                              .cardDecoration);
                      if (decoration?.tapBarrierToContinue == true) {
                        next();
                      }
                    },
                  ),
                ),
              ),
              AnimatedPositioned(
                duration: intro.animationDuration,
                left: rect.left,
                top: rect.top,
                width: rect.width,
                height: rect.height,
                child: MouseRegion(
                  cursor: decoration.cursor ?? MouseCursor.defer,
                  child: GestureDetector(
                    onTap: widget.onHighlightTap,
                    child: AnimatedContainer(
                      duration: intro.animationDuration,
                      width: rect.width,
                      height: rect.height,
                      decoration: BoxDecoration(
                        border: decoration.border,
                        borderRadius: decoration.radius,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
              ),
            ],
          );
        },
      ),
    );
  }

  Widget _buildCard(BuildContext context) {
    final params = _getCurrentStepParams();
    if (_closing || params == null) {
      return Container();
    }

    final widget = params._state.widget;
    final rect = params.cardRect;

    final screen = MediaQuery.of(context).size;
    final left = rect.left.isInfinite ? null : rect.left;
    final right = rect.right.isInfinite ? null : (screen.width - rect.right);
    final top = rect.top.isInfinite ? null : rect.top;
    final bottom =
        rect.bottom.isInfinite ? null : (screen.height - rect.bottom);

    final decoration = intro.cardDecoration
        .mergeTo(widget.cardDecoration)
        .mergeTo(IntroCardDecoration(align: params.actualCardAlign));
    return Positioned(
      left: left,
      right: right,
      top: top,
      bottom: bottom,
      child: _GradualOpacity(
        duration: intro.animationDuration,
        startOpacity: _switching ? 1.0 : 0.0,
        child: widget.cardBuilder(context, params, decoration),
      ),
    );
  }

  /// Destroy this demo flow.
  ///
  /// When it destroyed, it can never be used again.
  void dispose() {
    if (!mounted) return;

    close().then((_) {
      _keys.clear();
      _targets.clear();
      _opening = false;
      _closing = false;
      _switching = false;
    });
  }

  Future<void> _switchStep(int fromStep, int toStep,
      [bool needRefresh = true]) async {
    _switching = true;
    if (fromStep != 0) {
      await _targets[fromStep]
          ?._state
          .widget
          .onStepWillDeactivate
          ?.call(toStep);
    }
    if (toStep != 0) {
      await _targets[toStep]?._state.widget.onStepWillActivate?.call(fromStep);
    }
    _switching = false;

    if (needRefresh && _isOpened && _currentStep == fromStep) {
      _currentStep = toStep;
      refresh();
    }
  }

  /// Start this demo flow.
  ///
  /// It begin from step 1 by default. But you can specify the initial step through the [initStep].
  ///
  /// Note that the [context] you give must be the context of a widget after the [Intro] is defined.
  Future<void> start(
    BuildContext context, {
    int initStep = 1,
  }) async {
    assert(_debugAssertNotDisposed());
    assert(_debugAssertStepRange(initStep));

    if (_intro == null) {
      throw IntroException("Can not start this introduction. "
          "Please check whether this controller is bound to the `Intro` widget.");
    }

    if (_isOpened) {
      if (initStep != _currentStep) {
        jumpTo(initStep);
      }
      return;
    }

    assert(_currentStep == 0);
    _isOpened = true;
    _opening = true;
    await _switchStep(0, initStep, false);
    _currentStep = initStep;

    _overlayEntry = OverlayEntry(builder: _buildOverlay);
    await Future(() => Overlay.of(context)!.insert(_overlayEntry!));
  }

  /// Close the demo flow.
  Future<void> close() async {
    assert(_debugAssertNotDisposed());
    if (!_isOpened) return;

    await _switchStep(_currentStep, 0, false);
    _closing = true;
    refresh();
  }

  /// Jump this demo flow to the [step].
  Future<void> jumpTo(int step) async {
    assert(_debugAssertNotDisposed());
    assert(_debugAssertOpened());
    assert(_debugAssertStepRange(step));

    if (step == _currentStep) return;
    await _switchStep(_currentStep, step);
  }

  /// Jump this demo flow to next step.
  ///
  /// It's equivalent to [close] if called at the last step.
  Future<void> next() async {
    assert(_debugAssertNotDisposed());
    assert(_debugAssertOpened());

    if (isLastStep) {
      return close();
    }

    await _switchStep(_currentStep, _currentStep + 1);
  }

  /// Jump this demo flow to previous step if not at the first step.
  Future<void> previous() async {
    assert(_debugAssertNotDisposed());
    assert(_debugAssertOpened());

    if (isFirstStep) return;
    await _switchStep(_currentStep, _currentStep - 1);
  }

  void refresh() {
    assert(_debugAssertNotDisposed());
    assert(_debugAssertOpened());
    _overlayEntry?.markNeedsBuild();
  }
}
