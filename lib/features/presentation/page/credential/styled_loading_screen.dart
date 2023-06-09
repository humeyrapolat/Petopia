import 'package:flutter/material.dart';

class StyledLoadingScreen extends StatelessWidget {
  const StyledLoadingScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Align(
        alignment: Alignment.center,
        child: Column(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.center,
          children: const [
            CircularProgressIndicator(),
            Padding(
              padding: EdgeInsets.all(8),
              child: Text("Loading..."),
            ),
          ],
        ),
      ),
    );
  }
}
