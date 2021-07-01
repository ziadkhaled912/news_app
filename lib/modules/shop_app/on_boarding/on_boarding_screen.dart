import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:news_app/modules/shop_app/login/login_screen.dart';
import 'package:news_app/modules/shop_app/register/register_screen.dart';
import 'package:news_app/shared/componants/componants.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class BoardingModel {
  final String image;
  final String title;
  final String body;
  final bool last;
  BoardingModel({
    @required this.image,
    @required this.title,
    @required this.body,
    this.last = false,
  });
}

class OnBoardingScreen extends StatefulWidget {

  @override
  _OnBoardingScreenState createState() => _OnBoardingScreenState();
}

class _OnBoardingScreenState extends State<OnBoardingScreen> {

    // boarding list
    List<BoardingModel> boarding = [
      BoardingModel(
          image: "assets/images/onboard_1.png",
          title: "Welcome To Khourshed",
          body: 'Khourshed Store is on the way to serve you',
      ),
      BoardingModel(
          image: "assets/images/onboard_1.png",
          title: "Title 2",
          body: 'subtitle 2',
      ),
      BoardingModel(
          image: "assets/images/onboard_1.png",
          title: "Let's Get Started",
          body: 'subtitle 3',
        last: true,
      ),
    ];

    PageController boardController = PageController(); // PageView Controller

    bool isLast = false;

    @override
    Widget build(BuildContext context) {
      SystemChrome.setPreferredOrientations([
        DeviceOrientation.portraitUp,
        DeviceOrientation.portraitDown,
      ]);
    return Scaffold(
      // appBar: AppBar(),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              Directionality(
                textDirection: TextDirection.rtl,
                child: Row(
                  children: [
                    TextButton(
                        onPressed: () {},
                        child: Text(
                          'عربية',
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.w700,
                            color: Colors.red,
                          ),
                          // textAlign: TextAlign.right,
                        ),
                    ),
                  ],
                ),
              ),
              Expanded(
                child: PageView.builder(
                  controller: boardController,
                  physics: BouncingScrollPhysics(),
                  itemBuilder: (context, index) => buildBoardingItem(boarding[index]),
                  itemCount: boarding.length,
                  onPageChanged: (int index) {
                    if(index == boarding.indexOf(boarding.last)) {
                      setState(() {
                        isLast = true;
                      });
                    }
                    else {
                      setState(() {
                        isLast = false;
                      });
                    }
                  },
                ),
              ),
              Row(
                children: [
                  TextButton(
                      onPressed: () {
                        boardController.animateToPage(
                          boarding.indexOf(boarding.last),
                          duration: Duration(
                            milliseconds: 700,
                          ),
                          curve: Curves.easeInOutQuad,
                        );
                      },
                      child: isLast ? Container() :
                      Text(
                      'Skip',
                      style: TextStyle(
                        color: Colors.black,
                      ),
                  ),
                  ),
                  Expanded(
                    child: Center(
                      child: SmoothPageIndicator(
                        controller: boardController,
                        count: boarding.length,
                        effect: ExpandingDotsEffect(
                          dotColor: Colors.grey,
                          activeDotColor: Colors.red,
                          dotHeight: 10,
                          dotWidth: 10,
                          expansionFactor: 4,
                          spacing: 5,
                        ),
                      ),
                    ),
                  ),
                  TextButton(
                      onPressed: () {
                        if(isLast){
                          // navigateToAndFinish(context, ShopScreen());
                        } else {
                          boardController.nextPage(
                            duration: Duration(
                              milliseconds: 700,
                            ),
                            curve: Curves.easeInOutQuad,
                          );
                        }
                      },
                      child: isLast ? Text(
                        'Done',
                        style: TextStyle(
                          color: Colors.black,
                        ),
                      ) : Text(
                        'Next',
                        style: TextStyle(
                          color: Colors.black,
                        ),
                      )
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget buildBoardingItem(BoardingModel model) => Padding(
        padding: const EdgeInsets.all(15.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              '${model.title}',
              style: TextStyle(
                fontSize: 25,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 50),
            Image(
              image: AssetImage('${model.image}'),
            ),
            SizedBox(height: 50),
            if(model.last)
              Column(
                children: [
                  defaultButton(
                    onPressed: () {
                      navigateTo(context, LoginScreen());
                    },
                    text: 'sign in',
                    height: 48,
                    border: Colors.black,
                    isUpperCase: true,
                  ),
                  SizedBox(height: 20),
                  defaultButton(
                    onPressed: () {
                      navigateTo(context, RegisterScreen());
                    },
                    text: 'create account',
                    height: 50,
                    isUpperCase: true,
                    background: Colors.red,
                    textColor: Colors.white,
                  ),
                ],
              ),
            if(model.last == false)
                Text(
                  '${model.body}',
                  style: Theme.of(context).textTheme.bodyText2,
                ),
            SizedBox(height: 50),
          ],
        ),
  );
}
