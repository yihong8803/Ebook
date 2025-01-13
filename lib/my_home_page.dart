import 'dart:convert';

import 'package:ebook2/my_tabs.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:ebook2/audio/app_colors.dart' as AppColors;

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage>
    with SingleTickerProviderStateMixin {
    
    List<Color> myColor = [
    Colors.green,
    Colors.red,
    Colors.yellow,
    Colors.blue
  ];





  List popularBooks = [];
  List books = [];
  late ScrollController _scrollableController;
  late TabController _tabController;





  ReadData() async {
    await DefaultAssetBundle.of(context)
        .loadString("json/popularBooks.json")
        .then((s) {
      setState(
        () {
          //Decode the loading
          popularBooks = json.decode(s);
        },
      );
    });
    await DefaultAssetBundle.of(context)
        .loadString("json/books.json")
        .then((s) {
      setState(
        () {
          //Decode the loading
          books = json.decode(s);
          print("The book is $books");
        },
      );
    });
  }

  //Load Json File
  @override
  void initState() {
    super.initState();
    //Whenever you have vsynce, need to call singletickeerprovider
    _tabController = TabController(length: 3, vsync: this);
    _scrollableController = ScrollController();
    ReadData();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: AppColors.background,
      child: SafeArea(
        child: Scaffold(
            body: Column(
          children: [
            Container(
              margin: const EdgeInsets.only(top: 10, left: 20, right: 20),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  GestureDetector(
                    onTap: () {},
                    child: ImageIcon(AssetImage("img/menu.png"),
                        size: 24, color: Colors.black),
                  ),
                  Row(
                    children: [
                      Icon(Icons.search),
                      SizedBox(width: 10),
                      Icon(Icons.notifications),
                    ],
                  ),
                ],
              ),
            ),
            SizedBox(height: 20),
            Row(
              children: [
                Container(
                  margin: const EdgeInsets.only(left: 20),
                  child: Text(
                    "Popular Books",
                    style: TextStyle(fontSize: 30),
                  ),
                ),
              ],
            ),
            SizedBox(height: 20),
            Container(
                height: 180,
                child: Stack(children: [
                  Positioned(
                    top: 0,
                    left: -20,
                    right: 0,
                    child: Container(
                        height: 180,
                        child: PageView.builder(
                          controller: PageController(viewportFraction: 0.8),
                          itemCount:
                              popularBooks.isEmpty ? 0 : popularBooks.length,
                          itemBuilder: (_, i) {
                            return Container(
                              height: 180,
                              width: MediaQuery.of(context).size.width,
                              margin: const EdgeInsets.only(right: 10),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(15),
                                image: DecorationImage(
                                  image: AssetImage(popularBooks[i]["img"]),
                                  fit: BoxFit.fill,
                                ),
                              ),
                            );
                          },
                        )),
                  )
                ])),
            Expanded(
                child: NestedScrollView(
              controller: _scrollableController,
              headerSliverBuilder: (BuildContext context, bool isScroll) {
                return [
                  SliverAppBar(
                    pinned: true,
                    backgroundColor: AppColors.silverBackground,
                    elevation: 0,
                    bottom: PreferredSize(
                        //Sizedbox between expanded and container
                        preferredSize: Size.fromHeight(50),
                        child: Container(
                          margin: const EdgeInsets.only(bottom: 20),
                          child: TabBar(
                            tabAlignment: TabAlignment.start,
                            indicatorPadding: const EdgeInsets.all(0),
                            indicatorSize: TabBarIndicatorSize.label,
                            labelPadding: const EdgeInsets.only(left: 6),
                            controller: _tabController,
                            isScrollable: true,
                            //Indicator show each design
                            indicator: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.grey.withOpacity(0.2),
                                  blurRadius: 7,
                                  //Offset showing the shadow  left and right, up and down
                                  offset: Offset(0, 0),
                                ),
                              ],
                            ),
                            tabs: [
                              AppTabs(color: AppColors.menu1Color, text: "New"),
                              AppTabs(
                                  color: AppColors.menu2Color, text: "Popular"),
                              AppTabs(
                                  color: AppColors.menu3Color,
                                  text: "Trending"),
                            ],
                          ),
                        )),
                  ),
                ];
              },
              body: TabBarView(
                controller: _tabController,
                children: [
                  //For Loop to display array content
                  ListView.builder(
                      itemCount: books.isEmpty ? 0 : books.length,
                      itemBuilder: (_, i) {
                        return Container(
                          margin: const EdgeInsets.only(
                              left: 20, right: 20, top: 10, bottom: 10),
                          child: Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              color: AppColors.tabVarViewColor,
                              boxShadow: [
                                BoxShadow(
                                  blurRadius: 2,
                                  offset: Offset(0, 0),
                                  color: Colors.grey.withOpacity(0.2),
                                ),
                              ],
                            ),
                            child: Container(
                              padding: const EdgeInsets.all(8),
                              //Row for each list
                              child: Row(
                                children: [
                                  //Left portion includes image
                                  Container(
                                    width: 90,
                                    height: 120,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(10),
                                      image: DecorationImage(
                                        image: AssetImage(books[i]["img"]),
                                      ),
                                    ),
                                  ),
                                  SizedBox(width: 10),
                                  //Right portion includes rating, name
                                  Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Row(
                                        children: [
                                          Icon(Icons.star,
                                              size: 24,
                                              color: AppColors.starColor),
                                          SizedBox(width: 5),
                                          Text(
                                            books[i]["rating"],
                                            style: TextStyle(
                                                color: AppColors.menu2Color),
                                          ),
                                        ],
                                      ),
                                      Text(
                                        books[i]["title"],
                                        style: TextStyle(
                                            fontSize: 20,
                                            fontFamily: "Avenir",
                                            fontWeight: FontWeight.bold),
                                      ),
                                      Text(
                                        books[i]["text"],
                                        style: TextStyle(
                                            fontSize: 15,
                                            fontFamily: "Avenir",
                                            color: AppColors.subTitleText),
                                      ),
                                      Container(
                                        width: 60,
                                        height: 20,
                                        decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(3),
                                          color: AppColors.loveColor,
                                        ),
                                        child: Text(
                                          "Love",
                                          style: TextStyle(
                                              fontSize: 12,
                                              fontFamily: "Avenir",
                                              color: Colors.white),
                                        ),
                                        alignment: Alignment.center,
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ),
                        );
                      }),
                  Material(
                    child: ListTile(
                      leading: CircleAvatar(
                        backgroundColor: Colors.grey,
                      ),
                      title: Text("Content"),
                    ),
                  ),
                  Material(
                    child: ListTile(
                      leading: CircleAvatar(
                        backgroundColor: Colors.grey,
                      ),
                      title: Text("Content"),
                    ),
                  ),
                ],
              ),
            )),
          ],
        )),
      ),
    );
  }
}
