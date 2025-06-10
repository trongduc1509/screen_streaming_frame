import 'package:screen_streaming_frame/domain/entity/peer_entity.dart';

enum ViewingStatus {
  initial,
  viewing,
}

enum ViewerActionStatus {
  processing,
  none,
}

class ViewingState {
  const ViewingState({
    this.status = ViewingStatus.initial,
    this.actionStatus = ViewerActionStatus.none,
    required this.serverInfo,
    this.error,
  });

  final ViewingStatus status;
  final ViewerActionStatus actionStatus;
  final PeerEntity serverInfo;
  final String? error;

  bool get isInProgress => status != ViewingStatus.initial;

  ViewingState copyWith({
    ViewingStatus? status,
    ViewerActionStatus? actionStatus,
    PeerEntity? serverInfo,
    String? error,
  }) {
    return ViewingState(
      status: status ?? this.status,
      actionStatus: actionStatus ?? this.actionStatus,
      serverInfo: serverInfo ?? this.serverInfo,
      error: error ?? this.error,
    );
  }
}
