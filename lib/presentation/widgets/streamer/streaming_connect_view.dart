import 'package:flutter/material.dart';
import 'package:screen_streaming_frame/presentation/widgets/foundations/app_button.dart';

class StreamingConnectView extends StatefulWidget {
  const StreamingConnectView({
    super.key,
    required this.onConnect,
  });

  final Function(String, int) onConnect;

  @override
  State<StreamingConnectView> createState() => _StreamingConnectViewState();
}

class _StreamingConnectViewState extends State<StreamingConnectView> {
  final _ipController = TextEditingController();
  final _portController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const SizedBox(width: double.infinity),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Row(
            children: [
              Expanded(
                child: TextField(
                  controller: _ipController,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'Viewer IP',
                  ),
                ),
              ),
              const SizedBox(width: 8),
              Expanded(
                child: TextField(
                  controller: _portController,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'Viewer Port',
                  ),
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 16),
        AppButton(
          text: 'Connect',
          fixedSize: Size(MediaQuery.sizeOf(context).width / 3, 50),
          onPressed: () {
            final ipAddr = _ipController.text.trim();
            final port = int.tryParse(_portController.text.trim());

            if (ipAddr.isNotEmpty && port != null) {
              widget.onConnect(ipAddr, port);
            }
          },
        ),
      ],
    );
  }

  @override
  void dispose() {
    _ipController.dispose();
    _portController.dispose();
    super.dispose();
  }
}
