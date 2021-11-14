import 'package:flutter/material.dart';
import 'package:shop_app/modules/login/login_screen.dart';
import 'package:shop_app/shared/components/components.dart';
import 'package:shop_app/shared/network/local/cache_helper.dart';
import 'package:shop_app/shared/styles/colors.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class OnBoardingModel {
  final String image;
  final String title;
  final String body;
  OnBoardingModel({
    required this.image,
    required this.title,
    required this.body,
  });
}

class OnBoardingScreen extends StatefulWidget {
  const OnBoardingScreen({Key? key}) : super(key: key);

  @override
  State<OnBoardingScreen> createState() => _OnBoardingScreenState();
}

class _OnBoardingScreenState extends State<OnBoardingScreen> {
  PageController boardingController = PageController();

  List<OnBoardingModel> boardingList = [
    OnBoardingModel(
      image: 'assets/images/1.png',
      title: 'On Board 1 title',
      body: 'On Board 1 body',
    ),
    OnBoardingModel(
      image: 'assets/images/2.png',
      title: 'On Board 2 title',
      body: 'On Board 2 body',
    ),
    OnBoardingModel(
      image: 'assets/images/3.png',
      title: 'On Board 3 title',
      body: 'On Board 3 body',
    ),
  ];

  bool isLast = false;

  void submit() {
    CacheHelper.saveData(key: 'onBoarding', value: true).then((value) {
      if (value) {
        navigateAndFinish(
          context,
          LoginScreen(),
        );
      }  
      
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          TextButton(
            onPressed: () {
              submit();
            },
            child: Text(
              'SKIP',
            ),
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(30.0),
        child: Column(
          children: [
            Expanded(
              child: PageView.builder(
                physics: const BouncingScrollPhysics(),
                controller: boardingController,
                itemBuilder: (context, index) =>
                    buildOnBoardingItem(boardingList[index]),
                itemCount: boardingList.length,
                onPageChanged: (index) {
                  if (index == boardingList.length - 1) {
                    setState(() {
                      isLast = true;
                    });
                  } else {
                    setState(() {
                      isLast = false;
                    });
                  }
                },
              ),
            ),
            const SizedBox(
              height: 40.0,
            ),
            Row(
              children: [
                SmoothPageIndicator(
                  controller: boardingController,
                  count: boardingList.length,
                  effect: const ExpandingDotsEffect(
                    activeDotColor: defaultColor,
                  ),
                ),
                const Spacer(),
                FloatingActionButton(
                  onPressed: () {
                    if (isLast) {
                      submit();
                    } else {
                      boardingController.nextPage(
                        duration: Duration(seconds: 1),
                        curve: Curves.fastLinearToSlowEaseIn,
                      );
                    }
                  },
                  child: const Icon(
                    Icons.arrow_forward_ios,
                  ),
                )
              ],
            ),
          ],
        ),
      ),
    );
  }
}

Widget buildOnBoardingItem(OnBoardingModel model) => Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(
          child: Image(
            image: AssetImage(
              model.image,
            ),
          ),
        ),
        const SizedBox(
          height: 30.0,
        ),
        Text(
          model.title,
          style: const TextStyle(
            fontSize: 24.0,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(
          height: 10.0,
        ),
        Text(
          model.body,
          style: const TextStyle(
            fontSize: 16.0,
            fontWeight: FontWeight.bold,
          ),
        ),
      ],
    );
