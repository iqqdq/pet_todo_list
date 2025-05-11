import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:todo_list_app/ui/ui.dart';

class CustomTextField extends StatefulWidget {
  final TextEditingController controller;
  final String title;
  final String hintText;
  final TextInputType? keyboardType;
  final TextInputAction? textInputAction;
  final TextCapitalization? textCapitalization;
  final bool? obscureText;

  const CustomTextField({
    super.key,
    required this.controller,
    required this.title,
    required this.hintText,
    this.keyboardType,
    this.textInputAction,
    this.textCapitalization,
    this.obscureText,
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
            decoration: InputDecoration(
              hintText: widget.hintText,
              hintStyle: AppTextStyles.body2Regular16pt.copyWith(
                color: enabledColor,
              ),
              suffixIcon:
                  widget.obscureText == null
                      ? null
                      : GestureDetector(
                        onTap:
                            () => setState(() => _obscureText = !_obscureText),
                        child: SvgPicture.asset(
                          _obscureText ? AppIcons.eyeClosed : AppIcons.eyeOpen,
                          colorFilter: ColorFilter.mode(
                            enabledColor,
                            BlendMode.srcIn,
                          ),
                        ),
                      ),
              suffixIconConstraints: BoxConstraints(
                maxWidth: 20.0,
                maxHeight: 20.0,
              ),
              enabledBorder: UnderlineInputBorder(
                borderSide: BorderSide(color: enabledColor),
              ),
              focusedBorder: UnderlineInputBorder(
                borderSide: BorderSide(color: focusedColor),
              ),
            ),
            onTapOutside: (event) => FocusScope.of(context).unfocus(),
          ),
        ),
      ],
    );
  }
}
