part of intro;

class IntroHighlightDecoration {
  final Border? border;

  final BorderRadiusGeometry? radius;

  final EdgeInsets? padding;

  final MouseCursor? cursor;

  const IntroHighlightDecoration({
    this.border,
    this.radius,
    this.padding,
    this.cursor,
  });
}

class IntroCardDecoration {
  final IntroCardAlign? align;

  final Size? size;

  final EdgeInsets? margin;

  final EdgeInsets? padding;

  final Border? border;

  final BorderRadiusGeometry? radius;

  final Color? backgroundColor;

  final TextStyle? textStyle;

  final bool showPreviousButton;

  final bool showNextButton;

  final bool showCloseButton;

  final String previousButtonLabel;

  final String nextButtonLabel;

  final String nextButtonFinishLabel;

  final String closeButtonLabel;

  final bool autoHideDisabledButton;

  final ButtonStyle? previousButtonStyle;

  final ButtonStyle? nextButtonStyle;

  final ButtonStyle? closeButtonStyle;

  const IntroCardDecoration({
    this.align,
    this.size,
    this.margin,
    this.padding,
    this.border,
    this.radius,
    this.backgroundColor,
    this.textStyle,
    this.showPreviousButton = false,
    this.showNextButton = true,
    this.showCloseButton = false,
    this.previousButtonLabel = "Previous",
    this.nextButtonLabel = "Next",
    this.nextButtonFinishLabel = "Finish",
    this.closeButtonLabel = "Close",
    this.autoHideDisabledButton = true,
    this.previousButtonStyle,
    this.nextButtonStyle,
    this.closeButtonStyle,
  });
}
