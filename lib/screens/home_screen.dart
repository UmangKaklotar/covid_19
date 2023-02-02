import 'package:animated_custom_dropdown/custom_dropdown.dart';
import 'package:covid_19/function/state_response.dart';
import 'package:covid_19/model/country_model.dart';
import 'package:covid_19/model/state_model.dart';
import 'package:covid_19/utils/api_string.dart';
import 'package:covid_19/utils/controller.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../function/country_response.dart';
import '../utils/colors.dart';

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
            FutureBuilder(
              future: getCountryResponse(),
              builder: (context, snapshot) {
                if(snapshot.hasData) {
                  List<Cs> country = snapshot.data;
                  return CustomDropdown.search(
                    hintText: 'Select Country',
                    hintStyle: GoogleFonts.poppins(),
                    selectedStyle: GoogleFonts.poppins(),
                    items: country.map((e) => e.country.toString()).toList(),
                    controller: CovidController.textEditingController,
                    onChanged: (val) {
                      setState(() {
                        ApiUtils.country = val;
                      });
                    },
                  );
                } else {
                  return const Center(child: CircularProgressIndicator(),);
                }
              }
            ),
            (ApiUtils.country.isNotEmpty)
              ? Expanded(
              child: FutureBuilder(
                future: getStateResponse(),
                builder: (context, snapshot) {
                  if(snapshot.hasData) {
                    List<AllState> state = snapshot.data!;
                    return ListView.builder(
                      physics: const BouncingScrollPhysics(),
                      padding: const EdgeInsets.symmetric(vertical: 20),
                      itemCount: state.length,
                      itemBuilder: (context, index) {
                        return Container(
                          margin: const EdgeInsets.symmetric(vertical: 5),
                          decoration: BoxDecoration(
                            color: CovidColor.white,
                            borderRadius: BorderRadius.circular(20),
                          ),
                          child: ExpansionTile(
                            tilePadding: const EdgeInsets.symmetric(horizontal: 15),
                            title: Text("${state[index].province}".substring(9), style: GoogleFonts.poppins(color: CovidColor.black),),
                            subtitle: Text("${state[index].date}".substring(0,10), style: GoogleFonts.poppins(color: CovidColor.grey),),
                            expandedAlignment: Alignment.centerLeft,
                            childrenPadding: const EdgeInsets.all(10),
                            expandedCrossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text("Total Cases : ${state[index].confirmed}"),
                              Text("Active Case : ${state[index].active}"),
                              Text("Recovered : ${state[index].recovered}"),
                              Text("Deaths : ${state[index].deaths}"),
                            ],
                          ),
                        );
                      },
                    );
                  } else {
                    return const Center(child: CircularProgressIndicator(),);
                  }
                },
              ),
            )
              : Container(),
          ],
        ),
      ),
      backgroundColor: CovidColor.bgColor,
    );
  }
}
