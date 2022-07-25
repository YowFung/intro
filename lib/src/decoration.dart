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

class IntroCardDecoration {
  final IntroCardAlign? align;

  final Size? size;

  final EdgeInsets? margin;

  final EdgeInsets? padding;

  final Border? border;

  final BorderRadiusGeometry? radius;

  final Color? backgroundColor;

  final TextStyle? textStyle;

  final bool? showPreviousButton;

  final bool? showNextButton;

  final bool? showCloseButton;

  final String? previousButtonLabel;

  final String? nextButtonLabel;

  final String? closeButtonLabel;

  final bool? autoHideDisabledButton;

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
    this.showPreviousButton,
    this.showNextButton,
    this.showCloseButton,
    this.previousButtonLabel,
    this.nextButtonLabel,
    this.closeButtonLabel,
    this.autoHideDisabledButton = true,
    this.previousButtonStyle,
    this.nextButtonStyle,
    this.closeButtonStyle,
  });

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
      textStyle: other.textStyle?.merge(textStyle) ?? textStyle,
      showPreviousButton: other.showPreviousButton ?? showPreviousButton,
      showNextButton: other.showNextButton ?? showNextButton,
      showCloseButton: other.showCloseButton ?? showCloseButton,
      previousButtonLabel: other.previousButtonLabel ?? previousButtonLabel,
      nextButtonLabel: other.nextButtonLabel ?? nextButtonLabel,
      closeButtonLabel: other.closeButtonLabel ?? closeButtonLabel,
      autoHideDisabledButton:
          other.autoHideDisabledButton ?? autoHideDisabledButton,
      previousButtonStyle:
          other.previousButtonStyle?.merge(previousButtonStyle) ??
              previousButtonStyle,
      nextButtonStyle:
          other.nextButtonStyle?.merge(nextButtonStyle) ?? nextButtonStyle,
      closeButtonStyle:
          other.closeButtonStyle?.merge(closeButtonStyle) ?? closeButtonStyle,
    );
  }
}
