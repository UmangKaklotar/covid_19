import 'package:animated_custom_dropdown/custom_dropdown.dart';
import 'package:covid_19/function/state_response.dart';
import 'package:covid_19/model/country_model.dart';
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
  void initState() {
    // TODO: implement initState
    super.initState();
    getStateResponse();
  }
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
            Expanded(
              child: FutureBuilder(
                future: getCountryResponse(),
                builder: (context, snapshot) {
                  if(snapshot.hasData) {
                    List<Country> country = snapshot.data;
                    return CustomDropdown.search(
                      hintText: 'Select Country',
                      hintStyle: GoogleFonts.poppins(),
                      items: country.map((e) => e.country.toString()).toList(),
                      controller: CovidController.textEditingController,
                      onChanged: (val) {
                        setState(() {
                          ApiUtils.status = val;
                        });
                      },
                    );
                  } else {
                    return const Center(child: CircularProgressIndicator(),);
                  }
                }
              ),
            ),
            (ApiUtils.country.isNotEmpty)
              ? Expanded(
              child: FutureBuilder(
                future: getStateResponse(),
                builder: (context, snapshot) {
                  if(snapshot.hasData) {
                    List<State> state = snapshot.data;
                    return ListView.builder(
                      itemCount: state.length,
                      itemBuilder: (context, index) {
                        return ListTile(
                          // title: Text(state[index].),
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
