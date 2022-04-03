import 'package:stella_stays/stella_stays.dart';

void showSnackBar(BuildContext context, String message) {
  final snackBar = SnackBar(
    behavior: SnackBarBehavior.floating,
    content: message.text.bodySmall(color: SSColors.white).make(),
    backgroundColor: SSColors.primary,
  );

  ScaffoldMessenger.of(context).showSnackBar(snackBar);
}
