import 'package:stella_stays/stella_stays.dart';

enum CtaStyle { active, inactive, outline, social }

class SSButton extends StatefulWidget {
  const SSButton(
    this.child,
    this.ctaStyle,
    this.click, {
    this.loading = false,
    this.animate = true,
    Key? key,
  }) : super(key: key);

  final Widget child;
  final CtaStyle ctaStyle;
  final ClickFunction click;
  final bool loading;
  final bool animate;

  @override
  _SSButtonState createState() => _SSButtonState();

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(EnumProperty<CtaStyle>('ctaStyle', ctaStyle))
      ..add(DiagnosticsProperty<ClickFunction>('click', click))
      ..add(DiagnosticsProperty<bool>('loading', loading))
      ..add(DiagnosticsProperty<bool>('animate', animate));
  }
}

class _SSButtonState extends State<SSButton> with TickerProviderStateMixin {
  Widget child = Container();

  @override
  void initState() {
    child = widget.child.centre;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final ClickFunction clickFunction =
        widget.ctaStyle != CtaStyle.inactive ? widget.click : ClickFunction('');

    Widget functionalButton() => AnimatedContainer(
          width: widget.loading
              ? SSDec.ctaHeight
              : MediaQuery.of(context).size.width,
          duration: const Duration(milliseconds: 250),
          height: SSDec.ctaHeight,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.all(Radius.circular(
                widget.loading ? SSDec.ctaHeight / 2 : SSDec.borderRadius)),
            color: getCtaColor(),
            border: Border.all(
                color: widget.ctaStyle == CtaStyle.social
                    ? SSColors.primary
                    : SSColors.primary.withOpacity(
                        widget.ctaStyle == CtaStyle.inactive ? 0.0 : 1,
                      ),
                width: 1),
          ),
          child: widget.loading
              ? circularProgress(
                  color: widget.ctaStyle == CtaStyle.outline
                      ? SSColors.primary
                      : widget.ctaStyle == CtaStyle.social
                          ? SSColors.primary
                          : SSColors.white)
              : child.centre,
        ).circularBorder;

    Widget nonAnimatingButton() => Container(
          height: SSDec.ctaHeight,
          decoration: BoxDecoration(
            borderRadius:
                const BorderRadius.all(Radius.circular(SSDec.borderRadius)),
            color: getCtaColor(),
            border: Border.all(
                color: (widget.ctaStyle == CtaStyle.social
                        ? SSColors.primary
                        : SSColors.primary)
                    .withOpacity(
                  widget.ctaStyle == CtaStyle.inactive ? 0.0 : 1,
                ),
                width: 1),
          ),
          child: widget.loading
              ? circularProgress(
                  color: widget.ctaStyle == CtaStyle.outline
                      ? SSColors.primary
                      : widget.ctaStyle == CtaStyle.social
                          ? SSColors.primary
                          : SSColors.white)
              : child.centre,
        ).circularBorder;

    return widget.loading
        ? widget.animate
            ? functionalButton().centre
            : nonAnimatingButton().centre
        : widget.animate
            ? functionalButton().onClick(clickFunction).centre
            : nonAnimatingButton().onClick(clickFunction).centre;
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(EnumProperty<CtaStyle>('ctaStyle', widget.ctaStyle))
      ..add(DiagnosticsProperty<ClickFunction>('click', widget.click))
      ..add(DiagnosticsProperty<bool>('loading', widget.loading));
  }

  Color getCtaColor() {
    switch (widget.ctaStyle) {
      case CtaStyle.active:
        return SSColors.primary.withOpacity(0.98);

      case CtaStyle.inactive:
        return SSColors.primary.withOpacity(
          0.32,
        );

      case CtaStyle.outline:
        return SSColors.white;

      case CtaStyle.social:
        return SSColors.white;
    }
  }
}
