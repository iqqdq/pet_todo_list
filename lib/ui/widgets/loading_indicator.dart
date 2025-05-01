import 'package:flutter/material.dart';

enum LoadingIndicatorState { largeWhite, mediumWhite, largeDark, mediumDark }

class LoadingIndicator extends StatefulWidget {
  final LoadingIndicatorState state;

  const LoadingIndicator({
    super.key,
    this.state = LoadingIndicatorState.mediumDark,
  });

  @override
  State<LoadingIndicator> createState() => _LoadingIndicatorState();
}

class _LoadingIndicatorState extends State<LoadingIndicator>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 500),
    )..repeat();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final image =
        widget.state == LoadingIndicatorState.mediumDark
            ? 'assets/loading_medium_dark.svg'
            : widget.state == LoadingIndicatorState.largeWhite
            ? 'assets/loading_large_white.svg'
            : widget.state == LoadingIndicatorState.mediumWhite
            ? 'assets/loading_medium_dark.svg'
            : 'assets/loading_large_dark.svg';

    return Center(
      child: RotationTransition(
        turns: _controller,
        child: Image.asset(image, fit: BoxFit.contain),
      ),
    );
  }
}
