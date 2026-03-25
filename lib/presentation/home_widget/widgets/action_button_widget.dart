import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:home_widget/presentation/home_widget/state/home_widget_bloc.dart';

class ActionButtonWidget extends StatelessWidget {
  const ActionButtonWidget({
    super.key,
    required this.actionDone,
    required this.isLoading,
  });

  final bool actionDone;
  final bool isLoading;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: 56,
      child: FilledButton.icon(
        onPressed: isLoading
            ? null
            : () {
                final bloc = context.read<HomeWidgetBloc>();
                if (actionDone) {
                  bloc.add(const HomeWidgetActionReset());
                } else {
                  bloc.add(const HomeWidgetActionPerformed());
                }
              },
        icon: Icon(actionDone ? Icons.refresh : Icons.bolt),
        label: Text(actionDone ? 'Reset Widget' : 'Perform Action'),
      ),
    );
  }
}
