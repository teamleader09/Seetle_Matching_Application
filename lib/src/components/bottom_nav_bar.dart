
import 'package:flutter/material.dart';
import 'package:seetle/src/constants/app_styles.dart';

class BottomNavBar extends StatelessWidget {
  final int currentIndex;

  const BottomNavBar({super.key, required this.currentIndex});

  @override
  Widget build(BuildContext context) {
    void onTabTapped(int index) {
      // switch (index) {
      //   case 0:
      //     Navigator.pushReplacement(
      //       context,
      //       PageRouteBuilder(
      //         pageBuilder: (context, animation1, animation2) =>
      //           const HomeScreen(),
      //         transitionDuration: Duration.zero,
      //         reverseTransitionDuration: Duration.zero,
      //       ),
      //     );
      //     break;
      //   case 1:
      //     Navigator.pushReplacement(
      //       context,
      //       PageRouteBuilder(
      //         pageBuilder: (context, animation1, animation2) => const SearchScreen(),
      //         transitionDuration: Duration.zero,
      //         reverseTransitionDuration: Duration.zero,
      //       ),
      //     );
      //     break;

      //   case 2:
      //     Navigator.pushReplacement(
      //       context,
      //       PageRouteBuilder(
      //         pageBuilder: (context, animation1, animation2) => const AskQuestionScreen(),
      //         transitionDuration: Duration.zero,
      //         reverseTransitionDuration: Duration.zero,
      //       ),
      //     );
      //     break;
      //   case 3:
      //     Navigator.pushReplacement(
      //       context,
      //       PageRouteBuilder(
      //         pageBuilder: (context, animation1, animation2) => const QuestionScreen(),
      //         transitionDuration: Duration.zero,
      //         reverseTransitionDuration: Duration.zero,
      //       ),
      //     );
      //     break;
      //   case 4:
      //     Navigator.pushReplacement(
      //       context,
      //       PageRouteBuilder(
      //         pageBuilder: (context, animation1, animation2) => const ProfileScreen(),
      //         transitionDuration: Duration.zero,
      //         reverseTransitionDuration: Duration.zero,
      //       ),
      //     );
      //     break;
      //   default:
      //     break;
      // }
    }

    return Container(
        decoration: const BoxDecoration(
            border: Border(top: BorderSide(color: kColorPrimary, width: 0.5))),
        child: BottomNavigationBar(
          type: BottomNavigationBarType.fixed,
          backgroundColor: kColorWhite,
          showSelectedLabels: false,
          showUnselectedLabels: false,
          selectedFontSize: 12,
          currentIndex: currentIndex,
          onTap: onTabTapped,
          items: [
            BottomNavigationBarItem(
                icon: Image(
                    image: currentIndex == 0
                        ? const AssetImage("assets/images/icons/home-1.png")
                        : const AssetImage(
                            "assets/images/icons/home.png",
                          ),
                    width: 24),
                label: ""),
            BottomNavigationBarItem(
                icon: Padding(
                  padding: const EdgeInsets.only(bottom: 0, top: 0),
                  child: Image(
                      image: currentIndex == 1
                          ? const AssetImage("assets/images/icons/search-1.png")
                          : const AssetImage("assets/images/icons/search.png"),
                      width: 24),
                ),
                label: ""),
            BottomNavigationBarItem(
                icon: currentIndex == 2
                    ? const Image(
                        image: AssetImage("assets/images/icons/add-square-1.png"),
                        width: 24)
                    : const Image(
                        image: AssetImage("assets/images/icons/add-square.png"),
                        width: 24),
                label: ""),
            BottomNavigationBarItem(
                icon: Image(
                    image: currentIndex == 3
                        ? const AssetImage("assets/images/icons/chatting-1.png")
                        : const AssetImage("assets/images/icons/chatting.png"),
                    width: 24),
                label: ""),
            BottomNavigationBarItem(
                icon: Image(
                    image: currentIndex == 4
                        ? const AssetImage("assets/images/icons/account-1.png")
                        : const AssetImage("assets/images/icons/account.png"),
                    width: 24),
                label: ""),
          ],
        ));
  }
}
