import 'package:covid_19/model/covid_model.dart';
import 'package:covid_19/services/http_service.dart';
import 'package:covid_19/utils/api_string.dart';
import 'package:covid_19/utils/colors.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  HttpService httpService = HttpService();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Covid - 19", style: TextStyle(fontSize: 20, color: CovidColor.black),),
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          children: [
            CupertinoSearchTextField(
              backgroundColor: CovidColor.white,
              onChanged: (val){
                setState(() {
                  ApiUtils.search.value = val;
                });
              },
            ),
            Expanded(
              child: FutureBuilder(
                future: HttpService().getCovidResponse(),
                builder: (context, snapshot) {
                  if(snapshot.hasData) {
                    List<Covid> data = snapshot.data;
                    return ListView.builder(
                      physics: const BouncingScrollPhysics(),
                      padding: const EdgeInsets.symmetric(vertical: 20),
                      itemCount: data.length,
                      itemBuilder: (context, index) {
                        var widget = ClipRRect(
                          borderRadius: BorderRadius.circular(20),
                          child: Container(
                            margin: const EdgeInsets.symmetric(vertical: 5),
                            decoration: BoxDecoration(
                              color: CovidColor.white,
                              borderRadius: BorderRadius.circular(20),
                            ),
                            child: ExpansionTile(
                              leading: SizedBox(width: 50,child: Image.network("${data[index].countryInfo!.flag}",)),
                              tilePadding: const EdgeInsets.symmetric(horizontal: 15),
                              title: Text("${data[index].country}", style: GoogleFonts.poppins(color: CovidColor.black),),
                              // subtitle: Text("${data[index].cases}", style: GoogleFonts.poppins(color: CovidColor.grey),),
                              expandedAlignment: Alignment.centerLeft,
                              childrenPadding: const EdgeInsets.all(10),
                              expandedCrossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text("Total Cases : ${data[index].cases}"),
                                Text("Today Cases : ${data[index].todayCases}"),
                                Text("Active Cases : ${data[index].active}"),
                                Text("Critical Cases : ${data[index].critical}"),
                                Text("Total Deaths : ${data[index].deaths}"),
                                Text("Today Deaths : ${data[index].todayDeaths}"),
                                Text("Total Recovered : ${data[index].recovered}"),
                                Text("Today Recovered : ${data[index].todayRecovered}"),
                                Text("Tests : ${data[index].tests}"),
                                Text("Continent : ${data[index].continent}"),
                              ],
                            ),
                          ),
                        );
                        if(ApiUtils.search.value != '') {
                          if(data[index].country!.toUpperCase().contains(ApiUtils.search.value.toUpperCase())) {
                            return widget;
                          }
                        } else {
                          return widget;
                        }
                        return Container();
                      },
                    );
                  } else {
                    return const Center(child: CircularProgressIndicator());
                  }
                },
              ),
            ),
          ],
        ),
      ),
      backgroundColor: CovidColor.bgColor,
    );
  }
}
