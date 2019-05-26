///
/// `intro_page.dart`
/// Class for intro page GUI
/// by Supakit Theanthunyakit (@POKINBKK)
///

import 'package:flutter/material.dart';
import 'package:intro_slider/intro_slider.dart';

class IntroPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _IntroPageState();
  }
}

class _IntroPageState extends State<IntroPage> {
  List<Slide> _slides = List();

  @override
  void initState() {
    super.initState();

    _slides.add(
          Slide(
            title: 'Medicines',
            //'ยา',
            description: 'Keep track on your medicine schedules.',
            //'บันทึกยาที่กำลังใช้ในปัจจุบัน',
            pathImage: 'assets/images/medical.png',
            colorBegin: Color(0xff00F260),
            colorEnd: Color(0xff0575E6),
          ),
        );

    _slides.add(
          Slide(
            title: 'Appointments',
            //'นัด',
            description: 'Never miss your doctor appointments again.',
            //'นัดที่ไหน เมื่อไหร่ ก็ไม่ลืม',
            pathImage: 'assets/images/note.png',
            colorBegin: Color(0xffff6a00),
            colorEnd: Color(0xffee0979),
          ),
        );

    _slides.add(
          Slide(
            title: 'Doctors',
            //'แพทย์',
            description: 'Keep information of your doctors.',
            //'กลับไปพบแพทย์เมื่อไหร่ก็ไม่พลาดวัน',
            pathImage: 'assets/images/doctor.png',
            colorBegin: Color(0xff4776E6),
            colorEnd: Color(0xff8E54E9),
          ),
        );

    _slides.add(
          Slide(
            title: 'Nearby Hospitals',
            //'โรงพยาบาลใกล้เคียง',
            description: 'Search for nearby hospitals in no time.',
            //'ค้นหาโรงพยาบาลได้ทันที',
            pathImage: 'assets/images/map.png',
            colorBegin: Color(0xff0575E6),
            colorEnd: Color(0xff021B79),
          ),
        );

    _slides.add(
          Slide(
            title: 'All in one app',
            //'สรุปครบจบในที่เดียว',
            description: 'The hospital is in your hand.',
            //'โรงพยาบาลในมือคุณ',
            pathImage: 'assets/images/hospital.png',
            colorBegin: Color(0xff00c6ff),
            colorEnd: Color(0xff0072ff),
          ),
        );
  }

  @override
  Widget build(BuildContext context) {
    return IntroSlider(
      slides: _slides,
      onDonePress: () {
        Navigator.pop(context);
      },
    );
  }
}
