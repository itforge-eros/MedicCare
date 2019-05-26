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

    this._slides.add(
          Slide(
            title: 'Medicines',
            //'ยา',
            description: 'Keep track on your medicine schedules.',
            //'บันทึกยาที่กำลังใช้ในปัจจุบัน',
            pathImage: 'assets/images/medical.png',
            backgroundColor: Color(0xff2196F3),
          ),
        );

    this._slides.add(
          Slide(
            title: 'Appointments',
            //'นัด',
            description: 'Never miss your doctor appointments again.',
            //'นัดที่ไหน เมื่อไหร่ ก็ไม่ลืม',
            pathImage: 'assets/images/note.png',
            backgroundColor: Color(0xff9AC4F8),
          ),
        );

    this._slides.add(
          Slide(
            title: 'Doctors',
            //'แพทย์',
            description: 'Keep information of your doctors.',
            //'กลับไปพบแพทย์เมื่อไหร่ก็ไม่พลาดวัน',
            pathImage: 'assets/images/doctor.png',
            backgroundColor: Color(0xffC3E1F8),
          ),
        );

    this._slides.add(
          Slide(
            title: 'Nearby Hospitals',
            //'โรงพยาบาลใกล้เคียง',
            description: 'Search for nearby hospitals in no time.',
            //'ค้นหาโรงพยาบาลได้ทันที',
            pathImage: 'assets/images/map.png',
            backgroundColor: Color(0xff87BFFF),
          ),
        );

    this._slides.add(
          Slide(
            title: 'All in one app',
            //'สรุปครบจบในที่เดียว',
            description: 'The hospital is in your hand.',
            //'โรงพยาบาลในมือคุณ',
            pathImage: 'assets/images/hospital.png',
            backgroundColor: Color(0xff306BAC),
          ),
        );
  }

  @override
  Widget build(BuildContext context) {
    return IntroSlider(
      slides: this._slides,
      onDonePress: () {
        Navigator.pop(context);
      },
    );
  }
}
