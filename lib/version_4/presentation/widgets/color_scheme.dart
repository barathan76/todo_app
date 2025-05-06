import 'package:flutter/material.dart';

final kColorScheme = ColorScheme.fromSeed(
  seedColor: Color.fromARGB(255, 236, 252, 62),
  brightness: Brightness.dark,
);

Color primaryTextColor(BuildContext context) {
  return Theme.of(context).colorScheme.primary;
}

Color secondaryTextColor(BuildContext context) {
  return Theme.of(context).colorScheme.secondary;
}

Color tertiaryTextColor(BuildContext context) {
  return Theme.of(context).colorScheme.tertiary;
}

Color surfaceColor(BuildContext context) {
  return Theme.of(context).colorScheme.surface;
}

Color onPrimaryColor(BuildContext context) {
  return Theme.of(context).colorScheme.onPrimary;
}

Color onSecondaryColor(BuildContext context) {
  return Theme.of(context).colorScheme.onSecondary;
}
