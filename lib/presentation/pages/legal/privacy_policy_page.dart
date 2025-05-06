import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import '../../../l10n/gen_l10n/app_localizations.dart';

class PrivacyPolicyPage extends StatelessWidget {
  const PrivacyPolicyPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final t = AppLocalizations.of(context);

    final privacyLines = [
      t.privacyline1,
      t.privacyline2,
      t.privacyline3,
      t.privacyline4,
      t.privacyline5,
      t.privacyline6,
      t.privacyline7,
      t.privacyline8,
      t.privacyline9,
      t.privacyline10,
      t.privacyline11,
      t.privacyline12,
      t.privacyline13,
      t.privacyline14,
      t.privacyline15,
      t.privacyline16,
      t.privacyline17,
      t.privacyline18,
      t.privacyline19,
      t.privacyline20,
      t.privacyline21,
      t.privacyline22,
      t.privacyline23,
      t.privacyline24,
      t.privacyline25,
    ];

    return Scaffold(
      appBar: AppBar(
        title: Text(t.privacyPolicyTitle),
        centerTitle: true,
      ),
      body: ListView.builder(
        padding: const EdgeInsets.all(16),
        itemCount: privacyLines.length,
        itemBuilder: (context, index) {
          return Padding(
            padding: const EdgeInsets.only(bottom: 16),
            child: Html(data: privacyLines[index]),
          );
        },
      ),
    );
  }
}

