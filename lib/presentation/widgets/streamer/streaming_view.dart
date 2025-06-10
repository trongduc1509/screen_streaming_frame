import 'package:flutter/material.dart';
import 'package:screen_streaming_frame/presentation/cubits/streaming/streaming_state.dart';
import 'package:screen_streaming_frame/presentation/widgets/foundations/app_button.dart';

class StreamingView extends StatefulWidget {
  const StreamingView({
    super.key,
    required this.status,
    required this.streamingAction,
  });

  final StreamingStatus status;
  final VoidCallback streamingAction;

  @override
  State<StreamingView> createState() => _StreamingViewState();
}

class _StreamingViewState extends State<StreamingView> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const SizedBox(width: double.infinity),
        AppButton(
          text: widget.status == StreamingStatus.streaming
              ? 'Stop Streaming'
              : 'Start Streaming',
          fixedSize: Size(MediaQuery.sizeOf(context).width / 3, 50),
          onPressed: widget.streamingAction,
        ),
      ],
    );
  }
}
