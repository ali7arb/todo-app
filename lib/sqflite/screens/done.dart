import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../core/custom_cart.dart';
import '../cubit/cubit.dart';
import '../cubit/states.dart';

class DoneScreen extends StatelessWidget {
  const DoneScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ToDoCubit, TodoStates>(
      listener: (context, state) => {},
      builder: (context, state) {
        var tasks = ToDoCubit.get(context).doneTasks;
        return ConditionalBuilder(
          condition: tasks.isNotEmpty,
          builder: (context) => ListView.separated(
            itemBuilder: (context, index) => SingleChildScrollView(
              child: CustomCart(
                model: tasks[index],
              ),
            ),
            separatorBuilder: (context, index) => SizedBox(
              height: MediaQuery.of(context).size.height * 0.002,
            ),
            itemCount: tasks.length,
          ),
          fallback: (context) => const Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  Icons.menu,
                  size: 40,
                ),
                Text(
                  'No Tasks Yet,Please Add Some Tasks',
                  style: TextStyle(
                    fontSize: 15,
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
