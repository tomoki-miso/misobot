import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import 'firebase_options.dart';
import 'list.dart';
import 'random.dart';
import 'setting.dart';
import 'post.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  runApp(
    MyApp(),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
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
  static final _screens = [ListPage(), RandomPage(), SettingPage()];
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
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _selectedIndex,
        onTap: _onItemTapped,
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
                icon: Icon(Icons.playlist_add), label: 'リスト'),
          BottomNavigationBarItem(
                    icon: FaIcon(FontAwesomeIcons.mugHot), label: 'みそしるをつくる'),
          BottomNavigationBarItem(
              icon: FaIcon(FontAwesomeIcons.bookOpenReader), label: 'お知らせ'),
        ],
        type: BottomNavigationBarType.fixed,
      ),
    );
  }
}
