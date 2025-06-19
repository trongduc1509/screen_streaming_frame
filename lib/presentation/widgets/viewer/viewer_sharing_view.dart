import 'package:flutter/material.dart';
import 'package:screen_streaming_frame/platform/p2p_streaming_channel.dart';
import 'package:screen_streaming_frame/presentation/cubits/viewing/viewing_state.dart';
import 'package:screen_streaming_frame/presentation/widgets/foundations/app_button.dart';

class ViewerSharingView extends StatefulWidget {
  const ViewerSharingView({
    super.key,
    required this.status,
    required this.serverIpAddress,
    required this.cancelViewing,
  });

  final ViewingStatus status;
  final String serverIpAddress;
  final VoidCallback cancelViewing;

  @override
  State<ViewerSharingView> createState() => _ViewerSharingViewState();
}

class _ViewerSharingViewState extends State<ViewerSharingView> {
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const SizedBox(height: 16),
        Text(
          "Your ID",
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 8),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          decoration: BoxDecoration(
            color: Colors.grey.shade300,
            borderRadius: BorderRadius.circular(10),
          ),
          child: Text(
            widget.serverIpAddress,
            style: const TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        const SizedBox(height: 8),
        Text(
          "Share this ID with the person who is sharing the content",
          style: TextStyle(
            fontSize: 12,
          ),
          textAlign: TextAlign.center,
        ),
        const SizedBox(height: 8),
        Expanded(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              StreamBuilder(
                stream: P2PStreamingChannel.instance.frameStream,
                builder: (context, snapshot) {
                  return Text(
                    "Frame content:\n${snapshot.data}",
                    textAlign: TextAlign.center,
                  );
                },
              ),
            ],
          ),
        ),
        const SizedBox(height: 8),
        AppButton(
          text: 'Stop viewing',
          fixedSize: Size(MediaQuery.sizeOf(context).width / 2, 30),
          onPressed: widget.cancelViewing,
        ),
        const SizedBox(height: 16),
      ],
    );
  }
}
