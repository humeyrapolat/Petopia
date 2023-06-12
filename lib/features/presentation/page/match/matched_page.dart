import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:iconsax/iconsax.dart';
import 'package:petopia/util/consts.dart';

import '../../../domain/entities/animal/animal_entity.dart';
import '../../cubit/user/user_cubit.dart';

class MatchedPage extends StatefulWidget {
  const MatchedPage({super.key});

  @override
  State<MatchedPage> createState() => _MatchedPageState();
}

class _MatchedPageState extends State<MatchedPage> {
  int currentIndex = 0;

  @override
  void initState() {
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
          title: const Text("Matched"),
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
              if (users.isEmpty) {
                return const Center(
                  child: Text('No users available.'),
                );
              }
              final AnimalEntity user = users[currentIndex];
              return Center(
                child: SingleChildScrollView(
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      children: [
                        const Text(
                          "YOU ARE MATCHED",
                          style: TextStyle(color: darkBlueColor, fontSize: 30),
                        ),
                        Card(
                          elevation: 5,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(16),
                          ),
                          child: Column(
                            children: [
                              Container(
                                width: 200,
                                height: 250,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(16),
                                  image: DecorationImage(
                                    image: NetworkImage(user.profileUrl ?? ''),
                                    fit: BoxFit.cover,
                                  ),
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.all(16.0),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Text(
                                      user.username ?? '',
                                      style: const TextStyle(
                                        fontSize: 18,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    const SizedBox(height: 8.0),
                                    Text(
                                      user.name ?? '',
                                      style: TextStyle(
                                        fontSize: 16,
                                        color: Colors.grey[600],
                                      ),
                                    ),
                                    const SizedBox(height: 8.0),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        GestureDetector(
                                          onTap: () {
                                            Navigator.pushNamed(
                                                context, PageConsts.chatPage);
                                          },
                                          child: const Icon(
                                            Iconsax.message,
                                            color: darkPinkColor,
                                          ),
                                        ),
                                        const SizedBox(width: 4.0),
                                        const Text("SEND MESSAGE"),
                                      ],
                                    ),
                                    const SizedBox(height: 8.0),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        GestureDetector(
                                          onTap: () {
                                            Navigator.pushNamed(
                                                context, PageConsts.matchPage);
                                          },
                                          child: const Icon(
                                            Iconsax.arrow5,
                                            color: darkPinkColor,
                                          ),
                                        ),
                                        const SizedBox(width: 4.0),
                                        const Text("KEEP SWIPPING"),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              );
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
