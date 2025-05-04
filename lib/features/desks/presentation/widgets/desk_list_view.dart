import 'package:flutter/material.dart';
import 'package:todo_list_app/features/features.dart';
import 'package:todo_list_app/ui/ui.dart';

class DeskListView extends StatelessWidget {
  final List<DeskEntity> desks;
  final Function(int index) onTap;

  const DeskListView({super.key, required this.desks, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return desks.isEmpty
        ? Center(child: Text('EMPTY LIST'))
        :
        /// BACKGROUND IMAGE
        Container(
          margin: EdgeInsets.symmetric(horizontal: 16.0),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(24.0),
            image: DecorationImage(
              image: AssetImage(AppImages.abstractBackgroundImage),
              fit: BoxFit.fitWidth,
            ),
          ),
          child:
          /// LIST VIEW
          ListView.separated(
            shrinkWrap: true,
            padding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 24.0),
            itemCount: desks.length,
            separatorBuilder:
                (BuildContext context, int index) =>
                    SizedBox(height: AppSpacing.spacing12px),
            itemBuilder: (BuildContext context, int index) {
              return DeskTile(
                title: desks[index].name,
                onTap: () => onTap(index),
              );
            },
          ),
        );
  }
}
