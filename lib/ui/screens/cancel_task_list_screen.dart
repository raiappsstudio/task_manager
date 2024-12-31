import 'package:flutter/material.dart';
import 'package:task_manager/ui/widgets/screen_background.dart';
import 'package:task_manager/ui/widgets/task_item_widget.dart';
import '../widgets/tm_app_bar.dart';

class CancelTaskListScreen extends StatefulWidget {
  const CancelTaskListScreen({super.key});

  static const String name = '/cancel-task';

  @override
  State<CancelTaskListScreen> createState() => _CancelTaskListScreenState();
}

class _CancelTaskListScreenState extends State<CancelTaskListScreen> {
  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    return Scaffold(
        appBar: TMAppBar(),
        body: ScreenBackground(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8.0),
            child: _builTaskListView(),
          ),
        ));
  }

  Widget _builTaskListView() {
    return ListView.builder(
      itemCount: 3,
      itemBuilder: (context, index) {
        return const TaskItemWidget();
      },
    );
  }
}
