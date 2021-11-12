import 'package:final_620710128/models/covid_item.dart';
import 'package:final_620710128/pages/home/home_page.dart';
import 'package:final_620710128/services/api.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class CovidSumPage extends StatefulWidget {
  const CovidSumPage({Key? key}) : super(key: key);

  @override
  _CovidSumPageState createState() => _CovidSumPageState();
}

class _CovidSumPageState extends State<CovidSumPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          image: const DecorationImage(
            image: const AssetImage("assets/images/bg3.jpg"),
            fit: BoxFit.cover,
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.all(32.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Center(
                child: Column(
                  children: [
                    Text(
                      'รวมผู้ติดเชื้อทั้งหมด',
                      style: GoogleFonts.prompt(
                          fontSize: 30.0, color: Colors.white),
                    ),
                    Text(
                      '${HomePage.c1} คน',
                      style: GoogleFonts.prompt(
                          fontSize: 40.0,
                          color: Colors.white,
                          fontWeight: FontWeight.bold),
                    ),
                    Text(
                      ' ',
                      style: GoogleFonts.prompt(fontSize: 30.0),
                    ),
                    Text(
                      'รวมผู้เสียชีวิตทั้งหมด',
                      style:
                          GoogleFonts.prompt(fontSize: 30.0, color: Colors.red),
                    ),
                    Text(
                      '${HomePage.c2} คน',
                      style: GoogleFonts.prompt(
                          fontSize: 40.0,
                          color: Colors.red,
                          fontWeight: FontWeight.bold),
                    ),
                    Text(
                      ' ',
                      style: GoogleFonts.prompt(fontSize: 28.0),
                    ),
                    Text(
                      'ข้อมูล ณ วันที่ ${HomePage.d1}',
                      style: GoogleFonts.prompt(
                          fontSize: 20.0,
                          color: Colors.grey.shade400,
                          fontStyle: FontStyle.italic),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future<List<CovidItem>> _loadCovids() async {
    List list = await Api().fetch('api/Cases/today-cases-all');
    var covidlist = list.map((item) => CovidItem.fromJson(item)).toList();
    return covidlist;
  }
}
