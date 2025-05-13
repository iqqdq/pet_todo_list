import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:todo_list_app/core/core.dart';

class Slidable extends StatefulWidget {
  final int index;
  final Widget child;
  final Function(int index) onDeletePressed;

  const Slidable({
    super.key,
    required this.index,
    required this.child,
    required this.onDeletePressed,
  });

  @override
  State<Slidable> createState() => _SlidableState();
}

class _SlidableState extends State<Slidable> {
  final double _width = 76.0;
  double _dragOffset = 0.0;
  int? _selectedIndex;

  @override
  Widget build(BuildContext context) {
    double slidableWidth = -_width * 0.7;

    return GestureDetector(
      onHorizontalDragUpdate: (details) {
        if (details.delta.dx < 0 && _dragOffset > slidableWidth) {
          setState(() {
            _dragOffset = _dragOffset + details.delta.dx;
            _selectedIndex = widget.index;
          });
        } else if (details.delta.dx > 0 && _dragOffset < 0) {
          setState(() {
            _dragOffset = _dragOffset + details.delta.dx;
            if (_dragOffset >= 0) _dragOffset = 0;
          });
        }
      },
      onHorizontalDragEnd: (_) {
        if (_dragOffset > -_width / 2.0) {
          setState(() {
            _dragOffset = 0;
          });
        }
      },
      child: Stack(
        children: [
          if (_selectedIndex == widget.index && _dragOffset < 0)
            Positioned.fill(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Container(
                    width: _width,
                    height: 76.0,
                    decoration: BoxDecoration(
                      color: AppColors.error,
                      borderRadius: BorderRadius.only(
                        topRight: const Radius.circular(24.0),
                        bottomRight: const Radius.circular(24.0),
                      ),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Padding(
                          padding: EdgeInsets.only(right: 6.0),
                          child: IconButton(
                            icon: SvgPicture.asset(AppIcons.trash),
                            onPressed: () {
                              _resetSwipe();
                              widget.onDeletePressed(widget.index);
                            },
                            color: AppColors.error,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          Transform.translate(
            offset: Offset(
              _selectedIndex == widget.index
                  ? _dragOffset >= slidableWidth
                      ? _dragOffset
                      : slidableWidth
                  : 0,
              0,
            ),
            child: widget.child,
          ),
        ],
      ),
    );
  }

  void _resetSwipe() {
    setState(() {
      _dragOffset = 0.0;
      _selectedIndex = null;
    });
  }
}
