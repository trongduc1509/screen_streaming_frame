import 'dart:developer';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:screen_streaming_frame/domain/entity/connection_port.dart';
import 'package:screen_streaming_frame/domain/entity/peer_entity.dart';
import 'package:screen_streaming_frame/platform/p2p_streaming_channel.dart';
import 'package:screen_streaming_frame/presentation/cubits/viewing/viewing_state.dart';

class ViewingCubit extends Cubit<ViewingState> {
  ViewingCubit()
      : super(ViewingState(
          serverInfo: PeerEntity.empty(),
        )) {
    _startViewingProcess();
  }

  void _startViewingProcess() async {
    emit(state.copyWith(
      actionStatus: ViewerActionStatus.processing,
    ));

    try {
      final peerInfo = await P2PStreamingChannel.instance
          .startFrameStreamingServer(connectionPort);

      await P2PStreamingChannel.instance.startReceiving();

      emit(state.copyWith(
        status: ViewingStatus.viewing,
        serverInfo: peerInfo,
      ));
    } catch (err) {
      log(err.toString());
      emit(state.copyWith(
        error: err.toString(),
      ));
    } finally {
      emit(state.copyWith(
        actionStatus: ViewerActionStatus.none,
      ));
    }
  }

  Future<void> stopViewingProcess() async {
    emit(state.copyWith(
      actionStatus: ViewerActionStatus.processing,
    ));

    try {
      await P2PStreamingChannel.instance.stopReceiving();

      await P2PStreamingChannel.instance.stopFrameStreamingServer();

      emit(state.copyWith(
        status: ViewingStatus.initial,
      ));
    } catch (err) {
      emit(state.copyWith(
        error: err.toString(),
      ));
    } finally {
      emit(state.copyWith(
        actionStatus: ViewerActionStatus.none,
      ));
    }
  }
}
