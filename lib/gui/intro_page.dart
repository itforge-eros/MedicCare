import 'package:flutter/material.dart';
import 'package:intro_slider/intro_slider.dart';

class IntroPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return IntroPageState();
  }
}

class IntroPageState extends State<IntroPage> {
  List<Slide> slides = new List();

  @override
  void initState() {
    super.initState();

    slides.add(
      new Slide(
        title: 'Medicines',
        styleTitle: TextStyle(
          color: Colors.black,
          fontSize: 30.0,
        ),
        description:
            'Keep track on your medicine schedules.',
        styleDescription: TextStyle(
          color: Colors.black,
          fontSize: 16,
        ),
        pathImage: 'assets/images/medical.png',
        colorBegin: Color(0xff00F260),
        colorEnd: Color(0xff0575E6),
      ),
    );
    slides.add(
      new Slide(
        title: 'Appointments',
        styleTitle: TextStyle(
          color: Colors.black,
          fontSize: 30,
        ),
        description:
            'Never miss your doctor appointments again.',
        styleDescription: TextStyle(
          color: Colors.black,
          fontSize: 16,
        ),
            pathImage: 'assets/images/note.png',
            colorBegin: Color(0xffff6a00),
            colorEnd: Color(0xffee0979),
      ),
    );
    slides.add(
      new Slide(
        title: 'Doctors',
        styleTitle: TextStyle(
          color: Colors.black,
          fontSize: 30,
        ),
        description: 'Keep information of your doctors.',
        styleDescription: TextStyle(
          color: Colors.black,
          fontSize: 16,
        ),
            pathImage: 'assets/images/doctor.png',
            colorBegin: Color(0xff4776E6),
            colorEnd: Color(0xff8E54E9),
      ),
    );
    slides.add(
      new Slide(
        title: 'Nearby Hospitals',
        styleTitle: TextStyle(
          color: Colors.black,
          fontSize: 30,
        ),
        description:
            'Search for nearby hospitals in no time.',
        styleDescription: TextStyle(
          color: Colors.black,
          fontSize: 16,
        ),
            pathImage: 'assets/images/map.png',
            colorBegin: Color(0xff0575E6),
            colorEnd: Color(0xff021B79),
      ),
    );
    slides.add(
      new Slide(
        title: 'All in one app',
        styleTitle: TextStyle(
          color: Colors.black,
          fontSize: 30.0,
        ),
        description: 'The hospital is in your hand.',
        styleDescription: TextStyle(
          color: Colors.black,
          fontSize: 16.0,
        ),
            pathImage: 'assets/images/hospital.png',
            colorBegin: Color(0xff00c6ff),
            colorEnd: Color(0xff0072ff),
      ),
    );
  }

  void onDonePress() {
    // Do what you want
    Navigator.pop(context);
  }

  void onTabChangeCompleted(index) {
    // Index of current tab is focused
  }

  Widget renderNextBtn() {
    return Icon(
      Icons.navigate_next,
      color: Colors.white,
      size: 35.0,
    );
  }

  Widget renderDoneBtn() {
    return Icon(Icons.done, color: Colors.white);
  }

  Widget renderSkipBtn() {
    return Icon(
      Icons.skip_next,
      color: Colors.white,
    );
  }

  List<Widget> renderListCustomTabs() {
    List<Widget> tabs = new List();
    for (int i = 0; i < slides.length; i++) {
      Slide currentSlide = slides[i];
      tabs.add(Container(
        width: double.infinity,
        height: double.infinity,
        child: Container(
          margin: EdgeInsets.only(bottom: 60.0, top: 60.0),
          child: ListView(
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.fromLTRB(0, 20, 0, 0),
              ),
              GestureDetector(
                  child: Image.asset(
                currentSlide.pathImage,
                width: 200.0,
                height: 200.0,
                fit: BoxFit.contain,
              )),
              Container(
                child: Text(
                  currentSlide.title,
                  style: currentSlide.styleTitle,
                  textAlign: TextAlign.center,
                ),
                margin: EdgeInsets.only(top: 20.0),
              ),
              Container(
                child: Text(
                  currentSlide.description,
                  style: currentSlide.styleDescription,
                  textAlign: TextAlign.center,
                  maxLines: 5,
                  overflow: TextOverflow.ellipsis,
                ),
                margin: EdgeInsets.only(top: 20.0),
              ),
            ],
          ),
        ),
      ));
    }
    return tabs;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: new IntroSlider(
          // List slides
          slides: this.slides,
          // Skip button
          renderSkipBtn: this.renderSkipBtn(),
          colorSkipBtn: Color(0xff0072ff),
          highlightColorSkipBtn: Color(0xff00c6ff),

          // Next button
          renderNextBtn: this.renderNextBtn(),

          // Done button
          renderDoneBtn: this.renderDoneBtn(),
          onDonePress: this.onDonePress,
          colorDoneBtn: Color(0xff0072ff),
          highlightColorDoneBtn: Color(0xff00c6ff),

          // Dot indicator
          colorDot: Color(0xff00d2ff),
          colorActiveDot: Color(0xff3a7bd5),
          sizeDot: 13.0,

          // List custom tabs
          listCustomTabs: this.renderListCustomTabs(),

          // Show or hide status bar
          shouldHideStatusBar: true,

          // On tab change completed
          onTabChangeCompleted: this.onTabChangeCompleted,
        ),
      ),
    );
  }
}