import 'package:flutter/material.dart';

class DeleteConfirmationDialog extends StatelessWidget {
  final String employeeName;

  const DeleteConfirmationDialog({
    Key? key,
    required this.employeeName,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(
        'Confirm Delete',
        style: TextStyle(
            fontFamily: 'Lato',
            fontWeight: FontWeight.w600
        ),
      ),
      content: Text(
        'Are you sure you want to delete $employeeName?',
        style: TextStyle(
          fontFamily: 'Lato',
        ),
      ),
      actions: <Widget>[
        TextButton(
          onPressed: () => Navigator.of(context).pop(false),
          child: Text(
            'Cancel',
            style: TextStyle(
              color: Colors.grey[600],
              fontFamily: 'Lato',
            ),
          ),
        ),
        TextButton(
          onPressed: () => Navigator.of(context).pop(true),
          child: Text(
            'Delete',
            style: TextStyle(
                color: Colors.red[700],
                fontFamily: 'Lato',
                fontWeight: FontWeight.w600
            ),
          ),
        ),
      ],
    );
  }
}