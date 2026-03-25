import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:home_widget/presentation/home_widget/state/home_widget_bloc.dart';
import 'package:home_widget/presentation/home_widget/widgets/action_button_widget.dart';
import 'package:home_widget/presentation/home_widget/widgets/widget_status_card.dart';

class HomeWidgetDemoScreen extends StatelessWidget {
  const HomeWidgetDemoScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: const Text('Home Widget Demo'),
      ),
      body: BlocBuilder<HomeWidgetBloc, HomeWidgetState>(
        builder: (context, state) {
          return Padding(
            padding: const EdgeInsets.all(24),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                WidgetStatusCard(
                  actionDone: state.actionDone,
                  isLoading: state.isLoading,
                ),
                const SizedBox(height: 32),
                ActionButtonWidget(
                  actionDone: state.actionDone,
                  isLoading: state.isLoading,
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
