import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import 'package:untitled/ui-screens/login-screen.dart';

import '../components/neu-text.dart';
import '../constants/constants.dart';
import '../models/onboarding-model.dart';

class OnBoardingScreen extends StatefulWidget {
  const OnBoardingScreen({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return OnBoardingState();
  }
}

class OnBoardingState extends State<OnBoardingScreen> {
  var pageController = PageController();
  bool islastScreen = false;

  List<OnBoardingModel> onboardingScreens = [
    OnBoardingModel(
      image: 'assets/onboarding-images/third.svg',
      text: 'let mission man to be your smart friend ',
    ),
    OnBoardingModel(
      image: 'assets/onboarding-images/first.svg',
      text: 'easily locate your new missions and ,\n'
          'and we will care about it .',
    ),
    OnBoardingModel(
        image: 'assets/onboarding-images/second.svg',
        text: 'determine what’s your priorities and,\n'
            'what is important, and what’s not. '),
    OnBoardingModel(
      image: 'assets/onboarding-images/fourth.svg',
      text:
          'add your located missions,and we will \n remind you about them and , \n draw a track for you.  ',
    ),
  ];
  void onsubmit() {
    Navigator.pushAndRemoveUntil(
        context, MaterialPageRoute(builder: (context) => const LoginScreen ()),
        (route) {
      return false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: AppBar(backgroundColor:scaffoldMainColor,),
      body: Padding(
        padding:
            const EdgeInsets.only(top: 40, left: 20, right: 20, bottom: 20),
        child: Container(
          margin: const EdgeInsets.only(top: 60),
          height: MediaQuery.of(context).size.height * 0.90,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: PageView.builder(
                  controller: pageController,
                  physics: const BouncingScrollPhysics(),
                  itemCount: 4,
                  itemBuilder: (context, index) {
                    return itemBuilder(context, onboardingScreens[index]);
                  },
                  onPageChanged: (index) {
                    if (index == onboardingScreens.length - 1) {
                      setState(() {
                        print('LAST');
                        islastScreen = true;
                      });
                    } else {
                      setState(() {
                        print(index);
                        islastScreen = false;
                      });
                    }
                  },
                ),
              ),
              const SizedBox(
                height: 30,
              ),
              Row(
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  TextButton(
                      onPressed: () {
                        // SharedPref_Helper.setDataToSharePref(key: 'onBoarding', value: true).then((value) {
                        //   print(value);
                        //   print ('yes');
                        // }).catchError((error ){
                        //   print ('error${error.toString()}');
                        // });
                        onsubmit();
                      },
                      child: Text(
                        'skip',
                        style: (Theme.of(context).textTheme.headline6)
                            ?.copyWith(
                                color: Colors.blue,
                                fontSize: 20,
                                fontWeight: FontWeight.w300),
                      )),
                  SmoothPageIndicator(
                    controller: pageController,
                    count: onboardingScreens.length,
                    effect: const ExpandingDotsEffect(
                        spacing: 8.0,
                        radius: 4.0,
                        dotWidth: 10.0,
                        dotHeight: 8.0,
                        paintStyle: PaintingStyle.fill,
                        strokeWidth: 1.5,
                        dotColor: Colors.grey,
                        activeDotColor: Colors.indigo),
                    onDotClicked: (index) {
                      setState(() {
                        pageController.animateToPage(index,
                            duration: const Duration(milliseconds: 1050),
                            curve: Curves.easeOutBack);
                      });
                    },
                  ),
                  Row(
                    children: [
                      TextButton(
                          onPressed: () {
                            if (islastScreen) {
                              setState(() {
                                onsubmit();
                              });
                            } else {
                              setState(() {
                                pageController.nextPage(
                                    duration:
                                        const Duration(milliseconds: 1050),
                                    curve: Curves.easeOutBack);
                              });
                            }
                          },
                          child: Text(
                            'next',
                            style: (Theme.of(context).textTheme.headline6)!
                                .copyWith(
                                    color: Colors.blue,
                                    fontSize: 20,
                                    fontWeight: FontWeight.w300),
                          )),
                      IconButton(
                          onPressed: () {
                            if (islastScreen) {
                              setState(() {
                                onsubmit();
                              });
                            } else {
                              setState(() {
                                pageController.nextPage(
                                    duration:
                                        const Duration(milliseconds: 1050),
                                    curve: Curves.easeOutBack);
                              });
                            }
                          },
                          icon: const Icon(
                            Icons.arrow_forward_ios,
                            color: Colors.blue,
                          ))
                    ],
                  )
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}

Widget itemBuilder(BuildContext context, OnBoardingModel model) {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    mainAxisSize: MainAxisSize.min,
    children: [
      SvgPicture.asset(
        model.image!,
        fit: BoxFit.contain,
        height: 300,
        width: MediaQuery.of(context).size.width * 0.99,
      ),
      const SizedBox(
        height: 30,
      ),
      PublicNeumoText(
        text: model.text!,
        color: onBoardingTextColor,
        size: 16,
      )
    ],
  );
}
