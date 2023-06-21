import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:petopia/util/consts.dart';
import 'package:petopia/injection_container.dart' as di;

import '../../../domain/entities/animal/animal_entity.dart';
import '../../../domain/usecases/firebase_usecases/user/get_current_uid_usecase.dart';
import '../../cubit/user/get_single_other_user/get_single_other_user_cubit.dart';
import '../../cubit/user/user_cubit.dart';

class MatchPage extends StatefulWidget {
  const MatchPage({Key? key}) : super(key: key);

  @override
  State<MatchPage> createState() => _MatchPageState();
}

class _MatchPageState extends State<MatchPage> {
  int currentIndex = 0;
  String _currentUid = "";
  Set<String?> dismissedUsers = Set<String?>();

  @override
  void initState() {
    di.sl<GetCurrentUidUseCase>().call().then((value) {
      setState(() {
        _currentUid = value;
        print("current : $_currentUid");
      });
    });

    BlocProvider.of<UserCubit>(context).getUsers(user: const AnimalEntity());

    super.initState();
  }

  void changeUser(int index) {
    setState(() {
      currentIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: darkBlueColor,
          title: const Text("Match"),
          leading: GestureDetector(
              onTap: () => Navigator.pop(context),
              child: const Icon(
                Icons.arrow_back,
                size: 32,
              )),
        ),
        backgroundColor: lightBlueColor,
        body: BlocBuilder<UserCubit, UserState>(
          builder: (context, userState) {
            if (userState is UserLoaded) {
              final List<AnimalEntity> users = userState.users;
              print("users = $users ");
              users.removeWhere((element) => element.uid == _currentUid);
              print("users = $users ");

              if (users.isEmpty) {
                return const Center(
                  child: Text('No users available.'),
                );
              }
              final AnimalEntity animal = users[currentIndex];
              // if (animal.uid != _currentUid) {
              return Center(
                child: SingleChildScrollView(
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      children: [
                        Card(
                          elevation: 5,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(16),
                          ),
                          child: Column(
                            children: [
                              const SizedBox(height: 16.0),
                              GestureDetector(
                                onTap: () {
                                  Navigator.pushNamed(context, PageConsts.singleUserProfilePage, arguments: animal.uid);
                                },
                                child: Container(
                                  width: 200,
                                  height: 250,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(16),
                                    image: DecorationImage(
                                      image: NetworkImage(animal.profileUrl ?? ''),
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.all(16.0),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Text(
                                      animal.username ?? '',
                                      style: const TextStyle(
                                        fontSize: 18,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    const SizedBox(height: 8.0),
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      children: [
                                        const Icon(Icons.pets, size: 16),
                                        const SizedBox(width: 4.0),
                                        Text(
                                          animal.type ?? '',
                                          style: TextStyle(
                                            fontSize: 14,
                                            color: Colors.grey[600],
                                          ),
                                        ),
                                        const SizedBox(width: 10.0),
                                        const Text("Breed: "),
                                        Text(
                                          animal.breed ?? '',
                                          style: TextStyle(
                                            fontSize: 14,
                                            color: Colors.grey[600],
                                          ),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(height: 16.0),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            IconButton(
                              onPressed: () {
                                changeUser((currentIndex + 1) % users.length);
                              },
                              icon: const Icon(Icons.clear, color: Colors.green),
                            ),
                            IconButton(
                              onPressed: () {
                                BlocProvider.of<UserCubit>(context)
                                    .getFavUsers(user: AnimalEntity(uid: _currentUid, otherUid: animal.uid))
                                    .then((value) {
                                  Navigator.pushNamed(context, PageConsts.matchedPage, arguments: animal.uid);
                                });

                                changeUser((currentIndex + 1) % users.length);
                              },
                              icon: const Icon(Icons.favorite, color: Colors.red),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              );
              // }
            }
            return const Center(
              child: CircularProgressIndicator(),
            );
          },
        ),
      ),
    );
  }
}
