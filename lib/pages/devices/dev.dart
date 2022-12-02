import 'package:flutter/material.dart';
import 'package:ranger/config/colors.dart';
import 'package:ranger/config/str.dart';
import 'package:ranger/pages/devices/widgets/appbar_textts.dart';

class DevicesState extends StatefulWidget {
  @override
  State<DevicesState> createState() => _DevicesStateState();
}

class _DevicesStateState extends State<DevicesState> {
  List<String> list = <String>[
    'See More 1',
    'See More 2',
    'See More 3',
    'See More 4',
    'See More 5'
  ];

  String dropdownValue = 'See More 1';
  double width = 150;
  bool isTurned = false;
  double percent = 0;

  @override
  Widget build(BuildContext context) {
    return _contentBuilder();
  }

  Widget _contentBuilder() {
    double contWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              Stack(children: [
                Container(
                  width: double.infinity,
                  decoration: BoxDecoration(
                      color: RangerColors.blueBtn,
                      border: Border.all(color: RangerColors.blueBtn)),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(top: 30),
                        child: AppbarTexts(RangerTexts.grove, 30),
                      ),
                      AppbarTexts(RangerTexts.lightsOn, 18),
                      AppbarTexts(RangerTexts.running, 18),
                      AppbarTexts(RangerTexts.outlet, 18),
                      Padding(
                        padding: const EdgeInsets.all(15.0),
                        child: DropdownButton<String>(
                          dropdownColor: RangerColors.blueBtn,
                          value: dropdownValue,
                          elevation: 16,
                          style: const TextStyle(color: RangerColors.white),
                          onChanged: _onSelectItem,
                          items: list
                              .map<DropdownMenuItem<String>>((String value) {
                            return DropdownMenuItem<String>(
                              value: value,
                              child: Text(value),
                            );
                          }).toList(),
                        ),
                      ),
                      const SizedBox(
                        height: 40,
                      )
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 220.0),
                  child: Align(
                    alignment: Alignment.topCenter,
                    child: Container(
                      width: double.infinity,
                      height: 200,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10.0),
                          color: RangerColors.white),
                      child: Column(
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(left: 15.0, top: 20.0),
                            child: Row(
                              children: const [
                                Text(
                                  'All Devices',
                                  style: TextStyle(
                                      fontSize: 25, color: RangerColors.black),
                                  textAlign: TextAlign.start,
                                ),
                              ],
                            ),
                          ),
                          Stack(children: <Widget>[
                            Padding(
                              padding: const EdgeInsets.only(
                                  left: 15, right: 15, top: 20),
                              child: SizedBox(
                                width: width > 0 ? width : 0,
                                height: 70,
                                child: Container(
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(10.0),
                                      gradient: LinearGradient(colors: [
                                        RangerColors.white,
                                        isTurned
                                            ? RangerColors.yellowBtn
                                            : RangerColors.greyBottomBar
                                      ])),
                                ),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(
                                  top: 20, left: 15, right: 15),
                              child: Container(
                                width: double.infinity,
                                height: 70,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10.0),
                                  border: Border.all(
                                      color: isTurned
                                          ? RangerColors.yellowBtn
                                          : RangerColors.greyBottomBar),
                                ),
                                child: GestureDetector(
                                  onHorizontalDragStart: (details) => 0,
                                  onHorizontalDragUpdate: (details) =>
                                      _onDecideEnlightenment(contWidth,
                                          details.globalPosition.dx, percent),
                                ),
                              ),
                            )
                          ])
                        ],
                      ),
                    ),
                  ),
                )
              ]),
            ],
          ),
        ),
      ),
    );
  }

  void _onSelectItem(String? value) {
    setState(() {
      dropdownValue = value!;
    });
  }

  void _onDecideEnlightenment(
      double contWidth, double? slideErWidth, double percent) {
    setState(() {
      if (slideErWidth! > 0) {
        contWidth = contWidth - 30;
        slideErWidth = (slideErWidth!);
        print('s1 $slideErWidth');
        percent = ((100 * slideErWidth!) / contWidth - 1).clamp(0, 100);
        print('p1 ${percent.round()}');
      } else if (slideErWidth! < 0) {
        slideErWidth = 0;
        percent = 0;
        print('p2 0');
        print('s2 $slideErWidth');
      }
    });
  }
}
