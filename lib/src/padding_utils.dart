// ignore_for_file: public_member_api_docs

import 'package:flutter/material.dart';

class FinalPadding extends StatelessWidget {
  const FinalPadding({
    super.key,
    this.useFloating = false,
    this.useSystemNavigation = true,
  });

  final bool useFloating, useSystemNavigation;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: _finalSize(context, useFloating, useSystemNavigation),
    );
  }
}

class SliverFinalPadding extends StatelessWidget {
  const SliverFinalPadding({
    super.key,
    this.useFloating = false,
    this.useSystemNavigation = true,
  });

  final bool useFloating, useSystemNavigation;

  @override
  Widget build(BuildContext context) {
    return SliverPadding(
      padding: EdgeInsets.only(
        bottom: _finalSize(context, useFloating, useSystemNavigation),
      ),
    );
  }
}

double _finalSize(
    BuildContext context, bool useFloating, bool useSystemNavigation) {
  final double fabSize = useFloating ? 74 : 0;
  if (useSystemNavigation) {
    return MediaQuery.of(context).padding.bottom + fabSize;
  } else {
    return fabSize;
  }
}
