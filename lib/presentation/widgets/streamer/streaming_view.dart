import 'package:flutter/material.dart';
import 'package:screen_streaming_frame/presentation/widgets/foundations/app_button.dart';
import 'dart:async';

class StreamingView extends StatefulWidget {
  const StreamingView({
    super.key,
    required this.streamingAction,
  });

  final VoidCallback streamingAction;

  @override
  State<StreamingView> createState() => _StreamingViewState();
}

class _StreamingViewState extends State<StreamingView> {
  final ValueNotifier<int> _elapsedSeconds = ValueNotifier(0);
  Timer? _timer;

  @override
  void initState() {
    super.initState();
    _timer = Timer.periodic(
      const Duration(seconds: 1),
      (timer) => _elapsedSeconds.value++,
    );
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  String _formatDuration(int seconds) {
    final hours = (seconds ~/ 3600).toString().padLeft(2, '0');
    final minutes = ((seconds % 3600) ~/ 60).toString().padLeft(2, '0');
    final secs = (seconds % 60).toString().padLeft(2, '0');
    return '$hours:$minutes:$secs';
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const SizedBox(
          width: double.infinity,
          height: 16,
        ),
        Expanded(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 16.0),
                child: ValueListenableBuilder(
                  valueListenable: _elapsedSeconds,
                  builder: (context, value, child) {
                    return Text(
                      'Streaming time:\n${_formatDuration(value)}',
                      style: const TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                      textAlign: TextAlign.center,
                    );
                  },
                ),
              ),
            ],
          ),
        ),
        AppButton(
          text: 'Stop streaming',
          fixedSize: Size(MediaQuery.sizeOf(context).width / 2, 50),
          onPressed: widget.streamingAction,
        ),
        const SizedBox(height: 16),
      ],
    );
  }
}
