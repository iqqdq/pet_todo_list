import 'package:flutter/material.dart';
import 'package:todo_list_app/features/features.dart';
import 'package:todo_list_app/ui/ui.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final PageController _pageController = PageController();
  final List<Widget> _pages = [DesksScreen(), Container(), Container()];

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: AppColors.grayscale200,
      body: Column(
        children: [
          /// PAGE VIEW
          Expanded(
            child: Container(
              color: AppColors.grayscale200,
              child: PageView(
                physics: const NeverScrollableScrollPhysics(),
                controller: _pageController,
                children: _pages,
              ),
            ),
          ),

          /// TAB BAR
          NavigationBottomBar(onPressed: _onTabPressed),
        ],
      ),
    );
  }

  // MARK: -
  // MARK: - FUNCTION'S

  void _onTabPressed(int index) =>
      index == 0 ? _pageController.jumpToPage(index) : {};
}
