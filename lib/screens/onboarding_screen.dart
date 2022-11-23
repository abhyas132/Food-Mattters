import 'package:flutter/material.dart';
import 'package:foods_matters/auth/screens/otp_screen.dart';
import 'package:introduction_screen/introduction_screen.dart';
import 'package:lottie/lottie.dart';

class OnBoardingPage extends StatefulWidget {
  @override
  _OnBoardingPageState createState() => _OnBoardingPageState();
}

class _OnBoardingPageState extends State<OnBoardingPage> {
  final introKey = GlobalKey<IntroductionScreenState>();

  void _onIntroEnd(context) {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (_) => const OTPScreen(),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    const bodyStyle = TextStyle(fontSize: 19.0);
    const pageDecoration = PageDecoration(
      titleTextStyle: TextStyle(fontSize: 28.0, fontWeight: FontWeight.w700),
      bodyTextStyle: bodyStyle,
      imagePadding: EdgeInsets.zero,
    );

    return IntroductionScreen(
      key: introKey,
      pages: [
        PageViewModel(
          title: "Donate extra prepared Food",
          body:
              "Instead of letting extra food go in waste, post it on Food matters so that it can reach to someone who needs it",
          image: Lottie.asset('assets/l1.json'),
          decoration: pageDecoration,
        ),
        PageViewModel(
          title: "NGO's and Needy poeple can take this extra food",
          body: "collabrate with food donars to share the extra food",
          image: Lottie.asset('assets/l4.json'),
          decoration: pageDecoration,
        ),
        PageViewModel(
          title: "Smart priorty based Algorithm",
          body:
              "Food Matters first push notification in 5 km from donars location to the Needies and as time passes it increases radius so that food lifespan can be preserve before it reaches a needy person",
          image: Lottie.asset('assets/l3.json'),
          decoration: pageDecoration,
        ),
      ],
      onDone: () => _onIntroEnd(context),
      onSkip: () => _onIntroEnd(context), // You can override onSkip callback
      showSkipButton: true,
      nextFlex: 0,
      skip: const Text('Skip'),
      next: const Icon(Icons.arrow_forward),
      done: const Text('Done', style: TextStyle(fontWeight: FontWeight.w600)),
      dotsDecorator: const DotsDecorator(
        size: Size(10.0, 10.0),
        color: Color(0xFFBDBDBD),
        activeSize: Size(22.0, 10.0),
        activeShape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(25.0)),
        ),
      ),
    );
  }
}
