import 'dart:developer';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:screen_streaming_frame/domain/entity/peer_entity.dart';
import 'package:screen_streaming_frame/platform/p2p_streaming_channel.dart';
import 'package:screen_streaming_frame/presentation/cubits/viewing/viewing_state.dart';

const int _signalingServerPort = 5588;

class ViewingCubit extends Cubit<ViewingState> {
  ViewingCubit()
      : super(ViewingState(
          serverInfo: PeerEntity.empty(),
        ));

  void startViewingProcess() async {
    emit(state.copyWith(
      actionStatus: ViewerActionStatus.processing,
    ));

    try {
      final peerInfo = await P2PStreamingChannel.instance
          .startSignalingServer(_signalingServerPort);

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

      await P2PStreamingChannel.instance.stopSignalingServer();

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
