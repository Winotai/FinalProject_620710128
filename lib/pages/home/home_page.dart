import 'package:final_620710128/pages/covids/covidsum_page.dart';
import 'package:final_620710128/pages/covids/covid_page.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class HomePage extends StatefulWidget {
  static const routeName = '/home';
  static var d1 = 'DATE';
  static int c1 = 0;
  static int c2 = 0;
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  var _subPageIndex = 0;
  CovidPage? _currentPage = CovidPage();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.yellow,
        title: Text(
          'COVID-19 DAILY',
          style: GoogleFonts.anton(fontSize: 25.0),
        ),
        actions: [
          _subPageIndex == 0
              ? IconButton(
                  onPressed: () {},
                  icon: Icon(Icons.refresh),
                )
              : SizedBox.shrink(),
        ],
      ),
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            DrawerHeader(
              decoration: BoxDecoration(
                color: Colors.yellow,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  ClipRRect(
                      child: Container(
                    height: 95.0,
                    child: Image.asset('assets/images/logo.png'),
                  )),
                  Padding(
                    padding: const EdgeInsets.only(top: 4.0, bottom: 1.0),
                    child: Text(
                      'COVID-19 DAILY',
                      style: GoogleFonts.anton(fontSize: 25.0),
                    ),
                  ),
                ],
              ),
            ),
            ListTile(
              title: _buildDrawerItem(Icons.coronavirus_sharp,
                  'จำนวนผู้ติดเชื้อและผู้เสียชีวิต', 0),
              onTap: () {
                _showSubPage(context, 0);
              },
            ),
            ListTile(
              title:
                  _buildDrawerItem(Icons.calendar_view_day, 'รวมทั้งประเทศ', 1),
              onTap: () {
                _showSubPage(context, 1);
              },
            ),
          ],
        ),
      ),
      body: _buildSubPage(),
    );
  }

  dynamic _buildSubPage() {
    switch (_subPageIndex) {
      case 0:
        return _currentPage;
      case 1:
        return CovidSumPage();
      default:
        return null;
    }
  }

  Row _buildDrawerItem(IconData icon, String title, int onFocus) {
    return Row(
      children: [
        Icon(icon, color: _subPageIndex == onFocus ? Colors.yellow : null),
        SizedBox(width: 8.0),
        Text(title,
            style: _subPageIndex == onFocus
                ? GoogleFonts.prompt(fontSize: 20.0)
                : GoogleFonts.prompt(fontSize: 15.0)),
      ],
    );
  }

  void _showSubPage(BuildContext context, int page) {
    setState(() {
      _subPageIndex = page;
      _currentPage = page == 0 ? CovidPage() : null;
    });
    Navigator.of(context).pop();
  }
}
