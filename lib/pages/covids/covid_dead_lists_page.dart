import 'package:google_fonts/google_fonts.dart';
import 'package:flutter/material.dart';
import 'package:final_620710128/models/covid_item.dart';
import 'package:final_620710128/services/api.dart';

class CovidDeadListsPage extends StatefulWidget {
  const CovidDeadListsPage({Key? key}) : super(key: key);

  @override
  _CovidDeadListsPageState createState() => _CovidDeadListsPageState();
}

class _CovidDeadListsPageState extends State<CovidDeadListsPage> {
  late Future<List<CovidItem>> _futureCovidList;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          image: const DecorationImage(
            image: const AssetImage("assets/images/bg2.png"),
            fit: BoxFit.cover,
          ),
        ),
        child: FutureBuilder<List<CovidItem>>(
          future: _futureCovidList,
          builder: (context, snapshot) {
            if (snapshot.connectionState != ConnectionState.done) {
              return Center(
                child: CircularProgressIndicator(),
              );
            }
            if (snapshot.hasError) {
              return Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text('ผิดพลาด: ${snapshot.error}'),
                    ElevatedButton(
                      onPressed: () {
                        setState(() {
                          _futureCovidList = _loadCovids();
                        });
                      },
                      child: Text('RETRY'),
                    ),
                  ],
                ),
              );
            }

            if (snapshot.hasData) {
              return ListView.builder(
                padding: EdgeInsets.all(8.0),
                itemCount: snapshot.data!.length,
                itemBuilder: (BuildContext context, int index) {
                  var covidItem = snapshot.data![index];

                  return Card(
                    color: Colors.white.withOpacity(0.8),
                    clipBehavior: Clip.antiAliasWithSaveLayer,
                    margin: EdgeInsets.all(8.0),
                    elevation: 5.0,
                    shadowColor: Colors.black.withOpacity(0.2),
                    child: InkWell(
                      onTap: null,
                      child: Row(
                        children: <Widget>[
                          Column(
                            children: <Widget>[
                              Text(
                                ' ${covidItem.province}',
                                style: GoogleFonts.prompt(
                                    fontSize: 20.0,
                                    fontWeight: FontWeight.bold),
                              ),
                              Text(
                                ' ข้อมูล ณ วันที่ ${covidItem.txn_date}',
                                style: GoogleFonts.prompt(
                                    fontSize: 11.0,
                                    fontStyle: FontStyle.italic),
                              ),
                            ],
                          ),
                          Expanded(
                            child: Container(
                              padding: EdgeInsets.all(10.0),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: <Widget>[
                                  Column(
                                    crossAxisAlignment: CrossAxisAlignment.end,
                                    children: <Widget>[
                                      Text(
                                        'ยอดผู้เสียชีวิตวันนี้ ${covidItem.new_death.toString()} คน',
                                        style:
                                            GoogleFonts.prompt(fontSize: 15.0),
                                      ),
                                      Text(
                                        'ยอดรวมผู้เสียชีวิต ${covidItem.total_death.toString()} คน',
                                        style:
                                            GoogleFonts.prompt(fontSize: 15.0),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                },
              );
            }

            return SizedBox.shrink();
          },
        ),
      ),
    );
  }

  Future<List<CovidItem>> _loadCovids() async {
    List list = await Api().fetch('api/Cases/today-cases-by-provinces');
    var covidList = list.map((item) => CovidItem.fromJson(item)).toList();
    return covidList;
  }

  @override
  initState() {
    super.initState();
    _futureCovidList = _loadCovids();
  }
}
