import 'package:stella_stays/stella_stays.dart';

Widget circularProgress({Color? color, double strokeWidth = 4}) {
  strokeWidth = (strokeWidth <= 0) ? 4 : strokeWidth;
  return SizedBox(
    child: CircularProgressIndicator(
      color: color ?? SSColors.primary,
      strokeWidth: strokeWidth,
    ),
    width: SSDec.ctaHeight - 20,
    height: SSDec.ctaHeight - 20,
  ).centre;
}
