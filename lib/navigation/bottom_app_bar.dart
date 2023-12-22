import 'package:finup/common/widgets/utils.dart';
import 'package:finup/core/providers/navbar_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class MainWrapper extends ConsumerStatefulWidget {
  const MainWrapper({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _MainWrapperState();
}

class _MainWrapperState extends ConsumerState<MainWrapper> {
  late PageController pageController;

  @override
  void initState() {
    super.initState();
    pageController = PageController();
  }

  @override
  void dispose() {
    pageController.dispose();
    super.dispose();
  }

  final List<Widget> topLevelPages = const [
    Center(child: Text("1")),
    Center(child: Text("2")),
    Center(child: Text("3")),
    Center(child: Text("4")),
  ];

  void onPageChanged(int page) {
    ref.read(navIndexProvider.notifier).state = page;
    print('Current Page: $page');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // backgroundColor: const Color.fromARGB(255, 2, 2, 2),
      // appBar: _mainWrapperAppBar(),
      body: _mainWrapperBody(),
      bottomNavigationBar: _mainWrapperBottomNavBar(),
      floatingActionButtonLocation: FloatingActionButtonLocation.endDocked,
      floatingActionButton: _mainWrapperFab(),
    );
  }

  BottomAppBar _mainWrapperBottomNavBar() {
    return BottomAppBar(
      color: Colors.black,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        mainAxisSize: MainAxisSize.min,
        children: [
          Expanded(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                _bottomAppBarItem(
                  defaultIcon: Icons.home_outlined,
                  page: 0,
                  label: "Home",
                  filledIcon: Icons.home,
                ),
                _bottomAppBarItem(
                  defaultIcon: Icons.headphones_outlined,
                  page: 1,
                  label: "Favorite",
                  filledIcon: Icons.headphones,
                ),
                _bottomAppBarItem(
                  defaultIcon: Icons.no_accounts_outlined,
                  page: 2,
                  label: "Notifs",
                  filledIcon: Icons.no_accounts,
                ),
                _bottomAppBarItem(
                  defaultIcon: Icons.person_outline,
                  page: 3,
                  label: "Profile",
                  filledIcon: Icons.person,
                ),
              ],
            ),
          ),
          SizedBox(
            width: 60.w,
          ),
        ],
      ),
    );
  }

  FloatingActionButton _mainWrapperFab() {
    return FloatingActionButton(
      onPressed: () {
        context.showAlert("hello");
      },
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(50)),
      // backgroundColor: Colors.amber,
      child: const Icon(Icons.add),
    );
  }

  // AppBar _mainWrapperAppBar() {
  //   return AppBar(
  //     backgroundColor: Colors.black,
  //     title: const Text("BottomNavigationBar with Riverpod"),
  //   );
  // }

  PageView _mainWrapperBody() {
    return PageView(
      onPageChanged: (int page) => onPageChanged(page),
      controller: pageController,
      children: topLevelPages,
    );
  }

  Widget _bottomAppBarItem({
    required IconData defaultIcon,
    required int page,
    required String label,
    required IconData filledIcon,
  }) {
    return GestureDetector(
      onTap: () {
        ref.read(navIndexProvider.notifier).state = page;

        pageController.animateToPage(page,
            duration: const Duration(milliseconds: 10),
            curve: Curves.fastLinearToSlowEaseIn);
      },
      child: Container(
        color: Colors.transparent,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            SizedBox(
              height: 3.h,
            ),
            Icon(
              ref.watch(navIndexProvider) == page ? filledIcon : defaultIcon,
              color: ref.watch(navIndexProvider) == page
                  ? Colors.white
                  : Colors.grey,
              size: 26.sp,
            ),
            SizedBox(
              height: 5.h,
            ),
            Text(
              label,
              style: TextStyle(
                color: ref.watch(navIndexProvider) == page
                    ? Colors.white
                    : Colors.grey,
                fontSize: 13,
                fontWeight: ref.watch(navIndexProvider) == page
                    ? FontWeight.w600
                    : FontWeight.w400,
              ),
            ),
          ],
        ),
      ),
    );
  }
}