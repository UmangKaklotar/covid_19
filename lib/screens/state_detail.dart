import 'package:covid_19/function/state_response.dart';
import 'package:covid_19/model/state_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../utils/api_string.dart';
import '../utils/colors.dart';

class StateDetail extends StatefulWidget {
  const StateDetail({Key? key}) : super(key: key);

  @override
  State<StateDetail> createState() => _StateDetailState();
}

class _StateDetailState extends State<StateDetail> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: GestureDetector(
          onTap: () => Navigator.pop(context),
          child: Icon(CupertinoIcons.back, color: CovidColor.black,),
        ),
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
                  ApiUtils.searchState.value = val;
                });
              },
            ),
            Expanded(
              child: FutureBuilder(
                future: getStateResponse(),
                builder: (context, snapshot) {
                  if(snapshot.hasData) {
                    List<AllState> state = snapshot.data;
                    return ListView.builder(
                      physics: const BouncingScrollPhysics(),
                      padding: const EdgeInsets.symmetric(vertical: 20),
                      itemCount: state.length,
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
                          ),
                        );
                        if(ApiUtils.searchState.value != '') {
                          if(state[index].province.toString().toUpperCase().contains(ApiUtils.searchState.value.toUpperCase())) {
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
