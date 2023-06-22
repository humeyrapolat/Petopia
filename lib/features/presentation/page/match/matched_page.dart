import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:iconsax/iconsax.dart';
import 'package:petopia/util/consts.dart';
import 'package:flutter_phone_direct_caller/flutter_phone_direct_caller.dart';

import '../../../domain/entities/animal/animal_entity.dart';
import '../../cubit/user/get_single_other_user/get_single_other_user_cubit.dart';
import '../../cubit/user/user_cubit.dart';

class MatchedPage extends StatefulWidget {
  const MatchedPage({super.key, required this.otherUserId});
  final String otherUserId;

  @override
  _MatchedPageState createState() => _MatchedPageState();
}

class _MatchedPageState extends State<MatchedPage> {
  @override
  void initState() {
    BlocProvider.of<GetSingleOtherUserCubit>(context).getSingleOtherUser(otherUid: widget.otherUserId);
    super.initState();
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
        body: BlocBuilder<GetSingleOtherUserCubit, GetSingleOtherUserState>(
          builder: (context, userState) {
            if (userState is GetSingleOtherUserLoaded) {
              final singleUser = userState.otherUser;
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
                                    image: NetworkImage(singleUser.profileUrl ?? ''),
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
                                      singleUser.username ?? '',
                                      style: const TextStyle(
                                        fontSize: 18,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    const SizedBox(height: 8.0),
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      children: [
                                        TextButton.icon(
                                          icon: const Icon(Iconsax.call),
                                          label: const Text('Call '),
                                          onPressed: () {
                                            makePhoneCall(singleUser.phoneNumber!);
                                          },
                                        ),
                                      ],
                                    ),
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      children: [
                                        TextButton.icon(
                                          icon: const Icon(Iconsax.arrow5),
                                          label: const Text('Keep Swiping'),
                                          onPressed: () => Navigator.pop(context),
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

  void makePhoneCall(String phoneNumber) async {
    bool? res = await FlutterPhoneDirectCaller.callNumber(phoneNumber);
    if (!res!) {
      print('Arama başarısız oldu');
    }
  }
}
