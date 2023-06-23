import 'package:flutter/material.dart';
import 'package:flutter_icons_null_safety/flutter_icons_null_safety.dart';
import 'package:petopia/features/domain/entities/animal/animal_entity.dart';
import 'package:petopia/features/presentation/page/announcement/adoption.dart';
import 'package:petopia/features/presentation/page/announcement/create_dialogs/adoption_dialog.dart';
import 'package:petopia/features/presentation/page/announcement/lost_animal.dart';
import 'package:petopia/features/presentation/page/announcement/create_dialogs/founded_lost_animal_dialog.dart';
import 'package:petopia/util/consts.dart';

class Announcement extends StatefulWidget {
  final AnimalEntity currentUser;

  const Announcement({super.key, required this.currentUser});

  @override
  _AnnouncementState createState() => _AnnouncementState();
}

class _AnnouncementState extends State<Announcement> with SingleTickerProviderStateMixin {
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
                  child: const Icon(Ionicons.md_megaphone, color: white),
                ),
              ),
              backgroundColor: darkPurpleColor,
              foregroundColor: white,
              title: const Text('Announcement'),
              pinned: true,
              floating: true,
              forceElevated: boxIsScrolled,
              bottom: TabBar(
                unselectedLabelColor: white,
                labelColor: black,
                indicatorColor: darkBlueGreenColor,
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
          children: [
            const AdoptionPage(),
            FoundedLostAnimalPage(
              currentUser: widget.currentUser,
            ),
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
            height: 140,
            decoration: BoxDecoration(color: lightPurpleColor),
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
                        style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: black),
                      ),
                    ),
                    const Divider(
                      thickness: 0.3,
                      color: lightGrey,
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
                                builder: (context) => LostAnimalDialog(currentUser: widget.currentUser));

                            // lost oluşturma sayfası
                          },
                          child: const Text(
                            "Lost animal",
                            style: TextStyle(fontWeight: FontWeight.w500, fontSize: 16, color: black),
                          ),
                        ),
                      ),
                    ),
                    sizeVertical(7),
                    const Divider(
                      thickness: 0.3,
                      color: lightGrey,
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 10.0),
                      child: InkWell(
                        onTap: () {
                          showDialog(
                              context: context,
                              builder: (context) => AdoptionAnimalDialog(
                                    currentUser: widget.currentUser,
                                  ));
                        },
                        child: const Text(
                          "Adoption Animal",
                          style: TextStyle(fontWeight: FontWeight.w500, fontSize: 16, color: black),
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
