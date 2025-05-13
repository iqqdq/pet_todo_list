import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:todo_list_app/core/core.dart';

enum LoadingIndicatorState { white, dark }

class LoadingIndicator extends StatefulWidget {
  final LoadingIndicatorState state;

  const LoadingIndicator({super.key, this.state = LoadingIndicatorState.dark});

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
        widget.state == LoadingIndicatorState.dark
            ? AppIcons.loadingDark
            : AppIcons.loadingWhite;

    return Center(
      child: RotationTransition(
        turns: _controller,
        child: SvgPicture.asset(image, fit: BoxFit.contain),
      ),
    );
  }
}
