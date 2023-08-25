import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:share_plus/share_plus.dart';

class RandomPage extends StatefulWidget {
  const RandomPage({Key? key}) : super(key: key);

  @override
  _RandomPageState createState() => _RandomPageState();
}

class _RandomPageState extends State<RandomPage> {
  List<String> materials = [];
  String secret = '';

  @override
  void initState() {
    super.initState();
    _fetchData();
  }

  Future<void> _fetchData() async {
    final random = Random();
    final snapshot =
        await FirebaseFirestore.instance.collection('list_materials').get();
    final materialIds =
        List.generate(snapshot.docs.length, (index) => index + 1);
    materialIds.shuffle();
    materials = materialIds.take(3).map((id) {
      final material = snapshot.docs[id - 1].data()['materials'];
      return ' $material';
    }).toList();

    final secretSnapshot =
        await FirebaseFirestore.instance.collection('list_secret').get();
    final secretIds =
        List.generate(secretSnapshot.docs.length, (index) => index + 1);
    secretIds.shuffle();
    secretIds.removeAt(0); // Add this line to remove the first ID value
    final secretId = secretIds.first;
    secret = secretSnapshot.docs[secretId - 1].data()['secret'];

    setState(() {});
  }

 /*  Future<void> _shareOnTwitter() async {
    final message =
        '今日のみそしるを「みそしるBot」で決めたよ！\n今日のみそしるの具材は${materials.join('と')}で、隠し味は$secretだよ！\n#今日のみそしるbyみそしるBot';
    await SocialShare.shareTwitter(message);
  }
 */

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("みそしるをつくる"), actions: [
        IconButton(
          icon: FaIcon(
            FontAwesomeIcons.arrowUpFromBracket,
            color: Colors.black,
          ),
          onPressed: () => _share(
              '今日のみそしるを「みそしるBot」で決めたよ！\n今日のみそしるの具材は${materials.join('と')}で、隠し味は$secretだよ！\n#今日のみそしるbyみそしるBot\n#みそしるBot'),
        ),
      ]),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.only(top: 3),
          child: SafeArea(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                if (materials.isNotEmpty)
                  Column(
                    children: materials.map((material) {
                      return Container(
                        alignment: Alignment.center,
                        height: MediaQuery.of(context).size.height * 0.13,
                        width: double.infinity,
                        margin: EdgeInsets.only(
                            top: 0, bottom: 5, right: 10, left: 10),
                        decoration: BoxDecoration(
                          color: Color.fromRGBO(247, 202, 201, 1),
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              "具材",
                              style: TextStyle(fontSize: 16),
                            ),
                            Text(
                              material,
                              style: TextStyle(
                                fontSize: 30,
                              ),
                            ),
                          ],
                        ),
                      );
                    }).toList(),
                  ),
                if (secret.isNotEmpty)
                  Container(
                    height: MediaQuery.of(context).size.height * 0.13,
                    width: double.infinity,
                    margin:
                        EdgeInsets.only(top: 0, bottom: 5, right: 10, left: 10),
                    decoration: BoxDecoration(
                      color: Color.fromARGB(255, 255, 213, 1),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          "隠し味",
                          style: TextStyle(fontSize: 16),
                        ),
                        Text(
                          secret,
                          style: TextStyle(fontSize: 30),
                        ),
                      ],
                    ),
                  ),
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.01,
                ),
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.1, //ここ0.12
                  width: MediaQuery.of(context).size.width * 0.8,
                  child: ElevatedButton(
                    onPressed: _fetchData,
                    child: const Text(
                      'みそしるをつくる',
                      style: TextStyle(
                          color: Color.fromRGBO(51, 50, 50, 1), fontSize: 20),
                    ),
                    style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.white,
                        foregroundColor: Color.fromRGBO(171, 116, 68, 1),
                        shape: StadiumBorder(),
                        side: BorderSide(
                            color: Color.fromRGBO(243, 155, 79, 1), width: 4),
                        elevation: 20),
                  ),
                ),
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.012,
                ),
                Container(
                  height: MediaQuery.of(context).size.height * 0.04,
                  width: MediaQuery.of(context).size.width * 0.6,
                  child: ElevatedButton(
                    onPressed: (){}/* _shareOnTwitter */,
                    child: RichText(
                        text: TextSpan(children: [
                      WidgetSpan(
                          child: FaIcon(FontAwesomeIcons.twitter,
                              size: 16, color: Colors.white)),
                      WidgetSpan(
                        child: SizedBox(
                          width: 10,
                        ),
                      ),
                      TextSpan(
                        text: 'Twitterで共有する',
                      )
                    ])),
                    style: ElevatedButton.styleFrom(
                        backgroundColor: Color.fromRGBO(29, 161, 242, 1),
                        foregroundColor: Color.fromRGBO(19, 102, 154, 1),
                        elevation: 10),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

Future<void> _share(String text) async {
  await Share.share(text,
      sharePositionOrigin: Rect.fromLTWH(200, 80, 450, 10));
}
