import 'package:flutter/material.dart';

class WidgetStatusCard extends StatelessWidget {
  const WidgetStatusCard({
    super.key,
    required this.actionDone,
    required this.isLoading,
  });

  final bool actionDone;
  final bool isLoading;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Card(
      elevation: 4,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
      ),
      child: Container(
        width: double.infinity,
        padding: const EdgeInsets.all(24),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(16),
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: actionDone
                ? [Colors.green.shade400, Colors.blue.shade400]
                : [Colors.purple.shade400, Colors.blue.shade400],
          ),
        ),
        child: Column(
          children: [
            Icon(
              actionDone ? Icons.check_circle : Icons.touch_app,
              size: 48,
              color: Colors.white,
            ),
            const SizedBox(height: 16),
            Text(
              actionDone ? 'Action Complete!' : 'Welcome',
              style: theme.textTheme.headlineSmall?.copyWith(
                color: Colors.white,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              actionDone
                  ? 'You did it!'
                  : 'Open the app to get started',
              style: theme.textTheme.bodyMedium?.copyWith(
                color: Colors.white70,
              ),
            ),
            if (isLoading) ...[
              const SizedBox(height: 16),
              const CircularProgressIndicator(color: Colors.white),
            ],
          ],
        ),
      ),
    );
  }
}
