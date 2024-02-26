import 'package:flutter/material.dart';

import '../../widgets/app_large_text.dart';
import '../../widgets/app_text.dart';
import '../auth_pages/auth_page.dart';

class WelcomePage extends StatefulWidget {
  const WelcomePage({super.key});
  static const routeName = '/welcomePage';

  @override
  State<WelcomePage> createState() => _WelcomePageState();
}

class _WelcomePageState extends State<WelcomePage> {
  int pageNumber = 0;

  List<String> mainTitle1 = ['The Simple Way to', 'The Best Design'];
  List<String> mainTitle2 = ['find the best!', 'Strategy'];
  List<String> imageIcons = ['OkIcon.png', 'HandIcon.png'];
  List<String> images = ['welcome1.png', 'welcome2.png'];
  List<String> description = [
    'Aenean eu lacinia ligula. Quisque eu risus erat. Aenean placerat sollicitudin lectus.',
    'Aenean eu lacinia ligula. Quisque eu risus erat. Aenean placerat sollicitudin lectus.',
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xff3B4054),
      body: SafeArea(
        child: Container(
          padding: EdgeInsets.symmetric(vertical: 70, horizontal: 20),
          child: Stack(
            alignment: Alignment.bottomCenter,
            children: [
              PageView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: 2,
                onPageChanged: (value) {
                  setState(() {
                    pageNumber = value;
                  });
                },
                itemBuilder: (_, index) {
                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Container(
                        height: 250,
                        decoration: BoxDecoration(
                            image: DecorationImage(
                          image: AssetImage(
                            'assets/welcome_images/' + images[index],
                          ),
                        )),
                      ),
                      SizedBox(
                        height: 50,
                      ),
                      AppLargeText(
                        text: mainTitle1[index],
                        color: Colors.white,
                        size: 25,
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          AppText(
                            text: mainTitle2[index],
                            color: Color(0xffE0E5EC),
                            size: 23,
                          ),
                          SizedBox(
                            width: 1,
                          ),
                          Container(
                            height: 40,
                            width: 40,
                            decoration: BoxDecoration(
                                image: DecorationImage(
                                    image: AssetImage(
                                      'assets/welcome_images/' +
                                          imageIcons[index],
                                    ),
                                    fit: BoxFit.cover)),
                          )
                        ],
                      ),
                      SizedBox(
                        height: 50,
                      ),
                      AppText(
                        text: description[index],
                        color: Color(0xffC8D2DE),
                        align: TextAlign.center,
                      ),
                    ],
                  );
                },
              ),
              Container(
                width: double.maxFinite,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Spacer(
                      flex: 3,
                    ),
                    Row(
                      children: List.generate(
                        2,
                        (indexSlider) {
                          return AnimatedContainer(
                            margin: EdgeInsets.only(right: 15),
                            // curve: Curves.easeIn,
                            duration: Duration(milliseconds: 500),
                            height: 8,
                            width: pageNumber == indexSlider ? 40 : 10,
                            decoration: BoxDecoration(
                                color: pageNumber == indexSlider
                                    ? Colors.blue
                                    : Colors.white,
                                borderRadius: BorderRadius.circular(8)),
                          );
                        },
                      ),
                    ),
                    Spacer(
                      flex: 2,
                    ),
                    TextButton(
                      onPressed: () {
                        Navigator.pushNamed(context, AuthPage.routeName);
                      },
                      child: AppText(
                        text: 'Next',
                        color: Colors.white,
                      ),
                    )
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
