import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:petopia/features/presentation/page/announcement/adoption.dart';
import 'package:petopia/features/presentation/page/announcement/lost_animal.dart';
import 'package:petopia/util/consts.dart';


class Announcement extends StatefulWidget {
  @override
  _AnnouncementState createState() => _AnnouncementState();
}

class _AnnouncementState extends State<Announcement>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;
  late ScrollController _scrollViewController;


  @override
  void initState() {
    super.initState();
    _tabController = TabController(vsync: this, length: 2);
    _scrollViewController = ScrollController(initialScrollOffset: 0.0);
  }

  @override
  void dispose() {
    _tabController.dispose();
    _scrollViewController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: NestedScrollView(
        controller: _scrollViewController,
        headerSliverBuilder: (BuildContext context, bool boxIsScrolled) {
          return <Widget>[
            SliverAppBar(
              backgroundColor: darkGreenColor,
              foregroundColor: lightGreenColor,
              title: Text('Announcement'),
              pinned: true,
              floating: true,
              forceElevated: boxIsScrolled,
              bottom: TabBar(
                indicatorColor: darkPinkColor,
                tabs: <Widget>[
                  Tab(
                    text: "Adoption Pet",
                  ),
                  Tab(
                    text: "Lost Pet",
                  )
                ],
                controller: _tabController,
              ),
            )
          ];
        },
        body: TabBarView(
          children:[
            AdoptionPage(),
            LostAnimalPage(),
          ],
          controller: _tabController,
        ),
      ),
    );
  }
}