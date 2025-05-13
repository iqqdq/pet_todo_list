import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/svg.dart';
import 'package:todo_list_app/core/core.dart';

class CustomTextField extends StatefulWidget {
  final TextEditingController controller;
  final String title;
  final String hintText;
  final TextInputType? keyboardType;
  final TextInputAction? textInputAction;
  final TextCapitalization? textCapitalization;
  final bool? obscureText;
  final Function(String text)? onChanged;
  final String? error;
  final bool? alwaysShowError;

  const CustomTextField({
    super.key,
    required this.controller,
    required this.title,
    required this.hintText,
    this.keyboardType,
    this.textInputAction,
    this.textCapitalization,
    this.obscureText,
    this.onChanged,
    this.error,
    this.alwaysShowError,
  });

  @override
  State<CustomTextField> createState() => _CustomTextFieldState();
}

class _CustomTextFieldState extends State<CustomTextField> {
  late bool _obscureText;
  bool _isEditingCompleted = false;

  @override
  void initState() {
    _obscureText = widget.obscureText ?? false;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final error = _isEditingCompleted ? widget.error : null;
    final focusedColor = AppColors.grayscale700;
    final enabledColor = AppColors.grayscale600;
    final style = AppTextStyles.body2Regular16pt;

    final borderColor =
        error == null
            ? enabledColor
            : error.isEmpty
            ? AppColors.success
            : AppColors.error;

    final inputBorder = UnderlineInputBorder(
      borderSide: BorderSide(color: borderColor),
    );

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        /// TITLE
        Text(
          widget.title,
          style: AppTextStyles.headline4Semibold16pt.copyWith(
            color: focusedColor,
          ),
        ),

        /// TEXT FIELD
        SizedBox(
          height: 46.0,
          child: TextField(
            inputFormatters: [
              FilteringTextInputFormatter.deny(
                RegExp(r'\s'),
              ), // Disable whitespace
            ],
            controller: widget.controller,
            keyboardType: widget.keyboardType,
            textCapitalization:
                widget.textCapitalization ?? TextCapitalization.none,
            textInputAction: widget.textInputAction,
            cursorColor: AppColors.orangeIndicator,
            obscureText: _obscureText,
            enableSuggestions: widget.obscureText == null,
            autocorrect: widget.obscureText == null,
            style: style,
            decoration: InputDecoration(
              hintText: widget.hintText,
              hintStyle: style.copyWith(color: enabledColor),
              suffixIcon:
                  widget.obscureText == null
                      ? error == null
                          ? null
                          : error.isEmpty
                          ? SvgPicture.asset(AppIcons.check)
                          : null
                      : GestureDetector(
                        onTap: _onTap,
                        child: SvgPicture.asset(
                          _obscureText ? AppIcons.eyeClosed : AppIcons.eyeOpen,
                          colorFilter: ColorFilter.mode(
                            error == null
                                ? enabledColor
                                : error.isEmpty
                                ? enabledColor
                                : AppColors.error,
                            BlendMode.srcIn,
                          ),
                        ),
                      ),
              suffixIconConstraints: BoxConstraints(
                maxWidth: 20.0,
                maxHeight: 20.0,
              ),
              enabledBorder: inputBorder,
              focusedBorder: inputBorder,
            ),
            onChanged: _onChanged,
            onEditingComplete: _onEditingComplete,
            onTapOutside: _onTapOutside,
          ),
        ),

        /// ERROR
        error == null
            ? SizedBox.shrink()
            : error.isEmpty
            ? SizedBox.shrink()
            : Container(
              margin: EdgeInsets.only(top: 2.0),
              child: Text(
                error,
                style: AppTextStyles.body4Regular14pt.copyWith(
                  color: borderColor,
                ),
              ),
            ),
      ],
    );
  }

  // MARK: -
  // MARK: - FUNCTION'S

  void _onTap() => setState(() => _obscureText = !_obscureText);

  void _onTapOutside(PointerDownEvent event) =>
      FocusScope.of(context).unfocus();

  void _onChanged(String value) {
    setState(() => _isEditingCompleted = false);
    if (widget.onChanged != null) {
      widget.onChanged!(value);
    }
  }

  void _onEditingComplete() {
    setState(() => _isEditingCompleted = true);
    FocusScope.of(context).nextFocus();
  }
}
