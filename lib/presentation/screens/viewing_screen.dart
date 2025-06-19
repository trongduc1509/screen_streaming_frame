import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:screen_streaming_frame/presentation/cubits/viewing/viewing_cubit.dart';
import 'package:screen_streaming_frame/presentation/cubits/viewing/viewing_state.dart';
import 'package:screen_streaming_frame/presentation/widgets/viewer/viewer_sharing_initialize.dart';
import 'package:screen_streaming_frame/presentation/widgets/viewer/viewer_sharing_view.dart';

class ViewingScreen extends StatefulWidget {
  const ViewingScreen._();

  static Widget newInstance() {
    return BlocProvider<ViewingCubit>(
      create: (context) => ViewingCubit(),
      child: const ViewingScreen._(),
    );
  }

  @override
  State<ViewingScreen> createState() => _ViewingScreenState();
}

class _ViewingScreenState extends State<ViewingScreen> {
  late final _viewingCubit = context.read<ViewingCubit>();
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
            child: BlocListener<ViewingCubit, ViewingState>(
              listener: (context, state) {
                _maybeUpdateIsInProgressValue(state.isInProgress);
              },
              listenWhen: (previous, current) =>
                  (previous.status != current.status) ||
                  (previous.actionStatus != current.actionStatus),
              child: Scaffold(
                appBar: AppBar(
                  centerTitle: true,
                  title: const Text('Viewing Screen'),
                ),
                body: SafeArea(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const SizedBox(width: double.infinity),
                      Expanded(child: _buildBody()),
                    ],
                  ),
                ),
              ),
            ),
          );
        });
  }

  Widget _buildBody() {
    return BlocBuilder<ViewingCubit, ViewingState>(
      builder: (context, state) {
        switch (state.status) {
          case ViewingStatus.initial:
            return const ViewerSharingInitialize();
          //case ViewingStatus.serverStarted:
          case ViewingStatus.viewing:
            return ViewerSharingView(
              status: state.status,
              serverIpAddress: state.serverInfo.ip,
              cancelViewing: () async {
                await _viewingCubit.stopViewingProcess();
                _backToHome();
              },
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
      content: Text("Stop viewing before leaving"),
    ));
  }

  void _backToHome() {
    Navigator.of(context).pop();
  }
}
