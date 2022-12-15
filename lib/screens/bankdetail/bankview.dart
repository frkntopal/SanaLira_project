import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../utility/color.dart';

import '../../utility/icons.dart';
import '../homepage.dart';
import 'bankname.dart';

class BankDetail extends StatelessWidget {
  const BankDetail({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: topupBackgroundColor,
        body: SingleChildScrollView(
          child: Stack(
            children: [
              Column(
                children: [
                  const SizedBox(
                    height: 36,
                  ),
                  Row(
                    children: [
                      Expanded(
                        flex: 5,
                        child: Row(
                          children: [
                            Padding(
                              padding: const EdgeInsets.all(15.0),
                              child: InkWell(
                                onTap: () {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) => HomePage()));
                                },
                                child: Container(
                                  height: 36,
                                  width: 36,
                                  color: Colors.white,
                                  child: const Icon(
                                    randomIcon.back,
                                    size: 18,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      Expanded(
                        flex: 5,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            InkWell(
                              onTap: () {
                                //Will be a notification dropdown menu
                              },
                              child: Container(
                                height: 36,
                                width: 36,
                                color: Colors.white,
                                child: const Icon(
                                  randomIcon.notification,
                                  size: 18,
                                ),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.fromLTRB(15, 0, 15, 0),
                              child: InkWell(
                                onTap: () {
                                  //Will be a settings menu button
                                },
                                child: Container(
                                  height: 36,
                                  width: 36,
                                  color: Colors.white,
                                  child: const Icon(
                                    randomIcon.settings,
                                    size: 18,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(15, 15, 15, 0),
                    child: Container(
                      width: MediaQuery.of(context).size.width,
                      height: MediaQuery.of(context).size.height * 0.1,
                      color: Colors.white,
                      child: Row(
                        children: [
                          Expanded(
                            flex: 1,
                            child: Row(
                              children: [
                                Padding(
                                  padding: const EdgeInsets.all(10.0),
                                  child: SizedBox(
                                    height: 36,
                                    width: 36,
                                    child: SvgPicture.asset(
                                      "assets/images/turkey.png",
                                      fit: BoxFit.fill,
                                    ),
                                  ),
                                ),
                                Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Container(
                                        height:
                                            MediaQuery.of(context).size.height *
                                                0.1,
                                        width:
                                            MediaQuery.of(context).size.width *
                                                0.2,
                                        child: Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: [
                                            Align(
                                              alignment: Alignment.bottomLeft,
                                              child: Container(
                                                  child: const Text(
                                                "Türk Lirası",
                                                style: TextStyle(
                                                    fontSize: 14,
                                                    fontFamily: "Inter",
                                                    fontWeight: FontWeight.bold,
                                                    fontStyle:
                                                        FontStyle.normal),
                                              )),
                                            ),
                                            Align(
                                              alignment: Alignment.bottomLeft,
                                              child: Container(
                                                  child: const Text(
                                                "TL",
                                                style: TextStyle(
                                                    color: randomGrey,
                                                    fontSize: 12,
                                                    fontFamily: "Inter",
                                                    fontWeight:
                                                        FontWeight.normal,
                                                    fontStyle:
                                                        FontStyle.normal),
                                              )),
                                            )
                                          ],
                                        )),
                                  ],
                                )
                              ],
                            ),
                          ),
                          Expanded(
                            flex: 1,
                            child: Padding(
                              padding: const EdgeInsets.all(15.0),
                              child: Container(
                                  child: const Align(
                                alignment: Alignment.centerRight,
                                child: Text(
                                  "234 ₺",
                                  style: TextStyle(
                                    fontSize: 16,
                                    fontFamily: "Inter",
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              )),
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(15, 15, 15, 0),
                    child: Container(
                        child: const Align(
                            alignment: Alignment.bottomLeft,
                            child: Text(
                                "Türk lirası yatırmak için banka seçiniz.",
                                style: TextStyle(
                                    color: randomGrey,
                                    fontFamily: "Inter",
                                    fontSize: 14)))),
                  ),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(15, 0, 15, 15),
                    child: Container(
                      width: MediaQuery.of(context).size.width,
                      height: MediaQuery.of(context).size.height * 0.55,
                      child: const BankNameDetail(),
                    ),
                  )
                ],
              )
            ],
          ),
        ));
  }
}
