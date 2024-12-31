import 'package:flutter/material.dart';
import 'package:task_manager/ui/widgets/screen_background.dart';
import 'package:task_manager/ui/widgets/task_item_widget.dart';
import '../widgets/tm_app_bar.dart';

class CompletdTaskListScreen extends StatefulWidget {
  const CompletdTaskListScreen({super.key});

  static const String name = '/completed-task';

  @override
  State<CompletdTaskListScreen> createState() => _CompletdTaskListScreenState();
}

class _CompletdTaskListScreenState extends State<CompletdTaskListScreen> {
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
      itemCount: 5,
      itemBuilder: (context, index) {
        return const TaskItemWidget();
      },
    );
  }
}
