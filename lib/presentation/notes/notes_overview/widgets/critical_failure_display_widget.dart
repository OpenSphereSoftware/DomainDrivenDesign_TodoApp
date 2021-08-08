import 'package:flutter/material.dart';

import 'package:dddcourse/domain/notes/note_failure.dart';

class CriticalFailureDisplay extends StatelessWidget {
  final NoteFailure noteFailure;
  const CriticalFailureDisplay({
    Key? key,
    required this.noteFailure,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          const Text(
            "😫",
            style: TextStyle(fontSize: 100),
          ),
          Text(
            noteFailure.maybeMap(
                insufficientPermissions: (_) => "Insufficient Permissions",
                orElse: () => "unexpected error \n please contact support."),
            textAlign: TextAlign.center,
            style: TextStyle(fontSize: 24),
          )
        ],
      ),
    );
  }
}
