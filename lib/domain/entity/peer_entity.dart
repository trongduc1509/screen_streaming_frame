import 'dart:typed_data';

import 'package:equatable/equatable.dart';
import 'package:screen_streaming_frame/domain/entity/peer_role.dart';

class PeerEntity extends Equatable {
  const PeerEntity({
    required this.id,
    required this.role,
    required this.ip,
    required this.port,
  });

  final String id;
  final PeerRole role;
  final String ip;
  final int port;

  bool get isEmpty => this == const PeerEntity.empty();

  factory PeerEntity.fromBytes(Uint8List bytes) {
    final byteData = ByteData.sublistView(bytes);
    int offset = 0;

    int readInt() {
      final value = byteData.getInt32(offset, Endian.big);
      offset += 4;
      return value;
    }

    String readString() {
      final length = readInt();
      final value =
          String.fromCharCodes(bytes.sublist(offset, offset + length));
      offset += length;
      return value;
    }

    final id = readString();
    final roleValue = readInt();
    final role = PeerRole.values.firstWhere((e) => e.value == roleValue);
    final ip = readString();
    final port = readInt();

    return PeerEntity(
      id: id,
      role: role,
      ip: ip,
      port: port,
    );
  }

  const PeerEntity.empty() : this(
      id: '',
      role: PeerRole.unknown,
      ip: '',
      port: -1,
    );

  @override
  List<Object?> get props => [
        id,
        role,
        ip,
        port,
      ];
}
