import 'package:flutter/material.dart';
import 'package:todo_list_app/ui/ui.dart';

class MyDeskListView extends StatelessWidget {
  final List<String> titles;
  final Function(int index) onTap;

  const MyDeskListView({super.key, required this.titles, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 16.0),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(24.0),
        image: DecorationImage(
          image: AssetImage(AppImages.abstractBackgroundImage),
          fit: BoxFit.fill,
        ),
      ),
      child:
      /// LIST VIEW
      ListView.separated(
        shrinkWrap: true,
        padding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 24.0),
        itemCount: titles.length,
        separatorBuilder:
            (BuildContext context, int index) =>
                SizedBox(height: AppSpacing.spacing12px),
        itemBuilder: (BuildContext context, int index) {
          return CustomTile(title: titles[index], onTap: () => onTap(index));
        },
      ),
    );
  }
}
