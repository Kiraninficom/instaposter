import 'package:click/utils/styles.dart';
import 'package:flutter/material.dart';

class ConfirmationDialog extends StatefulWidget {
  var title;
  bool? sucess;
  bool? failure;
  ConfirmationDialog({super.key, this.failure, this.sucess, this.title});

  @override
  State<ConfirmationDialog> createState() => _ConfirmationDialogState();
}

class _ConfirmationDialogState extends State<ConfirmationDialog> {
  @override
  Widget build(BuildContext context) {
    return AlertDialog(
        icon: Icon(
          widget.sucess == true
              ? Icons.check_circle_outline_rounded
              : Icons.error,
          color: widget.sucess == true ? Colors.green : redcolor,
        ),
        title: Text(
          widget.title ?? "Error",
          style: TextStyle(
            color: widget.sucess == true ? Colors.green : redcolor,
          ),
        ));
  }
}
