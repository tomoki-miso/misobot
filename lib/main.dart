import 'dart:io';

import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import 'package:google_mobile_ads/google_mobile_ads.dart';

import 'firebase_options.dart';
import 'list.dart';
import 'random.dart';
import 'setting.dart';
import 'post.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  MobileAds.instance.initialize();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  
  // バナー広告を初期化し、読み込む
  initializeBannerAd();

  runApp(
    MyApp(),
  );
}

BannerAd myBanner = BannerAd(
  adUnitId: getTestAdBannerUnitId(),
  size: AdSize.banner,
  request: const AdRequest(),
  listener: const BannerAdListener(),
);

void initializeBannerAd() {
  // バナー広告をインスタンス化
  myBanner = BannerAd(
    adUnitId: getTestAdBannerUnitId(),
    size: AdSize.banner,
    request: const AdRequest(),
    listener: const BannerAdListener(),
  );
  // バナー広告の読み込み
  myBanner.load();
}

// プラットフォーム（iOS / Android）に合わせてデモ用広告IDを返す
String getTestAdBannerUnitId() {
  String testBannerUnitId = "ca-app-pub-2209028789060457/4518094197"; // iOSのデモ用バナー広告ID
  
  return testBannerUnitId;
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false, 
      title: 'Flutter Demo',
      theme: ThemeData(
        appBarTheme: AppBarTheme(
          titleTextStyle: TextStyle(color: Color.fromRGBO(51, 50, 50, 1)),
          color: Colors.white,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.only(
              bottomLeft: Radius.circular(20),
              bottomRight: Radius.circular(20),
            ),
          ),
        ),
        primarySwatch: Colors.blue,
        fontFamily: 'Kiwi_Maru',
      ),
      home: MyStatefulWidget(),
      routes: {
        '/list': (context) => const ListPage(),
        '/post': (context) => PostPage(),
      },
    );
  }
}


class MyStatefulWidget extends StatefulWidget {
  const MyStatefulWidget({Key? key}) : super(key: key);

  @override
  State<MyStatefulWidget> createState() => _MyStatefulWidgetState();
}

class _MyStatefulWidgetState extends State<MyStatefulWidget> {
  static final _screens = [const ListPage(), const RandomPage(), SettingPage()];
  int _selectedIndex = 1;

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Expanded(
            child: _screens[_selectedIndex],
          ),
          Container(
            height: 50,
            child: AdWidget(ad: myBanner)),
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        selectedItemColor:Color.fromRGBO(243, 155, 79, 1) ,
        currentIndex: _selectedIndex,
        onTap: _onItemTapped,
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.playlist_add), label: 'リスト'),
          BottomNavigationBarItem(
            icon: FaIcon(FontAwesomeIcons.mugHot), label: 'みそしるをつくる'),
          BottomNavigationBarItem(
            icon: FaIcon(FontAwesomeIcons.bookOpenReader), label: 'おしらせ'),
        ],
        type: BottomNavigationBarType.fixed,
      ),
    );
  }
}
