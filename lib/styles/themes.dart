import 'package:stella_stays/stella_stays.dart';
import 'package:stella_stays/global_components/text/text_styles.dart';

class SSTheme {
  SSTheme._();

  static ThemeData theme = ThemeData(
    canvasColor: SSColors.white,
    primarySwatch: SSColors.primary,
    backgroundColor: SSColors.primary,
    splashColor: SSColors.primary,
    inputDecorationTheme: InputDecorationTheme(
        labelStyle: bodySmallStyle(SSColors.primary),
        hintStyle: bodySmallStyle(SSColors.primary.withOpacity(0.5)),
        errorStyle: bodySmallStyle(Colors.red),
        floatingLabelBehavior: FloatingLabelBehavior.auto,
        floatingLabelStyle: const TextStyle(
          color: SSColors.primary,
        ),
        border: border(),
        enabledBorder: border(),
        focusedBorder: border(),
        errorBorder: border(color: Colors.red)),
    textTheme: const TextTheme(
      headline1: TextStyle(color: SSColors.primary),
      headline4: TextStyle(color: SSColors.primary),
      bodyText2:
          TextStyle(color: SSColors.primary, fontWeight: FontWeight.bold),
      bodyText1: TextStyle(color: Colors.grey),
    ),
  );

  static OutlineInputBorder border({Color? color}) {
    return OutlineInputBorder(
      borderRadius: BorderRadius.circular(SSDec.borderRadius),
      borderSide: BorderSide(
        style: BorderStyle.solid,
        color: color ?? SSColors.primary,
      ),
    );
  }
}
