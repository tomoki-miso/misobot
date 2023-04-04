import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class ListPage extends StatefulWidget {
  const ListPage({Key? key}) : super(key: key);

  @override
  _ListPageState createState() => _ListPageState();
}

class _ListPageState extends State<ListPage>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromRGBO(247, 202, 201, 0.6),
      appBar: AppBar(
        bottom: PreferredSize(
            preferredSize: Size.fromHeight(20),
            child: TabBar(
             
              labelColor: Color.fromRGBO(51, 50, 50, 1),
              controller: _tabController,
              indicatorSize: TabBarIndicatorSize.tab,
              indicator: BoxDecoration(
                borderRadius: _tabController.index == 0
                    ? BorderRadius.only(
                        bottomLeft: Radius.circular(20),
                        bottomRight: Radius.circular(0),
                      )
                    : BorderRadius.only(
                        bottomLeft: Radius.circular(0),
                        bottomRight: Radius.circular(20),
                      ),
                color: Color.fromRGBO(247, 202, 201, 0.8),
              ),
              tabs: [
                Tab(text: "具材"),
                Tab(text: "隠し味"),
              ],
              indicatorWeight: 4,
              indicatorColor: Color.fromRGBO(247, 202, 201, 1),
              onTap: (index) {
                setState(() {
                  _tabController.index = index;
                });
              },
            )),
      ),
      body: SafeArea(
        child: TabBarView(
           physics: NeverScrollableScrollPhysics(), 
          controller: _tabController,
          children: [
            StreamBuilder<QuerySnapshot<Map<String, dynamic>>>(
              stream: FirebaseFirestore.instance
                  .collection("list_materials")
                  .orderBy('materials')
                  .snapshots(),
              builder: (BuildContext context,
                  AsyncSnapshot<QuerySnapshot<Map<String, dynamic>>> snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return Center(child: CircularProgressIndicator());
                }
                return ListView(
               
                 shrinkWrap: true,
                  padding: EdgeInsets.only(top: 6),
                  
                  children: snapshot.data!.docs
                      .map((DocumentSnapshot<Map<String, dynamic>> document) {
                    return Card(
                      child: ListTile(
                        
                        title: Text(document.data()!['materials']),
                      ),
                    );
                  }).toList(),
                );
              },
            ),
            StreamBuilder<QuerySnapshot<Map<String, dynamic>>>(
              stream: FirebaseFirestore.instance
                  .collection("list_secret")
                  .orderBy('secret')
                  .snapshots(),
              builder: (BuildContext context,
                  AsyncSnapshot<QuerySnapshot<Map<String, dynamic>>> snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return Center(child: CircularProgressIndicator());
                }
                return ListView(
                  padding: EdgeInsets.only(top: 6),
                  children: snapshot.data!.docs
                      .map((DocumentSnapshot<Map<String, dynamic>> document) {
                    return Card(
                      child: ListTile(
                        title: Text(document.data()!['secret']),
                      ),
                    );
                  }).toList(),
                );
              },
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Color.fromRGBO(244, 164, 96, 1),
        onPressed: () {
          Navigator.pushNamed(context, '/post');
        },
        child: Icon(Icons.add),
      ),
    );
  }
}
