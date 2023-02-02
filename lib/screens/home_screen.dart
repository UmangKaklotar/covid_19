import 'package:covid_19/model/country_model.dart';
import 'package:covid_19/utils/api_string.dart';
import 'package:covid_19/utils/colors.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../function/country_response.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
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
              placeholderStyle: GoogleFonts.poppins(color: CovidColor.grey),
              style: GoogleFonts.poppins(),
              onChanged: (val){
                setState(() {
                  ApiUtils.searchCountry.value = val;
                });
              },
            ),
            Expanded(
              child: FutureBuilder(
                future: getCountryResponse(),
                builder: (context, snapshot) {
                  if(snapshot.hasData) {
                    List<AllCountry> country = snapshot.data;
                    return ListView.builder(
                      physics: const BouncingScrollPhysics(),
                      padding: const EdgeInsets.symmetric(vertical: 20),
                      itemCount: country.length,
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
                              leading: SizedBox(width: 50,child: Image.network("${country[index].countryInfo!.flag}",)),
                              tilePadding: const EdgeInsets.symmetric(horizontal: 15),
                              title: Text("${country[index].country}", style: GoogleFonts.poppins(color: CovidColor.black),),
                              expandedAlignment: Alignment.centerLeft,
                              childrenPadding: const EdgeInsets.all(10),
                              expandedCrossAxisAlignment: CrossAxisAlignment.start,
                              trailing: GestureDetector(
                                onTap: () {
                                  setState(() {
                                    ApiUtils.country = country[index].country.toString();
                                    Navigator.pushNamed(context, 'state');
                                  });
                                },
                                child: Icon(CupertinoIcons.info, color: CovidColor.black,),
                              ),
                              children: [
                                Text("Total Cases : ${country[index].cases}"),
                                Text("Today Cases : ${country[index].todayCases}"),
                                Text("Active Cases : ${country[index].active}"),
                                Text("Critical Cases : ${country[index].critical}"),
                                Text("Total Deaths : ${country[index].deaths}"),
                                Text("Today Deaths : ${country[index].todayDeaths}"),
                                Text("Total Recovered : ${country[index].recovered}"),
                                Text("Today Recovered : ${country[index].todayRecovered}"),
                                Text("Tests : ${country[index].tests}"),
                                Text("Continent : ${country[index].continent}"),
                              ],
                            ),
                          ),
                        );
                        if(ApiUtils.searchCountry.value != '') {
                          if(country[index].country!.toUpperCase().contains(ApiUtils.searchCountry.value.toUpperCase())) {
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
