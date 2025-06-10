import 'package:flutter/material.dart';
import 'package:screen_streaming_frame/presentation/screens/streaming_screen.dart';
import 'package:screen_streaming_frame/presentation/screens/viewing_screen.dart';
import 'package:screen_streaming_frame/presentation/widgets/foundations/app_button.dart';

class RoleSelectionScreen extends StatefulWidget {
  const RoleSelectionScreen({super.key});

  @override
  State<RoleSelectionScreen> createState() => _RoleSelectionScreenState();
}

class _RoleSelectionScreenState extends State<RoleSelectionScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text('Screen Streaming'),
      ),
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const SizedBox(width: double.infinity),
            Text(
              'Select your role:',
              style: Theme.of(context).textTheme.titleLarge,
            ),
            const SizedBox(height: 24),
            AppButton(
              text: 'Streamer',
              fixedSize: _buttonSize,
              onPressed: () {
                _navigateToScreen(StreamingScreen.newInstance());
              },
            ),
            const SizedBox(height: 12),
            AppButton(
              text: 'Viewer',
              fixedSize: _buttonSize,
              onPressed: () {
                _navigateToScreen(ViewingScreen.newInstance());
              },
            ),
          ],
        ),
      ),
    );
  }

  void _navigateToScreen(Widget screen) {
    Navigator.push(context, MaterialPageRoute(builder: (context) => screen));
  }

  Size get _buttonSize => Size(MediaQuery.sizeOf(context).width / 3, 50);
}
