import 'package:flutter/material.dart';
import '../../../l10n/gen_l10n/app_localizations.dart';
import 'package:url_launcher/url_launcher.dart';

class SettingsPage extends StatelessWidget {
  const SettingsPage({super.key});

  @override
  Widget build(BuildContext context) {
    final local = AppLocalizations.of(context);

    return Scaffold(
      appBar: AppBar(
        title: Text(local.settingsTitle),
      ),
      body: ListView(
        children: [
          ListTile(
            title: Text(local.aboutSection),
          ),
          ListTile(
            title: Text(local.version),
            subtitle: Text(local.versionNumber),
          ),
          const Divider(),
          ListTile(
            title: Text(local.whyThisGame),
            subtitle: Text('${local.aboutDescription1}\n\n${local.aboutDescription2}'),
            isThreeLine: true,
          ),
          ListTile(
            title: Text(local.githubRepository),
            subtitle: Text(local.viewSourceCode),
            onTap: () => launchUrl(
              Uri.parse('https://github.com/ChristianScheub/Flutter_TowerGame'),
              mode: LaunchMode.externalApplication,
            ),
          ),
          ListTile(
            title: Text(local.dependencies),
            subtitle: Text(local.viewUsedLibraries),
            onTap: () => showLicensePage(
              context: context,
              applicationName: 'Tower Defense Game',
              applicationVersion: local.versionNumber,
            ),
          ),
        ],
      ),
    );
  }
}
