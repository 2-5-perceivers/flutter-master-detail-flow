import 'package:flutter/material.dart';
import 'package:master_detail_flow/master_detail_flow.dart';

class MasterLabel extends StatelessWidget {
  const MasterLabel({super.key, required this.data});

  final String data;

  @override
  Widget build(BuildContext context) {
    final viewMode = MDController.viewModeOf(context);
    final indent = viewMode == MDViewMode.lateral ? 24.0 : 16.0;

    return Padding(
      padding: EdgeInsets.only(left: indent, top: 8.0, bottom: 8.0),
      child: Text(
        data,
        style: Theme.of(context).textTheme.labelLarge!.copyWith(
              color: Theme.of(context).colorScheme.primary,
            ),
      ),
    );
  }
}
