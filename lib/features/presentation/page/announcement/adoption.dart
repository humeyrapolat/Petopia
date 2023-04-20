import 'package:flutter/material.dart';
import 'package:petopia/util/consts.dart';

class AdoptionPage extends StatelessWidget {
  const AdoptionPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 10),
      child: ListView(padding: const EdgeInsets.all(8), children: <Widget>[
        SizedBox(
          height: 50,
          child: ListTile(
            leading: Container(
              width: 30,
              height: 30,
              decoration: const BoxDecoration(
                  color: Colors.grey, shape: BoxShape.circle),
            ),
            title: const Text(
              "Username - Adopt Description",
              style:
                  TextStyle(color: darkGreenColor, fontWeight: FontWeight.bold),
            ),
            trailing: const Icon(
              Icons.bookmark_border,
              color: darkGreenColor,
            ),
          ),
        ),
        SizedBox(
          height: 50,
          child: ListTile(
            leading: Container(
              width: 30,
              height: 30,
              decoration: const BoxDecoration(
                  color: Colors.grey, shape: BoxShape.circle),
            ),
            title: const Text(
              "Username - Adopt Description",
              style:
                  TextStyle(color: darkGreenColor, fontWeight: FontWeight.bold),
            ),
            trailing: const Icon(
              Icons.bookmark_border,
              color: darkGreenColor,
            ),
          ),
        ),
        SizedBox(
          height: 50,
          child: ListTile(
            leading: Container(
              width: 30,
              height: 30,
              decoration: const BoxDecoration(
                  color: Colors.grey, shape: BoxShape.circle),
            ),
            title: const Text(
              "Username - Adopt Description",
              style:
                  TextStyle(color: darkGreenColor, fontWeight: FontWeight.bold),
            ),
            trailing: const Icon(
              Icons.bookmark_border,
              color: darkGreenColor,
            ),
          ),
        )
      ]),
    ));
  }
}
