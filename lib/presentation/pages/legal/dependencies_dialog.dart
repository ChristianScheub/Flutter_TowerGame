import 'package:flutter/material.dart';

class DependencyInfo {
  final String name;
  final String version;
  final String license;
  final String url;

  const DependencyInfo({
    required this.name,
    required this.version,
    required this.license,
    required this.url,
  });
}

class DependenciesDialog extends StatelessWidget {
  static const dependencies = [
    DependencyInfo(
      name: 'flutter',
      version: 'SDK',
      license: 'BSD-3-Clause',
      url: 'https://github.com/flutter/flutter',
    ),
    DependencyInfo(
      name: 'flame',
      version: '^1.8.0',
      license: 'MIT',
      url: 'https://github.com/flame-engine/flame',
    ),
    DependencyInfo(
      name: 'equatable',
      version: '^2.0.5',
      license: 'MIT',
      url: 'https://github.com/felangel/equatable',
    ),
    DependencyInfo(
      name: 'shared_preferences',
      version: '^2.2.0',
      license: 'BSD-3-Clause',
      url: 'https://github.com/flutter/plugins',
    ),
    DependencyInfo(
      name: 'get_it',
      version: '^7.6.0',
      license: 'MIT',
      url: 'https://github.com/fluttercommunity/get_it',
    ),
    DependencyInfo(
      name: 'injectable',
      version: '^2.1.2',
      license: 'MIT',
      url: 'https://github.com/Milad-Akarie/injectable',
    ),
    DependencyInfo(
      name: 'flame_tiled',
      version: '^1.13.0',
      license: 'MIT',
      url: 'https://github.com/flame-engine/flame',
    ),
    DependencyInfo(
      name: 'flutter_gen',
      version: '^5.10.0',
      license: 'MIT',
      url: 'https://github.com/FlutterGen/flutter_gen',
    ),
    DependencyInfo(
      name: 'flutter_html',
      version: '^3.0.0',
      license: 'MIT',
      url: 'https://github.com/Sub6Resources/flutter_html',
    ),
    DependencyInfo(
      name: 'url_launcher',
      version: '^6.3.1',
      license: 'BSD-3-Clause',
      url: 'https://github.com/flutter/plugins',
    ),
  ];

  const DependenciesDialog({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Dialog(
      child: ConstrainedBox(
        constraints: const BoxConstraints(
          maxWidth: 600,
          maxHeight: 500,
        ),
        child: Column(
          children: [
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Theme.of(context).primaryColor,
                borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(4),
                  topRight: Radius.circular(4),
                ),
              ),
              child: const Row(
                children: [
                  Icon(Icons.library_books, color: Colors.white),
                  SizedBox(width: 8),
                  Text(
                    'Project Dependencies',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ),
            Expanded(
              child: ListView.separated(
                padding: const EdgeInsets.all(16),
                itemCount: dependencies.length,
                separatorBuilder: (context, index) => const Divider(),
                itemBuilder: (context, index) {
                  final dep = dependencies[index];
                  return ListTile(
                    title: Text(
                      dep.name,
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    subtitle: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const SizedBox(height: 4),
                        Row(
                          children: [
                            const Icon(Icons.tag, size: 16),
                            const SizedBox(width: 4),
                            Text('Version: ${dep.version}'),
                          ],
                        ),
                        const SizedBox(height: 2),
                        Row(
                          children: [
                            const Icon(Icons.gavel, size: 16),
                            const SizedBox(width: 4),
                            Text('License: ${dep.license}'),
                          ],
                        ),
                        const SizedBox(height: 2),
                        Row(
                          children: [
                            const Icon(Icons.link, size: 16),
                            const SizedBox(width: 4),
                            Expanded(
                              child: Text(
                                dep.url,
                                style: TextStyle(
                                  color: Theme.of(context).primaryColor,
                                  decoration: TextDecoration.underline,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                    isThreeLine: true,
                  );
                },
              ),
            ),
            Container(
              padding: const EdgeInsets.all(8),
              child: TextButton(
                onPressed: () => Navigator.pop(context),
                child: const Text('Close'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}