import 'package:screen_streaming_frame/domain/entity/peer_entity.dart';

enum StreamingStatus {
  initial,
  connected,
  streaming,
}

enum StreamingActionStatus {
  processing,
  none,
}

class StreamingState {
  const StreamingState({
    this.status = StreamingStatus.initial,
    this.actionStatus = StreamingActionStatus.none,
    required this.viewerInfo,
    this.error,
  });

  final StreamingStatus status;
  final StreamingActionStatus actionStatus;
  final PeerEntity viewerInfo;
  final String? error;

  bool get isInProgress => status != StreamingStatus.initial;

  StreamingState copyWith({
    StreamingStatus? status,
    StreamingActionStatus? actionStatus,
    PeerEntity? viewerInfo,
    String? error,
  }) {
    return StreamingState(
      status: status ?? this.status,
      actionStatus: actionStatus ?? this.actionStatus,
      viewerInfo: viewerInfo ?? this.viewerInfo,
      error: error ?? this.error,
    );
  }
}
