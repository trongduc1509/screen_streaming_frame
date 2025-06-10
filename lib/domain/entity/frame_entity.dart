import 'package:flutter/foundation.dart';
import 'package:equatable/equatable.dart';

class FrameEntity extends Equatable {
  const FrameEntity({
    required this.payload,
  });

  final Uint8List payload;

  @override
  List<Object?> get props => [
        payload,
      ];
}
