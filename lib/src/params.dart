part of intro;

/// Describes the alignment of introduction card widget relative to highlighted widget.
enum IntroCardAlign {
  /// The card widget is aligned to the top left corner inside the target widget.
  insideTopLeft,

  /// The card widget is aligned to the top right corner inside the target widget.
  insideTopRight,

  /// The card widget is aligned to the bottom left corner inside the target widget.
  insideBottomLeft,

  /// The card widget is aligned to the bottom right corner inside the target widget.
  insideBottomRight,

  /// The card widget is located to the left of the top of the target widget.
  outsideTopLeft,

  /// The card widget is located to the right of the top of the target widget.
  outsideTopRight,

  /// The card widget is located to the left of the bottom of the target widget.
  outsideBottomLeft,

  /// The card widget is located to the right of the bottom of the target widget.
  outsideBottomRight,

  /// The card widget is located to the top of the left of the target widget.
  outsideLeftTop,

  /// The card widget is located to the bottom of the left of the target widget.
  outsideLeftBottom,

  /// The card widget is located to the top of the right of the target widget.
  outsideRightTop,

  /// The card widget is located to the bottom of the right of the target widget.
  outsideRightBottom,
}

/// Parameters about a step.
class IntroParams {
  final _IntroStepTargetState _state;
  IntroCardAlign? _cardAlign;

  IntroParams._(this._state);

  /// Step of this params.
  int get step => _state.widget.step;

  /// [IntroController] of this step.
  IntroController get controller => _state.widget.controller;

  /// [BuildContext] of [IntroStepTarget] widget of this step.
  BuildContext get context => controller.getStepKey(step).currentContext!;

  /// Geometry of the target widget (child of [IntroStepTarget]) for this step.
  Rect get targetRect {
    final box = context.findRenderObject() as RenderBox;
    final offset = box.localToGlobal(Offset.zero);
    final size = box.size;
    return Rect.fromPoints(offset, size.bottomRight(offset));
  }

  /// Geometry of highlighted area (the hole above the target widget) for this step.
  Rect get highlightRect {
    final rect = targetRect;
    final padding = _state.widget.highlightDecoration?.padding ??
        controller.intro._highlightDecoration.padding ??
        EdgeInsets.zero;
    final startPoint = rect.topLeft - Offset(padding.left, padding.top);
    final endPoint = rect.bottomRight + Offset(padding.right, padding.bottom);
    return Rect.fromPoints(startPoint, endPoint);
  }

  /// Geometry of the introduction card widget for this step.
  Rect get cardRect {
    final highlight = highlightRect;
    final screen = _state._physicalSize;
    final margin = _state.widget.cardDecoration?.margin ??
        controller.intro._cardDecoration.margin ??
        const EdgeInsets.all(10);
    var align = _state.widget.cardDecoration?.align ??
        controller.intro._cardDecoration.align;

    final mLeft = margin.left;
    final mRight = margin.right;
    final mTop = margin.top;
    final mBottom = margin.bottom;

    final hLeft = highlight.left;
    final hRight = highlight.right;
    final hTop = highlight.top;
    final hBottom = highlight.bottom;

    if (align == null) {
      final leftBlank = hLeft;
      final topBlank = hTop;
      final rightBlank = screen.width - hRight;
      final bottomBlank = screen.height - hBottom;
      const minimum = 120.0;
      if (leftBlank < minimum &&
          topBlank < minimum &&
          rightBlank < minimum &&
          bottomBlank < minimum) {
        align = IntroCardAlign.insideTopLeft;
      } else {
        final hWidth = highlight.width;
        final hHeight = highlight.height;
        final areaMap = {
          IntroCardAlign.outsideTopLeft: topBlank * (hWidth + rightBlank),
          IntroCardAlign.outsideTopRight: topBlank * (leftBlank + hWidth),
          IntroCardAlign.outsideBottomLeft: bottomBlank * (hWidth + rightBlank),
          IntroCardAlign.outsideBottomRight: bottomBlank * (leftBlank + hWidth),
          IntroCardAlign.outsideLeftTop: leftBlank * (hHeight + bottomBlank),
          IntroCardAlign.outsideLeftBottom: leftBlank * (topBlank + hHeight),
          IntroCardAlign.outsideRightTop: rightBlank * (hHeight + bottomBlank),
          IntroCardAlign.outsideRightBottom: rightBlank * (topBlank + hHeight),
        };
        final sortedKey = areaMap.keys.toList()
          ..sort((k1, k2) => areaMap[k1]!.compareTo(areaMap[k2]!));
        align = sortedKey.last;
        _cardAlign = align;
      }
    }

    buildRect({double? left, double? right, double? top, double? bottom}) {
      assert(left != null || right != null);
      assert(top != null || bottom != null);
      return Rect.fromLTRB(
          left ?? double.negativeInfinity,
          top ?? double.negativeInfinity,
          right ?? double.infinity,
          bottom ?? double.infinity);
    }

    switch (align) {
      case IntroCardAlign.insideTopLeft:
        return buildRect(top: hTop + mTop, left: hLeft + mLeft);
      case IntroCardAlign.insideTopRight:
        return buildRect(top: hTop + mTop, right: hRight - mRight);
      case IntroCardAlign.insideBottomLeft:
        return buildRect(bottom: hBottom - mBottom, left: hLeft + mLeft);
      case IntroCardAlign.insideBottomRight:
        return buildRect(bottom: hBottom - mBottom, right: hRight - mRight);
      case IntroCardAlign.outsideTopLeft:
        return buildRect(bottom: hTop - mBottom, left: hLeft);
      case IntroCardAlign.outsideTopRight:
        return buildRect(bottom: hTop - mBottom, right: hRight);
      case IntroCardAlign.outsideBottomLeft:
        return buildRect(top: hBottom + mTop, left: hLeft);
      case IntroCardAlign.outsideBottomRight:
        return buildRect(top: hBottom + mTop, right: hRight);
      case IntroCardAlign.outsideLeftTop:
        return buildRect(right: hLeft - mRight, top: hTop);
      case IntroCardAlign.outsideLeftBottom:
        return buildRect(right: hLeft - mRight, bottom: hBottom);
      case IntroCardAlign.outsideRightTop:
        return buildRect(left: hRight + mLeft, top: hTop);
      case IntroCardAlign.outsideRightBottom:
        return buildRect(left: hRight + mLeft, bottom: hBottom);
    }
  }

  /// The final alignment of introduction card widget relative to highlighted widget.
  ///
  /// If you don't give it when you build the [IntroStepTarget] or [IntroApp],
  /// it will be computed automatically after you access the [cardRect] attribute.
  IntroCardAlign? get actualCardAlign =>
      _state.widget.cardDecoration?.align ??
      controller.intro._cardDecoration.align ??
      _cardAlign;

  @override
  String toString() {
    rect2Str(Rect rect) {
      final left = rect.left.toStringAsFixed(1);
      final top = rect.top.toStringAsFixed(1);
      final right = rect.right.toStringAsFixed(1);
      final bottom = rect.bottom.toStringAsFixed(1);
      final width = rect.width.toStringAsFixed(0);
      final height = rect.height.toStringAsFixed(0);
      return "(L=$left, T=$top, R=$right, B=$bottom; $width×$height)";
    }

    return "$runtimeType { step: $step, target rect: ${rect2Str(targetRect)}, "
        "highlight rect: ${rect2Str(highlightRect)}, card rect: ${rect2Str(cardRect)}, "
        "actual card alignment: ${actualCardAlign?.name} }";
  }
}
