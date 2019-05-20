import 'dart:io';
import 'package:flutter/material.dart';
import 'package:intro_slider/intro_slider.dart';

class IntroPage extends StatefulWidget{
  @override
  State<StatefulWidget> createState() {
    return _IntroPageState();
  }

}

class _IntroPageState extends State<IntroPage> {

  List<Slide> slides = new List();

  @override
  void initState() {
    super.initState();

    slides.add(
      new Slide(
        title: "ยา",
        description: "บันทึกยาที่กำลังใช้ในปัจจุบัน",
        pathImage: 'assets/images/medical.png',
        backgroundColor: Color(0xff2196F3),
      ),
    );
    slides.add(
      new Slide(
        title: "นัด",
        description: "นัดที่ไหน เมื่อไหร่ ก็ไม่ลืม",
        pathImage: 'assets/images/note.png',
        backgroundColor: Color(0xff9AC4F8),
      ),
    );
    slides.add(
      new Slide(
        title: "แพทย์",
        description: "กลับไปพบแพทย์เมื่อไหร่ก็ไม่พลาดวัน",
        pathImage: 'assets/images/doctor.png',
        backgroundColor: Color(0xffC3E1F8),
      ),
    );

    slides.add(
      new Slide(
        title: "โรงพยาบาลใกล้ๆ",
        description: "ค้นหาโรงพยาบาลได้ทันที",
        pathImage: 'assets/images/map.png',
        backgroundColor: Color(0xff87BFFF),
      ),
    );

    slides.add(
      new Slide(
        title: "สรุปครบจบในที่เดียว",
        description: "โรงพยาบาลในมือคุณ",
        pathImage: 'assets/images/hospital.png',
        backgroundColor: Color(0xff306BAC),
      ),
    );
  }

  void onDonePress() {
    Navigator.pushReplacementNamed(context, 'HomePage');
  }

  @override
  Widget build(BuildContext context) {
    return new IntroSlider(
      slides: this.slides,
      onDonePress: this.onDonePress,
    );
  }

}