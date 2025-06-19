import 'package:flutter/material.dart';
import 'package:screen_streaming_frame/presentation/widgets/foundations/app_button.dart';

class StreamingConnectView extends StatefulWidget {
  const StreamingConnectView({
    super.key,
    required this.onConnect,
  });

  final Function(String) onConnect;

  @override
  State<StreamingConnectView> createState() => _StreamingConnectViewState();
}

class _StreamingConnectViewState extends State<StreamingConnectView> {
  final _idController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(width: double.infinity),
          Text(
            "Enter viewer ID",
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            "Please enter the ID provided by the person who wants to view your screen",
            style: TextStyle(
              fontSize: 12,
              color: Colors.grey.shade700,
            ),
          ),
          const SizedBox(height: 16),
          TextField(
            controller: _idController,
            decoration: InputDecoration(
              border: OutlineInputBorder(),
              labelText: 'Viewer ID',
            ),
          ),
          const SizedBox(height: 16),
          AppButton(
            text: 'Connect',
            fixedSize: Size(MediaQuery.sizeOf(context).width, 50),
            onPressed: () {
              final id = _idController.text.trim();

              if (id.isNotEmpty) {
                widget.onConnect(id);
              }
            },
          ),
        ],
      ),
    );
  }

  @override
  void dispose() {
    _idController.dispose();
    super.dispose();
  }
}
