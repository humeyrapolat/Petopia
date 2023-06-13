import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:iconsax/iconsax.dart';
import 'package:petopia/util/consts.dart';

import '../../../domain/entities/animal/animal_entity.dart';
import '../../cubit/user/user_cubit.dart';

class MatchedPage extends StatefulWidget {
  const MatchedPage({Key? key}) : super(key: key);

  @override
  _MatchedPageState createState() => _MatchedPageState();
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
            ),
          ),
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
                        Card(
                          elevation: 5,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(16),
                          ),
                          child: Column(
                            children: [
                              const SizedBox(height: 16.0),
                              Text(
                                "YOU ARE MATCHED",
                                style: TextStyle(
                                  color: darkBlueColor,
                                  fontSize: 20,
                                  shadows: [
                                    BoxShadow(
                                      color: Colors.black.withOpacity(0.5),
                                      spreadRadius: 2,
                                      blurRadius: 4,
                                      offset: const Offset(0, 2),
                                    ),
                                  ],
                                ),
                              ),
                              const SizedBox(height: 16.0),
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
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        TextButton.icon(
                                          icon: const Icon(Iconsax.message),
                                          label: const Text('Send Message'),
                                          onPressed: () {
                                            Navigator.pushNamed(
                                              context,
                                              PageConsts.chatPage,
                                            );
                                          },
                                        ),
                                      ],
                                    ),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        TextButton.icon(
                                          icon: const Icon(Iconsax.arrow5),
                                          label: const Text('Keep Swiping'),
                                          onPressed: () {
                                            Navigator.pushNamed(
                                              context,
                                              PageConsts.matchPage,
                                            );
                                          },
                                        ),
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
