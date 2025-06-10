import 'package:flutter/cupertino.dart';

class ViewerSharingInitialize extends StatelessWidget {
  const ViewerSharingInitialize({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const SizedBox(width: double.infinity),
        Text("Processing..."),
        const SizedBox(height: 16),
        const CupertinoActivityIndicator(),
      ],
    );
  }
}