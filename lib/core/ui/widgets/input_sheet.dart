import 'package:flutter/material.dart';
import 'package:todo_list_app/core/core.dart';

class InputSheet {
  static void show(
    BuildContext context, {
    required String title,
    required String hintText,
    required Function(String text) onEditingComplete,
    String? text,
    Duration animationDuration = const Duration(milliseconds: 300),
  }) {
    showGeneralDialog(
      context: context,
      barrierColor: Colors.transparent,
      transitionDuration: animationDuration,
      pageBuilder: (context, animation1, animation2) {
        return Container();
      },
      transitionBuilder: (context, animation1, animation2, widget) {
        final fadeAnimation = CurvedAnimation(
          parent: animation1,
          curve: Curves.easeInOut,
        );

        return Material(
          type: MaterialType.transparency,
          child: Stack(
            children: [
              FadeTransition(
                opacity: fadeAnimation,
                child: GestureDetector(
                  onTap: () => Navigator.of(context).pop(),
                  child: Container(
                    color: AppColors.grayscale800.withValues(alpha: 0.9),
                    width: double.infinity,
                    height: double.infinity,
                  ),
                ),
              ),

              FadeTransition(
                opacity: fadeAnimation,
                child: InputSheetContent(
                  title: title,
                  text: text,
                  hintText: hintText,
                  onEditingComplete: onEditingComplete,
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}

class InputSheetContent extends StatefulWidget {
  final String title;
  final String hintText;
  final Function(String text) onEditingComplete;
  final String? text;

  const InputSheetContent({
    super.key,
    required this.title,
    required this.hintText,
    required this.onEditingComplete,
    this.text,
  });

  @override
  State<InputSheetContent> createState() => _InputSheetContentState();
}

class _InputSheetContentState extends State<InputSheetContent> {
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
