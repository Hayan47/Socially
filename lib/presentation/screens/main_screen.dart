import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:socially/logic/post_bloc/post_bloc.dart';
import 'package:socially/logic/story_bloc/story_bloc.dart';
import 'package:socially/presentation/screens/home_screen.dart';
import 'package:socially/presentation/themes/app_colors.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  PageController _pageController = PageController();
  final List<Widget> _screens = [
    const HomeScreen(),
  ];

  @override
  void initState() {
    super.initState();
    _pageController = PageController();
    loadData();
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  Future<void> loadData() async {
    context.read<StoryBloc>().add(GetStories());
    context.read<PostBloc>().add(GetPosts());
  }

  void navigateBottomNavBar(int index) {
    _pageController.animateToPage(
      index,
      duration: const Duration(milliseconds: 300),
      curve: Curves.fastLinearToSlowEaseIn,
    );
  }

  @override
  Widget build(BuildContext context) {
    final isBigWidth = MediaQuery.sizeOf(context).width > 600;
    return Scaffold(
      backgroundColor: AppColors.darkBlue,
      body: SafeArea(
        child: Row(
          children: [
            isBigWidth
                ? NavigationRail(
                    destinations: [
                      NavigationRailDestination(
                        icon: Image.asset('assets/icons/home.png'),
                        label: const Text('Home'),
                      ),
                      NavigationRailDestination(
                        icon: Image.asset('assets/icons/explore.png'),
                        label: const Text('Home'),
                      ),
                      NavigationRailDestination(
                        icon: Image.asset('assets/icons/profile.png'),
                        label: const Text('Home'),
                      ),
                    ],
                    selectedIndex: 0,
                  )
                : Container(),
            Expanded(
              child: SizedBox.expand(
                child: PageView(
                  physics: const NeverScrollableScrollPhysics(),
                  controller: _pageController,
                  children: _screens,
                ),
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: isBigWidth
          ? null
          : Container(
              alignment: Alignment.topCenter,
              height: 84,
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                  color: Colors.white,
                  border: Border(
                      top: BorderSide(color: Colors.grey[900]!, width: 0.5)),
                  borderRadius: const BorderRadiusDirectional.vertical(
                      top: Radius.circular(20))),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Image.asset('assets/icons/home.png'),
                  Image.asset('assets/icons/explore.png'),
                  Image.asset('assets/icons/profile.png'),
                ],
              ),
            ),
    );
  }
}
