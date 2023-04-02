import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class SettingPage extends StatelessWidget {
  SettingPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SingleChildScrollView(
      child: Column(
        children: [
          Column(
            children: [
              SizedBox(
                height: MediaQuery.of(context).size.width * 0.08,
              ),
              SizedBox(
                height: MediaQuery.of(context).size.width * 0.14,
              ),
              Container(
                  padding: EdgeInsets.only(left: 24),
                  alignment: Alignment.centerLeft,
                  width: double.infinity,
                  child: Text(
                    "このアプリについて",
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
                  )),
              Center(
                child: Container(
                  padding:
                      EdgeInsets.only(top: 14, left: 18, right: 18, bottom: 14),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: Color.fromRGBO(247, 202, 201, 0.6),
                  ),
                  width: MediaQuery.of(context).size.width * 0.96,
                  child: Column(
                    children: [
                      const Text(
                        " 世界に誇る和食。\n「みそしる」は和食において、欠かすことの出来ない存在です。日々、みそしるを作り、食べる私たち。その味は優しく、穏やかで、多忙な現代社会で生きる私たちを癒やしてくれます。\n",
                        style: TextStyle(fontSize: 16),
                      ),
                      const Text(
                        " しかし、みそしるを作ることにも困難が伴います。特に、無数にある食材の中から具材を選ぶことが難しいことがあります。選択を迫られ続ける日常の中で、安らぎの存在であるはずのみそしるでさえ、能動的に選択するのは時に辛いことです。また、味のマンネリ化も避けたいものです。\n",
                        style: TextStyle(fontSize: 16),
                      ),
                      const Text(
                        " このアプリは、ユーザーが投稿した具材や隠し味がランダムで表示されます。これを参考に、「今日のみそしる」を作ることで、毎日が少しだけ明るく、楽しくなることを目指して制作しました。",
                        style: TextStyle(fontSize: 16),
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(
                height: MediaQuery.of(context).size.width * 0.08,
              ),
              Container(
                  padding: EdgeInsets.only(left: 24),
                  alignment: Alignment.centerLeft,
                  width: double.infinity,
                  child: Text(
                    "つかいかた",
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
                  )),
              Center(
                child: Container(
                  padding: EdgeInsets.all(20),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: Color.fromRGBO(247, 202, 201, 0.6),
                  ),
                  width: MediaQuery.of(context).size.width * 0.96,
                  child: Column(
                    children: [
                      Container(
                        padding: EdgeInsets.only(bottom: 13),
                        child: Row(
                          children: [
                            Icon(
                              Icons.playlist_add,
                              size: 60,
                              color: Color.fromRGBO(243, 155, 79, 1),
                            ),
                            SizedBox(
                              width: MediaQuery.of(context).size.width * 0.06,
                            ),
                            Flexible(
                              child: Text.rich(TextSpan(children: [
                                TextSpan(
                                    text: "「具材」と「隠し味」のリストがあるよ！\n右下の",
                                    style: TextStyle(fontSize: 16)),
                                WidgetSpan(
                                  child: Icon(
                                    Icons.add_circle,
                                    size: 16,
                                  ),
                                ),
                                TextSpan(
                                    text: "でリストに「具材」と「隠し味」を登録できるよ",
                                    style: TextStyle(fontSize: 16)),
                              ])),
                            )
                          ],
                        ),
                      ),
                      Divider(
                        height: MediaQuery.of(context).size.width * 0.03,
                        thickness: 0.8,
                        indent: 0,
                        endIndent: 0,
                        color: Color.fromRGBO(128, 125, 125, 0.525),
                      ),
                      Container(
                        padding: EdgeInsets.only(top: 13, bottom: 13),
                        child: Row(
                          children: [
                            FaIcon(
                              FontAwesomeIcons.mugHot,
                              size: 60,
                              color: Color.fromRGBO(243, 155, 79, 1),
                            ),
                            SizedBox(
                              width: MediaQuery.of(context).size.width * 0.06,
                            ),
                            Flexible(
                                child: Text(
                              "「みそしるをつくる」ボタンを押してみよう！\n3つの「具材」と1つの「隠し味」が表示されるよ！\n参考にして、「今日のみそしる」を作ってみよう！",
                              style: TextStyle(fontSize: 16),
                            ))
                          ],
                        ),
                      ),
                      Divider(
                        height: MediaQuery.of(context).size.width * 0.03,
                        thickness: 0.8,
                        indent: 0,
                        endIndent: 0,
                        color: Color.fromRGBO(128, 125, 125, 0.525),
                      ),
                      Container(
                        padding: EdgeInsets.only(top: 13),
                        child: Row(
                          children: [
                            FaIcon(
                              FontAwesomeIcons.bookOpenReader,
                              size: 60,
                              color: Color.fromRGBO(243, 155, 79, 1),
                            ),
                            SizedBox(
                              width: MediaQuery.of(context).size.width * 0.06,
                            ),
                            Flexible(
                                child: Text(
                              "このページだよ！\n「このアプリについて」と「つかいかた」が読めるよ！",
                              style: TextStyle(fontSize: 16),
                            )),
                            SizedBox(
                                height:
                                    MediaQuery.of(context).size.height * 0.12)
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(
                height: MediaQuery.of(context).size.width * 0.08,
              ),
              Container(
                  padding: EdgeInsets.only(left: 24),
                  alignment: Alignment.centerLeft,
                  width: double.infinity,
                  child: Text(
                    "広告ゾーン",
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
                  )),
              Container(
                padding:
                    EdgeInsets.only(top: 14, left: 18, right: 18, bottom: 14),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: Color.fromRGBO(247, 202, 201, 0.6),
                ),
                width: MediaQuery.of(context).size.width * 0.96,
                child: Column(
                  children: [
                    Text("たくさんタップしてね！"),
                    SizedBox(
                      height: 20,
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: MediaQuery.of(context).size.width * 0.08,
              ),
              Container(
                  padding: EdgeInsets.only(left: 24),
                  alignment: Alignment.centerLeft,
                  width: double.infinity,
                  child: Text(
                    "お問い合わせ",
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
                  )),
              Container(
                  padding:
                      EdgeInsets.only(top: 14, left: 18, right: 18, bottom: 14),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: Color.fromRGBO(247, 202, 201, 0.6),
                  ),
                  width: MediaQuery.of(context).size.width * 0.96,
                  child: Column(
                    children: [],
                  ))
            ],
          )
        ],
      ),
    ));
  }
}