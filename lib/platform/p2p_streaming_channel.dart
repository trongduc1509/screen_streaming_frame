import 'dart:developer';

import 'package:flutter/services.dart';
import 'package:screen_streaming_frame/domain/entity/frame_entity.dart';
import 'package:screen_streaming_frame/domain/entity/peer_entity.dart';

class P2PStreamingChannel {
  static const MethodChannel _methodChannel =
      MethodChannel('com.duczxje.io/channel/main');
  static const EventChannel _eventChannel =
      EventChannel('com.duczxje.io/channel/frame_event');

  P2PStreamingChannel._();

  static final P2PStreamingChannel _instance = P2PStreamingChannel._();

  static P2PStreamingChannel get instance => _instance;

  /// METHODS
  Future<PeerEntity> startSignalingServer(int port) async {
    try {
      final result = await _methodChannel.invokeMethod<Uint8List>(
        'startSignalingServer',
        {'port': port},
      );

      if (result != null && result.isNotEmpty) {
        return PeerEntity.fromBytes(result);
      }

      throw Exception('Failed to start signaling server');
    } on PlatformException catch (e) {
      log(e.message ?? 'Starting signaling server error');
      return PeerEntity.empty();
    }
  }

  Future<PeerEntity> startFrameStreamingServer(int port) async {
    try {
      final result = await _methodChannel.invokeMethod<Uint8List>(
        'startFrameStreamingServer',
        {'port': port},
      );

      if (result != null && result.isNotEmpty) {
        return PeerEntity.fromBytes(result);
      }

      throw Exception('Failed to start frame streaming server');
    } on PlatformException catch (e) {
      log(e.message ?? 'Starting frame streaming server error');
      return PeerEntity.empty();
    }
  }

  Future<void> stopFrameStreamingServer() async {
    try {
      await _methodChannel.invokeMethod('stopFrameStreamingServer');
    } on PlatformException catch (e) {
      log(e.message ?? 'Stopping frame streaming server error');
    }
  }

  Future<bool> stopSignalingServer() async {
    try {
      final result = await _methodChannel.invokeMethod<bool>(
        'stopSignalingServer',
      );

      return result ?? false;
    } on PlatformException catch (e) {
      log(e.message ?? 'Stopping signaling server error');
      return false;
    }
  }

  Future<bool> startConnectingToPeer(String ip, int port) async {
    try {
      final result = await _methodChannel.invokeMethod<bool>(
        'startConnectingToPeer',
        {'ip': ip, 'port': port},
      );

      return result ?? false;
    } on PlatformException catch (e) {
      log(e.message ?? 'Starting connecting to peer error');
      return false;
    }
  }

  Future<bool> startStreaming(String ip, int port) async {
    try {
      final result = await _methodChannel.invokeMethod<bool>(
        'startStreaming',
        {'ip': ip, 'port': port},
      );

      return result ?? false;
    } on PlatformException catch (e) {
      log(e.message ?? 'Starting streaming error');
      return false;
    }
  }

  Future<bool> stopStreaming() async {
    try {
      final result = await _methodChannel.invokeMethod<bool>('stopStreaming');

      return result ?? false;
    } on PlatformException catch (e) {
      log(e.message ?? 'Stopping streaming error');
      return false;
    }
  }

  Future<bool> startReceiving() async {
    try {
      final result = await _methodChannel.invokeMethod<bool>('startReceiving');

      return result ?? false;
    } on PlatformException catch (e) {
      log(e.message ?? 'Starting receiving error');
      return false;
    }
  }

  Future<bool> stopReceiving() async {
    try {
      final result = await _methodChannel.invokeMethod<bool>('stopReceiving');

      return result ?? false;
    } on PlatformException catch (e) {
      log(e.message ?? 'Stopping receiving error');
      return false;
    }
  }

  /// EVENTS
  Stream<FrameEntity> get frameStream => _eventChannel
      .receiveBroadcastStream()
      .map((e) => e as Uint8List)
      .map((e) => FrameEntity(payload: e));
}
