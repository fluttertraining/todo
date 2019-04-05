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
