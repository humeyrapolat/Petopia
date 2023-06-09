import 'package:flutter/material.dart';
import 'package:petopia/features/domain/entities/animal/animal_entity.dart';
import 'package:petopia/injection_container.dart' as di;
import 'package:petopia/util/consts.dart';
import '../../../../profile_widget.dart';
import '../../../domain/usecases/firebase_usecases/user/get_single_user_usecase.dart';

class FollowersPage extends StatelessWidget {
  final AnimalEntity user;
  const FollowersPage({Key? key, required this.user}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: white,
      appBar: AppBar(
        title: const Text("Followers"),
        backgroundColor: darkPinkColor,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 10),
        child: Column(
          children: [
            Expanded(
              child: user.followers!.isEmpty
                  ? _noFollowersWidget()
                  : ListView.builder(
                      itemCount: user.followers!.length,
                      itemBuilder: (context, index) {
                        return StreamBuilder<List<AnimalEntity>>(
                            stream: di
                                .sl<GetSingleUserUseCase>()
                                .call(user.followers![index]),
                            builder: (context, snapshot) {
                              if (snapshot.hasData == false) {
                                return const CircularProgressIndicator();
                              }
                              if (snapshot.data!.isEmpty) {
                                return Container();
                              }
                              final singleUserData = snapshot.data!.first;
                              return GestureDetector(
                                onTap: () {
                                  Navigator.pushNamed(
                                      context, PageConsts.singleUserProfilePage,
                                      arguments: singleUserData.uid);
                                },
                                child: Row(
                                  children: [
                                    Container(
                                      margin: const EdgeInsets.symmetric(
                                          vertical: 10),
                                      width: 40,
                                      height: 40,
                                      child: ClipRRect(
                                        borderRadius: BorderRadius.circular(20),
                                        child: profileWidget(
                                            imageUrl:
                                                singleUserData.profileUrl),
                                      ),
                                    ),
                                    sizeHorizontal(10),
                                    Text(
                                      "${singleUserData.username}",
                                      style: const TextStyle(
                                          color: black,
                                          fontSize: 15,
                                          fontWeight: FontWeight.w600),
                                    )
                                  ],
                                ),
                              );
                            });
                      }),
            )
          ],
        ),
      ),
    );
  }

  _noFollowersWidget() {
    return const Center(
      child: Text(
        "No Followers",
        style: TextStyle(
            color: Colors.white, fontSize: 18, fontWeight: FontWeight.w600),
      ),
    );
  }
}
