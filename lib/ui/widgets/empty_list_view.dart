import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:todo_list_app/ui/ui.dart';

class EmptyListView extends StatelessWidget {
  final String title;
  const EmptyListView({super.key, required this.title});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SvgPicture.asset(AppIcons.sketch),
            const SizedBox(height: 20.0),
            Text(title, style: AppTextStyles.headline3Regular18pt),
            const SizedBox(height: 22.0),
            Padding(
              padding: EdgeInsets.only(left: 50.0),
              child: Transform.rotate(
                angle: 0.2,
                child: SvgPicture.asset(AppIcons.arrow),
              ),
            ),
          ],
        ),
      ],
    );
  }
}
