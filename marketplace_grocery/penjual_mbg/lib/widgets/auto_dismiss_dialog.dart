import 'dart:async';
import 'package:flutter/material.dart';

/// A wrapper widget for Dialogs that automatically dismisses after a given [duration]
/// and immediately cancels the timer when tapped or disposed.
class AutoDismissDialog extends StatefulWidget {
  final Widget child;
  final Duration duration;

  const AutoDismissDialog({
    super.key,
    required this.child,
    this.duration = const Duration(milliseconds: 1800),
  });

  @override
  State<AutoDismissDialog> createState() => _AutoDismissDialogState();
}

class _AutoDismissDialogState extends State<AutoDismissDialog> {
  Timer? _timer;

  @override
  void initState() {
    super.initState();
    _timer = Timer(widget.duration, () {
      if (mounted) {
        Navigator.of(context).pop();
      }
    });
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        _timer?.cancel();
        if (mounted) {
          Navigator.of(context).pop();
        }
      },
      behavior: HitTestBehavior.opaque,
      child: widget.child,
    );
  }
}
