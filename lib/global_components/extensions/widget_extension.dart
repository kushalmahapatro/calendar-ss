import 'package:stella_stays/stella_stays.dart';

extension WidgetExtensions on Widget {
  Widget onClick(ClickFunction click) {
    return InkWell(
      onTap: () {
        if (click.eventLable.isNotEmpty) debugPrint(click.eventLable);
        if (click.onClick != null) {
          click.onClick!();
        }
      },
      splashColor: Colors.transparent,
      splashFactory: InkRipple.splashFactory,
      child: this,
    );
  }

  Widget get centre => Center(child: this);

  Widget circularWidget({double size = 40, Color? color}) {
    return Container(
      color: Colors.transparent,
      child: ClipOval(
        child: Material(
          color: color ?? SSColors.white.withOpacity(0.30), // button color
          child: SizedBox(width: size, height: size, child: this),
        ),
      ).centre,
    );
  }

  // Widget get setDirection => Directionality(
  //       textDirection: store.layoutDirection,
  //       child: this,
  //     );

  Widget get circularBorder => ClipRRect(
        borderRadius:
            const BorderRadius.all(Radius.circular(SSDec.borderRadius)),
        child: this,
      );

  SSButton ctaActive(ClickFunction click,
      {bool loading = false, bool disable = false, Key? key}) {
    return SSButton(
      this,
      disable ? CtaStyle.inactive : CtaStyle.active,
      click,
      loading: loading,
      key: key,
    );
  }
}

class ClickFunction {
  ClickFunction(
    this.eventLable, {
    this.onClick,
  });

  // ignore: prefer_function_declarations_over_variables
  void Function()? onClick = () {};
  String eventLable;
}

extension WidgetPaddingX on Widget {
  Widget paddingAll(double padding) =>
      Padding(padding: EdgeInsets.all(padding), child: this);

  Widget paddingSymmetric({double horizontal = 0.0, double vertical = 0.0}) =>
      Padding(
          padding:
              EdgeInsets.symmetric(horizontal: horizontal, vertical: vertical),
          child: this);

  Widget paddingOnly({
    double left = 0.0,
    double top = 0.0,
    double right = 0.0,
    double bottom = 0.0,
  }) =>
      Padding(
          padding: EdgeInsets.only(
              top: top, left: left, right: right, bottom: bottom),
          child: this);

  Widget get paddingZero => Padding(padding: EdgeInsets.zero, child: this);
}

/// Add margin property to widget
extension WidgetMarginX on Widget {
  Widget marginAll(double margin) =>
      Container(margin: EdgeInsets.all(margin), child: this);

  Widget marginSymmetric({double horizontal = 0.0, double vertical = 0.0}) =>
      Container(
          margin:
              EdgeInsets.symmetric(horizontal: horizontal, vertical: vertical),
          child: this);

  Widget marginOnly({
    double left = 0.0,
    double top = 0.0,
    double right = 0.0,
    double bottom = 0.0,
  }) =>
      Container(
          margin: EdgeInsets.only(
              top: top, left: left, right: right, bottom: bottom),
          child: this);

  Widget get marginZero => Container(margin: EdgeInsets.zero, child: this);
}
