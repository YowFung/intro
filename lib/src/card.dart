part of intro;

class IntroStepCard extends StatelessWidget {
  static IntroCardBuilder _buildDefaultCard(TextSpan contents) {
    return (BuildContext context, IntroParams params,
        IntroCardDecoration decoration) {
      final style = params._state.widget.cardDecoration?.textStyle ??
          params.controller.intro._cardDecoration.textStyle;
      final cardAlign = params.actualCardAlign;
      final textAlignToRight = [
        IntroCardAlign.insideTopRight,
        IntroCardAlign.insideBottomRight,
        IntroCardAlign.outsideTopRight,
        IntroCardAlign.outsideBottomRight,
        IntroCardAlign.outsideLeftTop,
        IntroCardAlign.outsideLeftBottom,
      ].contains(cardAlign);
      return IntroStepCard(
        params: params,
        child: Text.rich(
          contents,
          style: style,
          textAlign: textAlignToRight ? TextAlign.right : TextAlign.left,
        ),
      );
    };
  }

  final IntroParams params;
  final Widget child;

  const IntroStepCard({
    Key? key,
    required this.params,
    required this.child,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final controller = params.controller;
    final decoration =
        params._state.widget.cardDecoration ?? controller.intro._cardDecoration;

    return Container(
      width: decoration.size?.width,
      height: decoration.size?.height,
      padding: decoration.padding,
      decoration: BoxDecoration(
        color: decoration.backgroundColor,
        border: decoration.border,
        borderRadius: decoration.radius,
      ),
      child: Builder(
        builder: (context) {
          final showPreviousButton = decoration.showPreviousButton &&
              (!decoration.autoHideDisabledButton ||
                  controller.hasPreviousStep);
          final showNextButton = decoration.showNextButton &&
              (!decoration.autoHideDisabledButton ||
                  controller.hasNextStep ||
                  controller.isLastStep);
          final showCloseButton = decoration.showCloseButton;

          final children = <Widget>[];

          if (showPreviousButton) {
            children.add(ElevatedButton(
              onPressed:
                  controller.hasPreviousStep ? controller.previous : null,
              style: decoration.previousButtonStyle,
              child: Text(decoration.previousButtonLabel),
            ));
          }
          if (showCloseButton) {
            children.add(ElevatedButton(
              onPressed: controller.close,
              style: decoration.closeButtonStyle,
              child: Text(decoration.closeButtonLabel),
            ));
          }
          if (showNextButton) {
            children.add(ElevatedButton(
              onPressed: controller.hasNextStep
                  ? controller.next
                  : controller.isLastStep
                      ? controller.close
                      : null,
              style: decoration.nextButtonStyle,
              child: Text(controller.isLastStep
                  ? decoration.nextButtonFinishLabel
                  : decoration.nextButtonLabel),
            ));
          }

          if (children.isEmpty) {
            return child;
          }

          final alignToRight = [
            IntroCardAlign.insideTopRight,
            IntroCardAlign.insideBottomRight,
            IntroCardAlign.outsideTopRight,
            IntroCardAlign.outsideBottomRight,
            IntroCardAlign.outsideLeftTop,
            IntroCardAlign.outsideLeftBottom,
          ].contains(params.actualCardAlign);
          final alignToBottom = [
            IntroCardAlign.insideBottomLeft,
            IntroCardAlign.insideBottomRight,
            IntroCardAlign.outsideTopLeft,
            IntroCardAlign.outsideTopRight,
            IntroCardAlign.outsideLeftBottom,
            IntroCardAlign.outsideRightBottom,
          ].contains(params.actualCardAlign);

          for (var i = 1; i < children.length; i += 2) {
            children.insert(i, const SizedBox(width: 10));
          }

          return Column(
            crossAxisAlignment: alignToRight
                ? CrossAxisAlignment.end
                : CrossAxisAlignment.start,
            mainAxisAlignment:
                alignToBottom ? MainAxisAlignment.end : MainAxisAlignment.start,
            children: [
              child,
              const SizedBox(height: 20),
              Row(children: children),
            ],
          );
        },
      ),
    );
  }
}
