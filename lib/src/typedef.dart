part of intro;

typedef IntroCardBuilder = Widget Function(BuildContext context, IntroParams params, IntroCardDecoration decoration);

typedef IntroStepWillActivateCallback = FutureOr<void> Function(int fromStep);

typedef IntroStepWillDeactivateCallback = FutureOr<void> Function(int willToStep);
