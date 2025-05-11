import 'package:flutter/material.dart';
import 'package:todo_list_app/ui/ui.dart';

class Slidable extends StatefulWidget {
  final int index;
  final Widget child;
  final Function(int index) onEditPressed;
  final Function(int index) onDeletePressed;

  const Slidable({
    super.key,
    required this.index,
    required this.child,
    required this.onEditPressed,
    required this.onDeletePressed,
  });

  @override
  State<Slidable> createState() => _SlidableState();
}

class _SlidableState extends State<Slidable> {
  double _dragOffset = 0.0;
  int? _selectedIndex;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onHorizontalDragUpdate: (details) {
        if (details.delta.dx < 0 && _dragOffset > -136.0) {
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
        if (_dragOffset > -80) {
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
                    padding: EdgeInsets.only(left: 20.0),
                    width: 90.0,
                    height: 76.0,
                    color: AppColors.blueIndicator,
                    child: IconButton(
                      icon: Icon(Icons.edit, color: AppColors.grayscale100),
                      onPressed: () {
                        _resetSwipe();
                        widget.onEditPressed(widget.index);
                      },
                      color: Colors.blue,
                    ),
                  ),
                  Container(
                    width: 70.0,
                    height: 76.0,
                    decoration: BoxDecoration(
                      color: AppColors.error,
                      borderRadius: BorderRadius.only(
                        topRight: const Radius.circular(24.0),
                        bottomRight: const Radius.circular(24.0),
                      ),
                    ),
                    child: IconButton(
                      icon: Icon(Icons.delete, color: AppColors.grayscale100),
                      onPressed: () {
                        _resetSwipe();
                        widget.onDeletePressed(widget.index);
                      },
                      color: Colors.red,
                    ),
                  ),
                ],
              ),
            ),
          Transform.translate(
            offset: Offset(
              _selectedIndex == widget.index
                  ? _dragOffset >= -136.0
                      ? _dragOffset
                      : -136.0
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
