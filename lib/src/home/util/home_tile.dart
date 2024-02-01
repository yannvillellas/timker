import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class HomeTile extends StatefulWidget {
  const HomeTile({super.key});

  @override
  State<HomeTile> createState() => _HomeTileState();
}

class _HomeTileState extends State<HomeTile> {
  @override
  Widget build(BuildContext context) {
    return Text(
      AppLocalizations.of(context)!.test,
    );
  }
}
