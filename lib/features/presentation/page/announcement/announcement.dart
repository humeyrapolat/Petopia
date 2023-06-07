import 'package:flutter/material.dart';
import 'package:flutter_icons_null_safety/flutter_icons_null_safety.dart';
import 'package:petopia/features/presentation/page/announcement/adoption.dart';
import 'package:petopia/features/presentation/page/announcement/create_dialogs/adoption_dialog.dart';
import 'package:petopia/features/presentation/page/announcement/lost_animal.dart';
import 'package:petopia/features/presentation/page/announcement/create_dialogs/lost_animal_dialog.dart';
import 'package:petopia/util/consts.dart';

class Announcement extends StatefulWidget {
  const Announcement({super.key});

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
              leading: Padding(
                padding: const EdgeInsets.only(right: 10.0),
                child: InkWell(
                  onTap: () {
                    _openAnnouncementBottomModalSheet(context);
                  },
                  child: const Icon(Ionicons.md_megaphone,
                      color: lightBlueGreenColor),
                ),
              ),
              backgroundColor: darkGreenColor,
              foregroundColor: lightGreenColor,
              title: const Text('Announcement'),
              pinned: true,
              floating: true,
              forceElevated: boxIsScrolled,
              bottom: TabBar(
                indicatorColor: darkPinkColor,
                tabs: const <Widget>[
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
          controller: _tabController,
          children: const [
            LostAnimalPage(),
            LostAnimalPage(),
          ],
        ),
      ),
    );
  }

  _openAnnouncementBottomModalSheet(BuildContext context) {
    return showModalBottomSheet(
        context: context,
        builder: (context) {
          return Container(
            height: 150,
            decoration: BoxDecoration(color: white.withOpacity(.8)),
            child: SingleChildScrollView(
              child: Container(
                margin: const EdgeInsets.symmetric(vertical: 10),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Padding(
                      padding: EdgeInsets.only(left: 10.0),
                      child: Text(
                        "Create Announcement",
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 18,
                            color: darkGreenColor),
                      ),
                    ),
                    const SizedBox(
                      height: 8,
                    ),
                    const Divider(
                      thickness: 1,
                      color: darkGreenColor,
                    ),
                    const SizedBox(
                      height: 8,
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 10.0),
                      child: GestureDetector(
                        child: InkWell(
                          onTap: () {
                            showDialog(
                                context: context,
                                builder: (context) => LostAnimalDialog());

                            // lost oluşturma sayfası
                          },
                          child: const Text(
                            "Lost Animal Announcement",
                            style: TextStyle(
                                fontWeight: FontWeight.w500,
                                fontSize: 16,
                                color: darkGreenColor),
                          ),
                        ),
                      ),
                    ),
                    sizeVertical(7),
                    const Divider(
                      thickness: 1,
                      color: darkGreenColor,
                    ),
                    sizeVertical(7),
                    Padding(
                      padding: const EdgeInsets.only(left: 10.0),
                      child: InkWell(
                        onTap: () {
                          showDialog(
                              context: context,
                              builder: (context) => AdoptionAnimalDialog());
                        },
                        child: const Text(
                          "Adoption Animal",
                          style: TextStyle(
                              fontWeight: FontWeight.w500,
                              fontSize: 16,
                              color: darkGreenColor),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
        });
  }
}
