import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class AnimatedVisibility extends StatefulWidget {
  final Widget child;
  final bool isVisible;
  final Duration duration;
  final Curve curve;

  const AnimatedVisibility({
    Key? key,
    required this.child,
    required this.isVisible,
    required this.duration,
    this.curve = Curves.linear,
  }) : super(key: key);

  @override
  _AnimatedVisibilityState createState() => _AnimatedVisibilityState();
}

class _AnimatedVisibilityState extends State<AnimatedVisibility>
    with SingleTickerProviderStateMixin {
  late final controller = AnimationController(
    duration: widget.duration,
    value: widget.isVisible ? 1.0 : 0.0,
    vsync: this,
  );

  late final animation = CurvedAnimation(
    parent: controller,
    curve: widget.curve,
  );

  @override
  void didUpdateWidget(covariant AnimatedVisibility oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.duration != oldWidget.duration) {
      controller.duration = widget.duration;
    }
    if (widget.curve != oldWidget.curve) {
      animation.curve = widget.curve;
    }
    if (widget.isVisible != oldWidget.isVisible) {
      if (widget.isVisible) {
        controller.forward();
      } else {
        controller.reverse();
      }
    }
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return IgnorePointer(
      ignoring: !widget.isVisible,
      child: ScaleTransition(
        scale: animation,
        child: FadeTransition(
          opacity: animation,
          child: widget.child,
        ),
      ),
    );
  }
}
