import 'package:flutter/material.dart';
import 'package:leaf_lore_flutter/shared/presentation/ll_accent_button.dart';

class LlLoadingButton extends StatefulWidget {
  final String text;
  final VoidCallback onPressed;
  final String heroTag;
  final double? initialWidth;
  final bool isLoading;
  final AnimatedLoadingButtonController? controller;

  const LlLoadingButton(
    this.text, {
    super.key,
    required this.onPressed,
    required this.isLoading,
    this.controller,
    this.heroTag = 'animatedLoadingButtonHeroTag',
    this.initialWidth,
  });

  @override
  State<StatefulWidget> createState() {
    return _LlLoadingButtonState();
  }
}

class _LlLoadingButtonState extends State<LlLoadingButton>
    with SingleTickerProviderStateMixin {
  final Duration _animationDuration = const Duration(milliseconds: 300);

  late AnimatedLoadingButtonController _animatedLoadingButtonController;

  // RaisedLoadingButton animations
  late AnimationController _animationController;
  late Animation _loginButtonSizeAnimation;
  late Animation _loginButtonColorAnimation;
  late Animation _loginButtonShapeAnimation;
  late Animation _loginButtonPaddingAnimation;

  @override
  void initState() {
    super.initState();
    _animatedLoadingButtonController =
        widget.controller ?? AnimatedLoadingButtonController();

    _animatedLoadingButtonController.register(this);
  }

  @override
  void didChangeDependencies() {
      _initRaisedLoadingButtonAnimations();
  }

  @override
  void didUpdateWidget(LlLoadingButton oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.isLoading != oldWidget.isLoading) {
      if (widget.isLoading) {
        _animatedLoadingButtonController.animateLoading();
      } else {
        _animatedLoadingButtonController.animateClickable();
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    ThemeData theme = Theme.of(context);
    return SizedBox(
      width: _loginButtonSizeAnimation.value,
      height: theme.buttonTheme.height,
      child: Hero(
        tag: widget.heroTag,
        child: LlAccentButton(
          onPressed: !_animatedLoadingButtonController.isLoading
              ? widget.onPressed
              : _noop,
          color: _loginButtonColorAnimation.value,
          padding: _loginButtonPaddingAnimation.value,
          shape: _loginButtonShapeAnimation.value,
          child: AnimatedSwitcher(
            duration:
                _animationController.status == AnimationStatus.completed ||
                        _animationController.status == AnimationStatus.reverse
                    ? _animationController.reverseDuration!
                    : _animationController.duration!,
            switchOutCurve: Curves.easeInOut,
            switchInCurve: Curves.easeInOut,
            transitionBuilder: (Widget child, Animation<double> animation) {
              return ScaleTransition(
                scale: animation,
                child: child,
              );
            },
            child: _animationController.status == AnimationStatus.completed ||
                    _animationController.status == AnimationStatus.forward
                ? const CircularProgressIndicator()
                : Text(
                    widget.text.toUpperCase(),
                    // style: DiagnostrumTheme.buttonTextTheme(context),
                  ),
          ),
        ),
      ),
    );
  }

  void _initRaisedLoadingButtonAnimations() {
    ThemeData theme = Theme.of(context);

    _animationController = AnimationController(
      vsync: this,
      duration: _animationDuration,
      reverseDuration: _animationDuration,
    );
    _loginButtonSizeAnimation = _animationController.drive(Tween<double>(
      begin: widget.initialWidth ?? MediaQuery.of(context).size.width,
      end: theme.buttonTheme.height,
    ));
    _loginButtonShapeAnimation = _animationController.drive(
      ShapeBorderTween(
        begin: theme.buttonTheme.shape,
        end: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(50.0),
        ),
      ),
    );
    _loginButtonColorAnimation = _animationController.drive(ColorTween(
      begin: theme.buttonTheme.colorScheme?.primary,
      end: theme.buttonTheme.colorScheme?.primary,
      // end: theme.backgroundColor,
    ));
    _loginButtonPaddingAnimation =
        _animationController.drive(EdgeInsetsGeometryTween(
      begin: theme.buttonTheme.padding,
      end: EdgeInsets.zero,
    ));
    _animationController.addListener(() {
      setState(() {});
    });
  }

  void _noop() {}
}

class AnimatedLoadingButtonController {
  _LlLoadingButtonState? _animatedLoadingButtonState;
  bool isLoading = false;

  void animateLoading() {
    if (_animatedLoadingButtonState != null) {
      _animatedLoadingButtonState!._animationController.forward();
      isLoading = true;
    }
  }

  void animateClickable() {
    if (_animatedLoadingButtonState != null) {
      _animatedLoadingButtonState!._animationController.reverse();
      isLoading = false;
    }
  }

  void register(_LlLoadingButtonState animatedLoadingButtonState) {
    _animatedLoadingButtonState = animatedLoadingButtonState;
  }
}
