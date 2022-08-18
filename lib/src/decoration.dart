part of intro;

/// The decoration for highlighted widget.
class IntroHighlightDecoration {
  /// Specify the border of highlighted widget.
  final Border? border;

  /// Specify the border radius of highlighted widget.
  final BorderRadiusGeometry? radius;

  /// Specify that the highlighted widget exceeds the margin of the target widget.
  final EdgeInsets? padding;

  /// Specify the mouse cursor that moving on the highlighted widget.
  final MouseCursor? cursor;

  const IntroHighlightDecoration({
    this.border,
    this.radius,
    this.padding,
    this.cursor,
  });

  /// Returns a new decoration that is a combination of this decoration
  /// and the given [other] decoration.
  ///
  /// The null properties of the given [other] decoration are replaced
  /// with the non-null properties of this decoration.
  IntroHighlightDecoration mergeTo(IntroHighlightDecoration? other) {
    if (other == null) {
      return this;
    }

    return IntroHighlightDecoration(
      border: other.border ?? border,
      radius: other.radius ?? radius,
      padding: other.padding ?? padding,
      cursor: other.cursor ?? cursor,
    );
  }
}

/// The decoration for intro card.
class IntroCardDecoration {
  /// Specify the alignment of intro card widget relative to highlighted widget.
  ///
  /// By default, it automatically estimates where the intro card should be displayed
  /// based on the location and size of the target widget.
  final IntroCardAlign? align;

  /// Specify the size of intro card.
  final Size? size;

  /// Specify the distance between the intro card and the highlighted widget.
  final EdgeInsets? margin;

  /// Specify the padding of contents of intro card.
  final EdgeInsets? padding;

  /// Specify the border of intro card.
  final Border? border;

  /// Specify the border radius of intro card.
  final BorderRadiusGeometry? radius;

  /// Specify the background color of intro card.
  final Color? backgroundColor;

  /// Specify the contents style of intro card.
  final TextStyle? textStyle;

  /// Whether to display the previous button.
  final bool? showPreviousButton;

  /// Whether to display the next button.
  final bool? showNextButton;

  /// Whether to display the close button.
  ///
  /// If it's null, the close button will be displayed at the last step and be hidden at other step.
  final bool? showCloseButton;

  /// Specify the label of previous button.
  final String? previousButtonLabel;

  /// Specify the label of next button.
  final String? nextButtonLabel;

  /// Specify the label of close button.
  final String? closeButtonLabel;

  /// Whether to hide disabled buttons automatically.
  ///
  /// When it set to `true`, the previous button is not be displayed in the first step
  /// because no step can be back, and the next button is also not be displayed in the
  /// last step because no step can to continue.
  final bool? autoHideDisabledButtons;

  /// Specify the style of previous button.
  final ButtonStyle? previousButtonStyle;

  /// Specify the style of next button.
  final ButtonStyle? nextButtonStyle;

  /// Specify the style of close button.
  final ButtonStyle? closeButtonStyle;

  /// Whether can be continue when tap the mask area.
  final bool? tapBarrierToContinue;

  const IntroCardDecoration({
    this.align,
    this.size,
    this.margin,
    this.padding,
    this.border,
    this.radius,
    this.backgroundColor,
    this.textStyle,
    this.showPreviousButton,
    this.showNextButton,
    this.showCloseButton,
    this.previousButtonLabel,
    this.nextButtonLabel,
    this.closeButtonLabel,
    this.autoHideDisabledButtons,
    this.previousButtonStyle,
    this.nextButtonStyle,
    this.closeButtonStyle,
    this.tapBarrierToContinue,
  });

  /// Returns a new decoration that is a combination of this decoration
  /// and the given [other] decoration.
  ///
  /// The null properties of the given [other] decoration are replaced
  /// with the non-null properties of this decoration.
  IntroCardDecoration mergeTo(IntroCardDecoration? other) {
    if (other == null) {
      return this;
    }

    return IntroCardDecoration(
      align: other.align ?? align,
      size: other.size ?? size,
      margin: other.margin ?? margin,
      padding: other.padding ?? padding,
      border: other.border ?? border,
      radius: other.radius ?? radius,
      backgroundColor: other.backgroundColor ?? backgroundColor,
      textStyle: textStyle?.merge(other.textStyle) ?? other.textStyle,
      showPreviousButton: other.showPreviousButton ?? showPreviousButton,
      showNextButton: other.showNextButton ?? showNextButton,
      showCloseButton: other.showCloseButton ?? showCloseButton,
      previousButtonLabel: other.previousButtonLabel ?? previousButtonLabel,
      nextButtonLabel: other.nextButtonLabel ?? nextButtonLabel,
      closeButtonLabel: other.closeButtonLabel ?? closeButtonLabel,
      autoHideDisabledButtons:
          other.autoHideDisabledButtons ?? autoHideDisabledButtons,
      previousButtonStyle:
          other.previousButtonStyle?.merge(previousButtonStyle) ??
              previousButtonStyle,
      nextButtonStyle:
          other.nextButtonStyle?.merge(nextButtonStyle) ?? nextButtonStyle,
      closeButtonStyle:
          other.closeButtonStyle?.merge(closeButtonStyle) ?? closeButtonStyle,
      tapBarrierToContinue: other.tapBarrierToContinue ?? tapBarrierToContinue,
    );
  }
}
