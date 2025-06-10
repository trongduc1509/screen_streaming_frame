enum PeerRole {
  streamer(0),
  viewer(1),
  unknown(-1);

  const PeerRole(this.value);

  final int value;
}
