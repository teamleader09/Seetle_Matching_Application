import 'package:flutter/material.dart';
import 'package:settee/src/constants/app_styles.dart';
import 'package:settee/src/translate/jp.dart';
import 'package:settee/src/utils/index.dart';

class ProfileBottomSheet extends StatelessWidget {

  const ProfileBottomSheet({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Container(
        padding: EdgeInsets.only(top: vhh(context, 5), left: vMin(context, 3), right: vMin(context, 3)),
        height: vhh(context, 95),
        decoration: const BoxDecoration(
          color: kColorBlack,
          borderRadius: BorderRadius.vertical(top: Radius.circular(25)),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Row(
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      "山本 村井",
                      style: TextStyle(
                        color: kColorWhite,
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(height: vhh(context, 1),),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Container(
                          width: vMin(context, 65),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(8),
                            border: Border.all(
                              color: kColorBorder
                            )                  
                          ),
                          child: Padding(padding: EdgeInsets.only(left: vMin(context, 3), right: vMin(context, 5), top: vhh(context, 0.5), bottom: vhh(context, 0.5)),
                            child: Row(
                              children: [
                                const Icon(Icons.upload, color: kColorBorder,),
                                SizedBox(width: vMin(context, 2),),
                                const Text("QR code import", style: TextStyle(
                                  color: kColorWhite,
                                  fontSize: 14,
                                ),
                              ),
                            ],
                          ) 
                          ) 
                        ),
                        SizedBox(width: vMin(context, 3),),
                      ],
                    )
                  ],
                ),
                Container(
                  width: vMin(context, 25),
                  height: vh(context, 13),
                  decoration: BoxDecoration(
                    image: const DecorationImage(
                      image: AssetImage("assets/images/background/logo.png"),
                      fit: BoxFit.cover,
                    ),
                    borderRadius: BorderRadius.circular(15),
                  ),
                ),
              ],
            ),

            SizedBox(height: vhh(context, 2),),

            Stack(
              children: [
                Container(
                  width: vMin(context, 100),
                  height: vh(context, 20), 
                  decoration: BoxDecoration(
                    border: Border.all(
                      color: kColorBorder
                    ),
                    image: const DecorationImage(
                      image: AssetImage('assets/images/background/globe.png'), 
                      fit: BoxFit.contain, 
                    ),
                    borderRadius: BorderRadius.circular(15),
                  ),
                ),
                Positioned(
                  top: 5,
                  left: 10,
                  right: 0,
                  child: Container(
                    height: vhh(context, 5),
                    child: const Text(
                      preparingWorld,
                      style: TextStyle(
                        color: kColorWhite,
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
                Positioned(
                  bottom: 0,
                  left: 0,
                  right: 0,
                  child: Container(
                    alignment: Alignment.center,
                    height: vhh(context, 5),
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        begin: Alignment.centerLeft,
                        end: Alignment.centerRight,
                        colors: [
                          // ignore: deprecated_member_use
                          kColorBlack.withOpacity(0),
                          kColorBlack.withOpacity(0.5), 
                          kColorBlack.withOpacity(0),
                        ],
                        stops: const [0.0, 0.5, 1.0],
                      ),
                      borderRadius: const BorderRadius.vertical(top: Radius.circular(25)),
                    ),
                    child: const Text(
                      "62:58:57",
                      style: TextStyle(
                        color: kColorWhite,
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(height: vhh(context, 2.5),),

            Container(
              padding: const EdgeInsets.all(0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(bestFriend, style: TextStyle(color: kColorBorder, fontWeight: FontWeight.bold, fontSize: 22),),

                  SizedBox(height: vhh(context, 1),),
                  Container(
                    width: vMin(context, 100),
                    height: vh(context, 15), 
                    decoration: BoxDecoration(
                      border: Border.all(
                        color: kColorBorder,
                      ),
                      borderRadius: BorderRadius.circular(15),
                    ),
                    child: const Padding(
                      padding: EdgeInsets.all(10),
                      child: Text(
                        needRestFriend,
                        style: TextStyle(
                          color: kColorBorder,
                          fontSize: 14,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ) 
                  ),
                ],
              ),
            ),

            SizedBox(height: vhh(context, 2.5),),

            Container(
              padding: const EdgeInsets.all(0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(highlight, style: TextStyle(color: kColorBorder, fontWeight: FontWeight.bold, fontSize: 22),),

                  SizedBox(height: vhh(context, 1),),
                  Container(
                    width: vMin(context, 100),
                    height: vh(context, 12.5), 
                    decoration: BoxDecoration(
                      border: Border.all(
                        color: kColorBorder
                      ),
                      borderRadius: BorderRadius.circular(15),
                    ),
                    child: const Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Padding(
                          padding: EdgeInsets.all(10),
                          child: Text(
                            sentTimeWithFriend,
                            style: TextStyle(
                              color: kColorBorder,
                              fontSize: 14,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.all(10),
                          child: Text(
                            needRestFriend,
                            style: TextStyle(
                              color: kColorBorder,
                              fontSize: 14,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ) 
                      ],
                    ) 
                  ),
                ],
              ),
            ),

            SizedBox(height: vhh(context, 1.5),),

            Container(
              padding: const EdgeInsets.all(0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    width: vMin(context, 40),
                    height: vh(context, 10), 
                    decoration: BoxDecoration(
                      border: Border.all(
                        color: kColorBorder
                      ),
                      borderRadius: BorderRadius.circular(15),
                    ),
                    child: const Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Padding(
                          padding: EdgeInsets.only(left: 10),
                          child: Text(
                            pops,
                            style: TextStyle(
                              color: kColorBorder,
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.only(left: 10),
                          child: Text(
                            "0",
                            style: TextStyle(
                              color: kColorWhite,
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ) 
                      ],
                    ) 
                  ),

                  Container(
                    width: vMin(context, 40),
                    height: vh(context, 10), 
                    decoration: BoxDecoration(
                      border: Border.all(
                        color: kColorBorder
                      ),
                      borderRadius: BorderRadius.circular(15),
                    ),
                    child: const Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Padding(
                          padding: EdgeInsets.only(left: 10),
                          child: Text(
                            brawzing,
                            style: TextStyle(
                              color: kColorBorder,
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.only(left: 10),
                          child: Text(
                            "0",
                            style: TextStyle(
                              color: kColorWhite,
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ) 
                      ],
                    ) 
                  ),
                ],
              ),
            )
          ],
        ),
      )
    );
  }
}
