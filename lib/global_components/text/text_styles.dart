import 'package:stella_stays/stella_stays.dart';

TextTheme get theme => GoogleFonts.soraTextTheme();

TextStyle bodyMediumStyle(Color? color) {
  return theme.bodyMedium
          ?.copyWith(color: color ?? SSColors.primary, fontSize: 14) ??
      const TextStyle();
}

TextStyle bodySmallStyle(Color? color) {
  return theme.bodySmall
          ?.copyWith(color: color ?? SSColors.primary, fontSize: 12) ??
      const TextStyle();
}

TextStyle bodyLargeStyle(Color? color) {
  return theme.bodyLarge
          ?.copyWith(color: color ?? SSColors.primary, fontSize: 16) ??
      const TextStyle();
}

TextStyle headlineStyle(Color? color) {
  return theme.headline4
          ?.copyWith(color: color ?? SSColors.primary, fontSize: 22) ??
      const TextStyle();
}

TextStyle buttonStyle(Color? color) {
  return theme.button?.copyWith(color: color ?? SSColors.white, fontSize: 12) ??
      const TextStyle();
}
