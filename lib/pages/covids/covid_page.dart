import 'dart:convert';

import 'package:final_620710128/models/covid_item.dart';
import 'package:final_620710128/pages/home/home_page.dart';
import 'package:final_620710128/pages/covids/covid_lists_page.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import 'covid_dead_lists_page.dart';

class CovidPage extends StatefulWidget {
  const CovidPage({Key? key}) : super(key: key);

  @override
  _CovidPageState createState() => _CovidPageState();
}

class _CovidPageState extends State<CovidPage> {
  var _selectedBottomNavIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: BottomNavigationBar(
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.coronavirus_outlined),
            label: 'จำนวนผู้ติดเชื้อ',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.warning_rounded),
            label: 'จำนวนผู้เสียชีวิต',
          ),
        ],
        currentIndex: _selectedBottomNavIndex,
        onTap: (index) {
          setState(() {
            _selectedBottomNavIndex = index;
          });
        },
        selectedItemColor: Colors.black,
        unselectedItemColor: Colors.grey,
      ),
      body: Container(
        child: (_selectedBottomNavIndex == 0)
            ? CovidListsPage()
            : CovidDeadListsPage(),
      ),
    );
  }
}
