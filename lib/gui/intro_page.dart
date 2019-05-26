///
/// intro_page.dart
/// Class for intro page GUI
/// by Supakit Theanthunyakit (@POKINBKK)
///

import 'package:flutter/material.dart';
import 'package:intro_slider/intro_slider.dart';

class IntroPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return IntroPageState();
  }
}

class IntroPageState extends State<IntroPage> {
  List<Slide> slideshow = List();

  @override
  void initState() {
    super.initState();

    this.slideshow.add(
          new Slide(
            title: 'Medicines',
            //'ยา',
            description: 'Keep track on your medicine schedules.',
            //'บันทึกยาที่กำลังใช้ในปัจจุบัน',
            pathImage: 'assets/images/medical.png',
            colorBegin: Color(0xffF09819),
            colorEnd: Color(0xffFF512F),
          ),
        );

    this.slideshow.add(
          new Slide(
            title: 'Appointments',
            //'นัด',
            description: 'Never miss your doctor appointments again.',
            //'นัดที่ไหน เมื่อไหร่ ก็ไม่ลืม',
            pathImage: 'assets/images/note.png',
            colorBegin: Color(0xfff857a6),
            colorEnd: Color(0xffff5858),
          ),
        );

    this.slideshow.add(
          new Slide(
            title: 'Doctors',
            //'แพทย์',
            description: 'Keep information of your doctors.',
            //'กลับไปพบแพทย์เมื่อไหร่ก็ไม่พลาดวัน',
            pathImage: 'assets/images/doctor.png',
            colorBegin: Color(0xff00c6ff),
            colorEnd: Color(0xff0072ff),
          ),
        );

    this.slideshow.add(
          new Slide(
            title: 'Nearby Hospitals',
            //'โรงพยาบาลใกล้เคียง',
            description: 'Search for nearby hospitals in no time.',
            //'ค้นหาโรงพยาบาลได้ทันที',
            pathImage: 'assets/images/map.png',
            colorBegin: Color(0xffa044ff),
            colorEnd: Color(0xff6a3093),
          ),
        );

    this.slideshow.add(
          new Slide(
            title: 'All in one app',
            //'สรุปครบจบในที่เดียว',
            description: 'The hospital is in your hand.',
            //'โรงพยาบาลในมือคุณ',
            pathImage: 'assets/images/hospital.png',
            colorBegin: Color(0xff56CCF2),
            colorEnd: Color(0xff2F80ED),
          ),
        );
  }

  void onDonePress() {
    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    return IntroSlider(
      slides: this.slideshow,
      onDonePress: this.onDonePress);
  }
}
