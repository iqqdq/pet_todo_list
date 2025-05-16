import 'package:flutter/material.dart';
import 'package:todo_list_app/core/core.dart';
import 'package:todo_list_app/features/features.dart';

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
      appBar: CustomAppBar(
        title: AppTitles.myDesk,
        onLogoutTap: _onLogoutPressed,
      ),
      backgroundColor: AppColors.grayscale200,
      body: Column(
        children: [
          /// PAGE VIEW
          Expanded(
            child: Container(
              // height: MediaQuery.of(context).size.height,
              color: AppColors.grayscale200,
              child: PageView(
                physics: const NeverScrollableScrollPhysics(),
                controller: _pageController,
                children: _pages,
              ),
            ),
          ),

          /// TAB BAR
          Align(
            alignment: Alignment.bottomCenter,
            child: NavigationBottomBar(onPressed: _onTabPressed),
          ),
        ],
      ),
    );
  }

  // MARK: -
  // MARK: - FUNCTION'S

  void _onTabPressed(int index) =>
      index == 0 ? _pageController.jumpToPage(index) : _onLogoutPressed();

  void _onLogoutPressed() => ActionSheetDialog.show(
    context,
    title: AppTitles.areYouSureYouWantToLogOut,
    actions: [SheetAction(title: AppTitles.logout, isDestructive: true)],
    onTap: (index) async {
      await sl.get<AuthRepository>().logout();
      if (mounted) {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => LogInScreen()),
        );
      }
    },
  );
}
