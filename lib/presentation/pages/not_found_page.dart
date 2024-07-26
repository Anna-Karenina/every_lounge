import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class NotFoundPage extends StatelessWidget {
  const NotFoundPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
          child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 38.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Flexible(
                child: Text(
              AppLocalizations.of(context)!.network_error,
              textAlign: TextAlign.center,
              style: Theme.of(context).textTheme.bodyLarge,
            )),
            const SizedBox(
              height: 20,
            ),
            IconButton.outlined(
                onPressed: () => Navigator.pop(context),
                icon: const Icon(Icons.refresh))
          ],
        ),
      )),
    );
  }
}
