import 'package:flutter/material.dart';

///global key that was used for get Current "context" and navigation
final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

push(BuildContext context, page) {
  Navigator.push(
    context,
    MaterialPageRoute(
      builder: (_) => page,
    ),
  );
}

pushAndReplace(BuildContext context, page) {
  Navigator.pushReplacement(
    context,
    MaterialPageRoute(
      builder: (_) => page,
    ),
  );
}

pop() {
  Navigator.pop(navigatorKey.currentState!.context);
}

pushAndRemoveUntil(BuildContext context, page) {
  Navigator.pushAndRemoveUntil(
    context,
    MaterialPageRoute(
      builder: (_) => page,
    ),
    (_) => false,
  );
}
