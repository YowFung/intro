part of intro;

class IntroStepCard extends StatelessWidget {
  static IntroCardBuilder _buildDefaultCard(TextSpan contents) {
    return (BuildContext context, IntroParams params,
        IntroCardDecoration decoration) {
      final decoration = params.controller.intro._cardDecoration.mergeTo(params._state.widget.cardDecoration);
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
          style: decoration.textStyle,
          textAlign: decoration.size == null && textAlignToRight ? TextAlign.right : TextAlign.left,
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
    final decoration = controller.intro._cardDecoration.mergeTo(params._state.widget.cardDecoration);

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
          final autoHide = decoration.autoHideDisabledButton ?? true;
          final showPrevious = decoration.showPreviousButton ?? true;
          final showNext = decoration.showNextButton ?? true;
          final showPreviousButton = showPrevious && (!autoHide || controller.hasPreviousStep);
          final showNextButton = showNext && (!autoHide || controller.hasNextStep);
          final showCloseButton = decoration.showCloseButton ?? true;

          final children = <Widget>[];

          if (showPreviousButton) {
            children.add(ElevatedButton(
              onPressed:
                  controller.hasPreviousStep ? controller.previous : null,
              style: decoration.previousButtonStyle,
              child: Text(decoration.previousButtonLabel ?? "Previous"),
            ));
          }
          if (showCloseButton) {
            children.add(ElevatedButton(
              onPressed: controller.close,
              style: decoration.closeButtonStyle,
              child: Text(decoration.closeButtonLabel ?? (controller.isLastStep ? "Finish" : "Close")),
            ));
          }
          if (showNextButton) {
            children.add(ElevatedButton(
              onPressed: controller.hasNextStep ? controller.next : null,
              style: decoration.nextButtonStyle,
              child: Text(decoration.nextButtonLabel ?? "Next"),
            ));
          }

          if (children.isEmpty) {
            return child;
          }

          final nonSize = decoration.size == null;
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
            crossAxisAlignment: nonSize && alignToRight
                ? CrossAxisAlignment.end
                : CrossAxisAlignment.start,
            mainAxisAlignment: nonSize && alignToBottom
                ? MainAxisAlignment.end
                : MainAxisAlignment.start,
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
