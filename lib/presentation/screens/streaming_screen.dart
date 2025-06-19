import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:screen_streaming_frame/presentation/cubits/streaming/streaming_cubit.dart';
import 'package:screen_streaming_frame/presentation/cubits/streaming/streaming_state.dart';
import 'package:screen_streaming_frame/presentation/widgets/streamer/streaming_connect_view.dart';
import 'package:screen_streaming_frame/presentation/widgets/streamer/streaming_view.dart';

class StreamingScreen extends StatefulWidget {
  const StreamingScreen._();

  static Widget newInstance() {
    return BlocProvider<StreamingCubit>(
      create: (context) => StreamingCubit(),
      child: const StreamingScreen._(),
    );
  }

  @override
  State<StreamingScreen> createState() => _StreamingScreenState();
}

class _StreamingScreenState extends State<StreamingScreen> {
  late final _streamingCubit = context.read<StreamingCubit>();
  ValueNotifier<bool> isInProgress = ValueNotifier(false);

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<bool>(
      valueListenable: isInProgress,
      builder: (context, value, child) {
        return PopScope(
          canPop: !value,
          onPopInvokedWithResult: (bool didPop, dynamic result) {
            if (!didPop && value) {
              _showWarning();
            }
          },
          child: BlocListener<StreamingCubit, StreamingState>(
            listener: (context, state) {
              _maybeUpdateIsInProgressValue(state.isInProgress);
            },
            listenWhen: (previous, current) =>
                (previous.status != current.status) ||
                (previous.actionStatus != current.actionStatus),
            child: Scaffold(
              appBar: AppBar(
                centerTitle: true,
                title: const Text('Streaming Screen'),
              ),
              body: SafeArea(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const SizedBox(width: double.infinity),
                    Expanded(
                      child: _buildBody(),
                    ),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }

  Widget _buildBody() {
    return BlocBuilder<StreamingCubit, StreamingState>(
      builder: (context, state) {
        switch (state.status) {
          case StreamingStatus.initial:
            return StreamingConnectView(
              onConnect: (viewerId) {
                _streamingCubit.startStreamingProcess(
                  viewerId: viewerId,
                );
              },
            );
          case StreamingStatus.streaming:
            return StreamingView(
              streamingAction: _streamingCubit.stopStreamingProcess,
            );
        }
      },
      buildWhen: (previous, current) => previous.status != current.status,
    );
  }

  void _maybeUpdateIsInProgressValue(bool value) {
    if (value != isInProgress.value) {
      isInProgress.value = value;
    }
  }

  void _showWarning() {
    ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
      content: Text("Stop streaming before leaving"),
    ));
  }
}
