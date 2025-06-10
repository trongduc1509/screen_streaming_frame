import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:screen_streaming_frame/domain/entity/peer_entity.dart';
import 'package:screen_streaming_frame/domain/entity/peer_role.dart';
import 'package:screen_streaming_frame/platform/p2p_streaming_channel.dart';
import 'package:screen_streaming_frame/presentation/cubits/streaming/streaming_state.dart';

class StreamingCubit extends Cubit<StreamingState> {
  StreamingCubit()
      : super(StreamingState(
          viewerInfo: PeerEntity.empty(),
        ));

  void connectToViewer(String viewerIp, int viewerPort) async {
    emit(state.copyWith(
      actionStatus: StreamingActionStatus.processing,
    ));

    try {
      final result = await P2PStreamingChannel.instance.startConnectingToPeer(
        viewerIp,
        viewerPort,
      );

      if (result) {
        return emit(state.copyWith(
          status: StreamingStatus.connected,
          viewerInfo: PeerEntity(
            id: '',
            role: PeerRole.viewer,
            ip: viewerIp,
            port: viewerPort,
          ),
        ));
      }

      throw Exception('Failed to connect to viewer');
    } catch (err) {
      emit(state.copyWith(
        error: err.toString(),
      ));
    } finally {
      emit(state.copyWith(
        actionStatus: StreamingActionStatus.none,
      ));
    }
  }

  Future<void> startStreaming() async {
    emit(state.copyWith(
      actionStatus: StreamingActionStatus.processing,
    ));

    try {
      final result = await P2PStreamingChannel.instance.startStreaming(
        state.viewerInfo.ip,
        state.viewerInfo.port,
      );

      if (result) {
        return emit(state.copyWith(
          status: StreamingStatus.streaming,
        ));
      }

      throw Exception('Failed to start streaming');
    } catch (err) {
      emit(state.copyWith(
        error: err.toString(),
      ));
    } finally {
      emit(state.copyWith(
        actionStatus: StreamingActionStatus.none,
      ));
    }
  }

  Future<void> stopStreaming() async {
    emit(state.copyWith(
      actionStatus: StreamingActionStatus.processing,
    ));

    try {
      final result = await P2PStreamingChannel.instance.stopStreaming();

      if (result) {
        return emit(state.copyWith(
          status: StreamingStatus.connected,
        ));
      }

      throw Exception('Failed to stop streaming');
    } catch (err) {
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
