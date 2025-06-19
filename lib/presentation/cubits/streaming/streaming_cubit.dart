import 'dart:developer';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:screen_streaming_frame/domain/entity/connection_port.dart';
import 'package:screen_streaming_frame/platform/p2p_streaming_channel.dart';
import 'package:screen_streaming_frame/presentation/cubits/streaming/streaming_state.dart';

class StreamingCubit extends Cubit<StreamingState> {
  StreamingCubit() : super(const StreamingState(
            // signalServerInfo: PeerEntity.empty(),
            ));

  void startStreamingProcess({
    required String viewerId,
  }) async {
    emit(state.copyWith(
      actionStatus: StreamingActionStatus.processing,
    ));

    try {
      final streamingServiceRes = await P2PStreamingChannel.instance
          .startStreaming(viewerId, connectionPort);

      if (streamingServiceRes) {
        emit(state.copyWith(
          status: StreamingStatus.streaming,
        ));
      }

      throw Exception('Failed to start streaming');
    } catch (err) {
      log(err.toString());
      emit(state.copyWith(
        error: err.toString(),
      ));
    } finally {
      emit(state.copyWith(
        actionStatus: StreamingActionStatus.none,
      ));
    }
  }

  void stopStreamingProcess() async {
    emit(state.copyWith(
      actionStatus: StreamingActionStatus.processing,
    ));

    try {
      final streamingServiceRes =
          await P2PStreamingChannel.instance.stopStreaming();

      if (streamingServiceRes) {
        emit(state.copyWith(
          status: StreamingStatus.initial,
        ));
      }

      throw Exception('Failed to stop streaming');
    } catch (err) {
      log(err.toString());
      emit(state.copyWith(
        error: err.toString(),
      ));
    } finally {
      emit(state.copyWith(
        actionStatus: StreamingActionStatus.none,
      ));
    }
  }
}
