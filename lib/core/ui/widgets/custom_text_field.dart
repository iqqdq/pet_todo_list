import 'package:flutter/material.dart';
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
  final VoidCallback? onEditingComplete;
  final String? error;

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
    this.onEditingComplete,
    this.error,
  });

  @override
  State<CustomTextField> createState() => _CustomTextFieldState();
}

class _CustomTextFieldState extends State<CustomTextField> {
  late bool _obscureText;

  @override
  void initState() {
    _obscureText = widget.obscureText ?? false;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final focusedColor = AppColors.grayscale700;
    final enabledColor = AppColors.grayscale600;
    final borderColor =
        widget.error == null
            ? enabledColor
            : widget.error!.isEmpty
            ? AppColors.success
            : AppColors.error;

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
            controller: widget.controller,
            keyboardType: widget.keyboardType,
            textCapitalization:
                widget.textCapitalization ?? TextCapitalization.none,
            textInputAction: widget.textInputAction,
            cursorColor: AppColors.orangeIndicator,
            obscureText: _obscureText,
            enableSuggestions: widget.obscureText == null,
            autocorrect: widget.obscureText == null,
            style: AppTextStyles.body2Regular16pt,
            decoration: InputDecoration(
              hintText: widget.hintText,
              hintStyle: AppTextStyles.body2Regular16pt.copyWith(
                color: enabledColor,
              ),
              suffixIcon:
                  widget.obscureText == null
                      ? widget.error == null
                          ? null
                          : widget.error!.isEmpty
                          ? SvgPicture.asset(AppIcons.check)
                          : null
                      : GestureDetector(
                        onTap:
                            () => setState(() => _obscureText = !_obscureText),
                        child: SvgPicture.asset(
                          _obscureText ? AppIcons.eyeClosed : AppIcons.eyeOpen,
                          colorFilter: ColorFilter.mode(
                            widget.error == null
                                ? enabledColor
                                : widget.error!.isEmpty
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
              enabledBorder: UnderlineInputBorder(
                borderSide: BorderSide(color: borderColor),
              ),
              focusedBorder: UnderlineInputBorder(
                borderSide: BorderSide(color: borderColor),
              ),
            ),
            onChanged: widget.onChanged,
            onEditingComplete: widget.onEditingComplete,
            onTapOutside: (event) => FocusScope.of(context).unfocus(),
          ),
        ),

        /// ERROR
        widget.error == null
            ? SizedBox.shrink()
            : widget.error!.isEmpty
            ? SizedBox.shrink()
            : Container(
              margin: EdgeInsets.only(top: 2.0),
              child: Text(
                widget.error!,
                style: AppTextStyles.body4Regular14pt.copyWith(
                  color: borderColor,
                ),
              ),
            ),
      ],
    );
  }
}
