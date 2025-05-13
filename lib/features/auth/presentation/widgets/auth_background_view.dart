import 'package:flutter/material.dart';
import 'package:todo_list_app/core/core.dart';

class AuthBackgroundView extends StatelessWidget {
  final List<Widget> children;

  const AuthBackgroundView({super.key, required this.children});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        SizedBox(
          width: double.infinity,
          child: Image.asset(
            AppImages.abstractBackgroundImage,
            fit: BoxFit.fitWidth,
          ),
        ),
        Align(
          alignment: Alignment.bottomCenter,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Container(
                width: double.infinity,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(24.0),
                    topRight: Radius.circular(24.0),
                  ),
                  color: AppColors.grayscale100,
                ),
                child: ListView(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  padding: EdgeInsets.symmetric(
                    horizontal: 24.0,
                    vertical: 36.0,
                  ).copyWith(
                    bottom:
                        MediaQuery.of(context).viewInsets.bottom * 0.6 +
                        MediaQuery.of(context).padding.bottom,
                  ),
                  children: children,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
