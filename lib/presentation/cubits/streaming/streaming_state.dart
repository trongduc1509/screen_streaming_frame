enum StreamingStatus {
  initial,
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
    // required this.signalServerInfo,
    this.error,
  });

  final StreamingStatus status;
  final StreamingActionStatus actionStatus;
  // final PeerEntity signalServerInfo;
  final String? error;

  bool get isInProgress => status != StreamingStatus.initial;

  StreamingState copyWith({
    StreamingStatus? status,
    StreamingActionStatus? actionStatus,
    //PeerEntity? signalServerInfo,
    String? error,
  }) {
    return StreamingState(
      status: status ?? this.status,
      actionStatus: actionStatus ?? this.actionStatus,
      // signalServerInfo: signalServerInfo ?? this.signalServerInfo,
      error: error ?? this.error,
    );
  }
}
