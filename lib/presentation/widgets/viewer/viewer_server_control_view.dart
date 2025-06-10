// import 'package:flutter/material.dart';
// import 'package:screen_streaming_frame/presentation/cubits/viewing/viewing_state.dart';
// import 'package:screen_streaming_frame/presentation/widgets/foundations/app_button.dart';

// class ViewerServerControlView extends StatefulWidget {
//   const ViewerServerControlView({
//     super.key,
//     required this.status,
//     required this.serverAction,
//   });

//   final ViewingStatus status;
//   final VoidCallback serverAction;

//   @override
//   State<ViewerServerControlView> createState() =>
//       _ViewerServerControlViewState();
// }

// class _ViewerServerControlViewState extends State<ViewerServerControlView> {
//   @override
//   Widget build(BuildContext context) {
//     return Column(
//       mainAxisAlignment: MainAxisAlignment.center,
//       children: [
//         const SizedBox(width: double.infinity),
//         AppButton(
//           text: widget.status == ViewingStatus.serverStarted
//               ? 'Stop Server'
//               : 'Start Server',
//           fixedSize: Size(MediaQuery.sizeOf(context).width / 3, 50),
//           onPressed: widget.serverAction,
//         ),
//       ],
//     );
//   }
// }
