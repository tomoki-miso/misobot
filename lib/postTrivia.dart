import 'dart:math';

import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'firebase_options.dart';
import 'package:cloud_firestore/cloud_firestore.dart';


class PostTriviaPage extends StatefulWidget {
  @override
  _PostTriviaPagePageState createState() => _PostTriviaPagePageState();
}

class _PostTriviaPagePageState extends State<PostTriviaPage> {
  
  TextEditingController _textEditingController = TextEditingController();
  bool _isDuplicate = false;

  void _onSubmitted(String content) {
    CollectionReference posts = FirebaseFirestore.instance
        .collection('trivias');
    posts
        .where('trivia',
            isEqualTo: content)
        .get()
        .then((querySnapshot) {
      if (querySnapshot.docs.isNotEmpty) {
        setState(() {
          _isDuplicate = true;
        });
      } else {
        // 新規登録処理
        posts.add({
         'trivia': content,
        });

        setState(() {
          _isDuplicate = false;
        });

        /// 入力欄をクリアにする
        _textEditingController.clear();
       
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromRGBO(247, 202, 201, 1),
      appBar: AppBar(
        title: Text("投稿画面"),
        
           
      ),
      body: SafeArea(
        child: Center(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              if (_isDuplicate)
                Text(
                  "すでに登録されています",
                  style: TextStyle(color: Colors.red),
                ),
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.02,
              ),
              RichText(
                text: TextSpan(
                  children: [
                    WidgetSpan(
                      child: FaIcon(
                        FontAwesomeIcons.triangleExclamation,
                        size: 16,
                        
                      ),
                    ),
                    TextSpan(
                      text: 'できるだけひらがなで登録してね！',
                      style: TextStyle(color: Colors.black),
                    ),
                  ],
                ),
              ),
              SizedBox(
               height: MediaQuery.of(context).size.height * 0.02,
              ),
             
              SizedBox(
               height: MediaQuery.of(context).size.height * 0.015,
              ),
              SizedBox(
                 width: MediaQuery.of(context).size.width * 0.8,
                child: TextFormField(
                  keyboardType: TextInputType.text,
                  controller: _textEditingController,
                  decoration: InputDecoration(
                    focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(16),
                        borderSide: BorderSide(color: Colors.black, width: 2)),
                    labelStyle: TextStyle(
                      fontSize: 12,
                      color: Color.fromRGBO(93, 92, 92, 1),
                    ),
                    hintText: "具材・隠し味を登録してね",
                    fillColor: Color.fromRGBO(255, 255, 255, 1), // 背景色を設定する
                    filled: true,
                    border: OutlineInputBorder(),
                  ),
                ),
              ),
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.015,
              ),
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.08,
                 width: MediaQuery.of(context).size.width * 0.6,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.white,
                      foregroundColor: Color.fromRGBO(171, 116, 68, 1),
                      shape: StadiumBorder(),
                      side: BorderSide(
                          color: Color.fromRGBO(171, 116, 68, 1), width: 1),
                      elevation: 20),
                  onPressed: () {
                    final content = _textEditingController.text.trim();
                    if (content.isNotEmpty) {
                      _onSubmitted(content);
                    }
                  },
                  child: const Text(
                    "投稿",
                    style: TextStyle(color: Color.fromARGB(255, 40, 40, 40)),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
