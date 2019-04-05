import 'package:flutter/cupertino.dart';

class FadeInFadeOut<T> extends CupertinoPageRoute<T> {
  FadeInFadeOut({WidgetBuilder builder, RouteSettings settings})
      : super(builder: builder, settings: settings);

  @override
  Widget buildTransitions(BuildContext context, Animation<double> animation,
      Animation<double> secondaryAnimation, Widget child) {
    if (settings.isInitialRoute) return child;

    return FadeTransition(opacity: animation, child: child);
  }
}

class NoAnimationSlideDown<T> extends CupertinoPageRoute<T> {
  NoAnimationSlideDown({WidgetBuilder builder, RouteSettings settings})
      : super(builder: builder, settings: settings);

  @override
  Widget buildTransitions(BuildContext context, Animation<double> animation,
      Animation<double> secondaryAnimation, Widget child) {
    if (animation.status == AnimationStatus.reverse)
      return SlideTransition(
        transformHitTests: false,
        position: Tween<Offset>(
          begin: const Offset(0.0, -1.0),
          end: Offset.zero,
        ).animate(animation),
        child: new SlideTransition(
          position: new Tween<Offset>(
            begin: Offset.zero,
            end: const Offset(0.0, 1.0),
          ).animate(secondaryAnimation),
          child: child,
        ),
      );

    return child;
  }
}
