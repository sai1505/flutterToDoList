import 'package:flutter/material.dart';
import 'package:todolist/cubit/todo_cubit.dart';
import 'package:todolist/models/todo_model.dart';
import 'package:todolist/screens/add_task_page.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class DashboardPage extends StatelessWidget {
  const DashboardPage({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;

    final background = isDark ? Colors.black : Colors.white;
    final textColor = isDark ? Colors.white : Colors.black87;
    final cardColor = isDark ? Colors.grey[900] : Colors.grey[100];

    return Scaffold(
      backgroundColor: background,
      appBar: AppBar(
        title: const Text('Dashboard'),
        centerTitle: true,
        backgroundColor: background,
        elevation: 0,
        foregroundColor: textColor,
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Welcome Back 👋',
                style: theme.textTheme.headlineSmall?.copyWith(
                  fontWeight: FontWeight.bold,
                  color: textColor,
                ),
              ),
              const SizedBox(height: 6),
              Text(
                'Here’s your productivity summary for today.',
                style: theme.textTheme.bodyMedium?.copyWith(
                  color: textColor.withOpacity(0.7),
                ),
              ),

              const SizedBox(height: 24),

              // Overview Cards
              Row(
                children: [
                  Expanded(
                    child: _DashboardCard(
                      title: 'Tasks',
                      value: '12',
                      icon: Icons.list_alt_outlined,
                      cardColor: cardColor!,
                      textColor: textColor,
                    ),
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    child: _DashboardCard(
                      title: 'Completed',
                      value: '7',
                      icon: Icons.check_circle_outline,
                      cardColor: cardColor,
                      textColor: textColor,
                    ),
                  ),
                ],
              ),

              const SizedBox(height: 16),

              Expanded(
                child: Container(
                  width: double.infinity,
                  decoration: BoxDecoration(
                    color: cardColor,
                    borderRadius: BorderRadius.circular(16),
                  ),
                  padding: const EdgeInsets.all(20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Today’s Focus',
                        style: theme.textTheme.titleMedium?.copyWith(
                          fontWeight: FontWeight.w600,
                          color: textColor,
                        ),
                      ),
                      const SizedBox(height: 12),
                      Expanded(
                        child: Center(
                          child: BlocBuilder<TodoCubit, List<TodoModel>>(
                            builder: (context, state) {
                              return ListView.builder(
                                itemCount: state.length,
                                itemBuilder: (context, index) {
                                  final todo = state[index];

                                  return ListTile(
                                    title: Text(todo.taskData),
                                  );
                                },
                              );
                            },
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: textColor,
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => AddTaskPage()),
          );
        },
        child: Icon(
          Icons.add,
          color: isDark ? Colors.black : Colors.white,
        ),
      ),
    );
  }
}

class _DashboardCard extends StatelessWidget {
  final String title;
  final String value;
  final IconData icon;
  final Color cardColor;
  final Color textColor;

  const _DashboardCard({
    required this.title,
    required this.value,
    required this.icon,
    required this.cardColor,
    required this.textColor,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: cardColor,
        borderRadius: BorderRadius.circular(16),
      ),
      padding: const EdgeInsets.symmetric(vertical: 22, horizontal: 18),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(icon, color: textColor.withOpacity(0.8)),
          const SizedBox(height: 10),
          Text(
            value,
            style: Theme.of(context).textTheme.headlineSmall?.copyWith(
              fontWeight: FontWeight.bold,
              color: textColor,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            title,
            style: Theme.of(context).textTheme.bodyMedium?.copyWith(
              color: textColor.withOpacity(0.6),
            ),
          ),
        ],
      ),
    );
  }
}
