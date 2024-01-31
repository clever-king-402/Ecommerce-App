import 'package:ecommerce_app/common/assets.dart';
import 'package:ecommerce_app/common/services/shared_pre_data.dart';
import 'package:ecommerce_app/features/auth/ui/screens/login_page.dart';
import 'package:faker/faker.dart';
import 'package:flutter/material.dart';
import 'package:introduction_screen/introduction_screen.dart';
import 'package:page_transition/page_transition.dart';

class OnBoardingBody extends StatelessWidget {
  const OnBoardingBody({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: IntroductionScreen(
        pages: [
          PageViewModel(
            image: Image.asset(
              Assets.logo,
              height: 180,
            ),
            title: "Introduction 1",
            body: Faker().lorem.sentences(5).join(". "),
          ),
          PageViewModel(
            image: Image.asset(
              Assets.logo,
              height: 180,
            ),
            title: "Introduction 2",
            body: Faker().lorem.sentences(5).join(". "),
          ),
          PageViewModel(
            image: Image.asset(
              Assets.logo,
              height: 180,
            ),
            title: "Introduction 3",
            body: Faker().lorem.sentences(5).join(". "),
          ),
        ],
        done: Text("Done"),
        onDone: ()async {
           await SharedPrefServices.setAppOpenFlag();
            Navigator.of(context).pushAndRemoveUntil(
            PageTransition(
              child: LoginPage(),
              type: PageTransitionType.fade,
            ),
            (route) => false,
          );
        },
        showSkipButton: true,
        next: Text("Next"),
        skip: Text("skip"),
        onSkip: ()async {
           await SharedPrefServices.setAppOpenFlag();
            Navigator.of(context).pushAndRemoveUntil(
            PageTransition(
              child: LoginPage(),
              type: PageTransitionType.fade,
            ),
            (route) => false,
          );
        },
      ),
    );
  }
}
