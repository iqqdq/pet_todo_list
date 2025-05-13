import 'dart:io';

import 'package:flutter/material.dart';
import 'package:todo_list_app/core/core.dart';

class CustomTile extends StatefulWidget {
  final double height;
  final String title;
  final bool isSelected;
  final bool? status;
  final VoidCallback onTap;
  final Function(String value) onSubmitted;

  const CustomTile({
    super.key,
    required this.height,
    required this.title,
    required this.isSelected,
    this.status,
    required this.onTap,
    required this.onSubmitted,
  });

  @override
  State<CustomTile> createState() => _CustomTileState();
}

class _CustomTileState extends State<CustomTile> {
  late final TextEditingController _controller;

  @override
  void initState() {
    _controller = TextEditingController(text: widget.title);
    super.initState();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final borderRadius = BorderRadius.circular(24.0);

    return Material(
      color: AppColors.grayscale100,
      borderRadius: borderRadius,
      child: InkWell(
        borderRadius: borderRadius,
        splashColor:
            Platform.isAndroid ? AppColors.grayscale600 : Colors.transparent,
        highlightColor: AppColors.grayscale600,
        onTap: _onTap,
        child: Container(
          width: double.infinity,
          height: widget.height,
          padding: EdgeInsets.symmetric(horizontal: 24.0),
          decoration: BoxDecoration(
            borderRadius: borderRadius,
            boxShadow: [BoxShadow(color: AppColors.shadow1, blurRadius: 60.0)],
          ),
          child: Row(
            children: [
              Expanded(
                child: IgnorePointer(
                  ignoring: !widget.isSelected,
                  child: TextField(
                    controller: _controller,
                    style: AppTextStyles.headline1Semibold20pt,
                    autofocus: widget.isSelected,
                    cursorColor: AppColors.orangeIndicator,
                    decoration: InputDecoration.collapsed(hintText: null),
                    onTapOutside: (event) => FocusScope.of(context).unfocus(),
                    onSubmitted: _onSubmitted,
                  ),
                ),
              ),

              /// CHECKBOX
              widget.status == null
                  ? SizedBox.shrink()
                  : CustomCheckBox(status: widget.status!),
            ],
          ),
        ),
      ),
    );
  }

  // MARK: -
  // MARK: - FUNCTION'S

  void _onTap() {
    FocusScope.of(context).unfocus();
    widget.onTap();
  }

  void _onSubmitted(String value) {
    FocusScope.of(context).unfocus();
    widget.onSubmitted(value);
  }
}
