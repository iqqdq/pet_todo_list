import 'package:flutter/material.dart';
import 'package:todo_list_app/core/core.dart';

class InputSheetView extends StatefulWidget {
  final String title;
  final String hintText;
  final Function(String text) onEditingComplete;
  final String? text;

  const InputSheetView({
    super.key,
    required this.title,
    required this.hintText,
    required this.onEditingComplete,
    this.text,
  });

  @override
  State<InputSheetView> createState() => _InputSheetViewState();
}

class _InputSheetViewState extends State<InputSheetView> {
  late final TextEditingController _controller;
  final _focusNode = FocusNode();
  final _textFieldStyle = AppTextStyles.body2Regular16pt;

  @override
  void initState() {
    _controller = TextEditingController(text: widget.text);
    _controller.addListener(() => setState(() {}));

    super.initState();

    WidgetsBinding.instance.addPostFrameCallback(
      (_) => _focusNode.requestFocus(),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    _focusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        margin: EdgeInsets.symmetric(
          horizontal: 16.0,
        ).copyWith(bottom: MediaQuery.of(context).viewInsets.bottom / 2.0),
        padding: EdgeInsets.symmetric(horizontal: 24.0),
        width: double.infinity,
        height: 259.0,
        decoration: BoxDecoration(
          color: AppColors.grayscale100,
          borderRadius: BorderRadius.circular(28.0),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Row(
              children: [
                /// TITLE
                Expanded(
                  child: Text(
                    widget.title,
                    style: AppTextStyles.title2SemiBold28pt.copyWith(
                      color: AppColors.grayscale700,
                    ),
                  ),
                ),
                const SizedBox(width: 12.0),

                /// CLOSE BUTTON
                CustomCloseButton(onTap: () => Navigator.pop(context)),
              ],
            ),
            const SizedBox(height: 28.0),

            /// TEXTFIELD
            SizedBox(
              height: 46.0,
              child: TextField(
                controller: _controller,
                focusNode: _focusNode,
                cursorColor: AppColors.orangeIndicator,
                style: _textFieldStyle,
                decoration: InputDecoration(
                  hintText: widget.hintText,
                  hintStyle: _textFieldStyle.copyWith(
                    color: AppColors.grayscale600,
                  ),

                  focusedBorder: UnderlineInputBorder(
                    borderSide: BorderSide(color: AppColors.grayscale800),
                  ),
                ),
              ),
            ),
            const SizedBox(height: 20.0),

            /// ADD BUTTON
            PrimaryButton(
              title: AppTitles.add,
              state:
                  _controller.text.isEmpty
                      ? PrimaryButtonState.disabled
                      : PrimaryButtonState.initial,
              onTap: _onTap,
            ),
          ],
        ),
      ),
    );
  }

  // MARK: -
  // MARK: - FUNCTION'S

  void _onTap() {
    widget.onEditingComplete(_controller.text);
    Navigator.pop(context);
  }
}
