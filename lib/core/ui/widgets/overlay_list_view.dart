import 'package:flutter/material.dart';
import 'package:todo_list_app/core/core.dart';

class Item {
  final String text;
  bool? status;

  Item({required this.text, this.status});
}

class HolePainter extends CustomPainter {
  final Rect holeRect;

  HolePainter({required this.holeRect});

  @override
  void paint(Canvas canvas, Size size) {
    final paint =
        Paint()
          ..color = Colors.black.withValues(alpha: 0.7)
          ..style = PaintingStyle.fill;

    final backgroundPath =
        Path()..addRect(Rect.fromLTWH(0, 0, size.width, size.height));
    final holePath =
        Path()
          ..addRRect(RRect.fromRectAndRadius(holeRect, Radius.circular(24.0)));

    final combinedPath = Path.combine(
      PathOperation.difference,
      backgroundPath,
      holePath,
    );

    canvas.drawPath(combinedPath, paint);
  }

  @override
  bool shouldRepaint(covariant HolePainter oldDelegate) =>
      oldDelegate.holeRect != holeRect;
}

class OverlayListView extends StatefulWidget {
  final List<Item> items;
  final double? bottomPadding;
  final Function(int index) onTap;
  final Function(int index, String text) onChanged;
  final Function(int index) onDeletePressed;

  const OverlayListView({
    super.key,
    required this.items,
    this.bottomPadding,
    required this.onTap,
    required this.onChanged,
    required this.onDeletePressed,
  });

  @override
  State<OverlayListView> createState() => _OverlayListViewState();
}

class _OverlayListViewState extends State<OverlayListView> {
  final ScrollController _scrollController = ScrollController();
  final double _itemHeight = 76.0;
  late List<GlobalKey> _itemKeys;
  late double _bottomPadding;
  OverlayEntry? _overlayEntry;

  int? _index;

  @override
  void initState() {
    _bottomPadding = widget.bottomPadding ?? 16.0;
    super.initState();
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    _itemKeys = List.generate(widget.items.length, (i) => GlobalKey());

    return ListView.separated(
      shrinkWrap: true,
      physics: const AlwaysScrollableScrollPhysics(),
      padding: EdgeInsets.all(16.0).copyWith(bottom: _bottomPadding),
      controller: _scrollController,
      itemCount: widget.items.length,
      separatorBuilder: (context, index) => SizedBox(height: 12.0),
      itemBuilder: (context, index) {
        return GestureDetector(
          key: _itemKeys[index],
          onLongPress: () => _showOverlayWithHole(index, context),
          child: Slidable(
            index: index,
            onDeletePressed: widget.onDeletePressed,
            child: CustomTile(
              height: _itemHeight,
              title: widget.items[index].text,
              isSelected: _index == index,
              status: widget.items[index].status,
              onTap: () => widget.onTap(index),
              onSubmitted: (value) => _onSubmitted(index, value),
            ),
          ),
        );
      },
    );
  }

  // MARK: -
  // MARK: - FUNCTION'S

  Future<void> _scrollToIndex(int index) async {
    final context = _itemKeys[index].currentContext;
    if (context == null) return;

    await Scrollable.ensureVisible(
      context,
      duration: Duration(milliseconds: 300),
      curve: Curves.easeInOut,
      alignment: 0.5, // 0 - top, 0.5 - center, 1 - bottom
    );
  }

  void _showOverlayWithHole(int index, BuildContext context) async {
    // IMITATE BOTTOM INSET
    setState(
      () => _bottomPadding = MediaQuery.of(context).size.height - _itemHeight,
    );

    Future.delayed(const Duration(milliseconds: 100), () async {
      // SCROLL TO THE SELECTED ELEMENT
      await _scrollToIndex(index);

      // FIND THE SiZE AND POSITION  OF THE ELEMENT
      final RenderBox itemRenderBox =
          _itemKeys[index].currentContext?.findRenderObject() as RenderBox;
      final itemPosition = itemRenderBox.localToGlobal(Offset.zero);
      final itemSize = itemRenderBox.size;

      // CREATE OVERLAY
      _overlayEntry = OverlayEntry(
        builder:
            (context) => GestureDetector(
              onTap: () => _hideOverlay(),
              child: Stack(
                children: [
                  Positioned.fill(
                    child: CustomPaint(
                      painter: HolePainter(
                        holeRect: Rect.fromLTWH(
                          itemPosition.dx,
                          itemPosition.dy,
                          itemSize.width,
                          itemSize.height,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
      );

      // SHOW OVERLAY
      if (context.mounted) {
        Overlay.of(context).insert(_overlayEntry!);
      }

      // SET INDEX TO ENABLE AUTOFOCUS OF ELEMENT'S TEXTFIELD
      setState(() => _index = index);
    });
  }

  void _onSubmitted(int index, String value) {
    _hideOverlay();
    widget.onChanged(index, value);
  }

  void _hideOverlay() {
    // REMOVE BOTTOM INSET
    setState(() => _bottomPadding = 16.0);
    // CLEAR SELECTED INDEX FOR DISABLE CUSTOM TILE AUTOFOCUS
    _index = null;
    // REMOVE OVERLAY
    _overlayEntry?.remove();
    _overlayEntry = null;
  }
}
