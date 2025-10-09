import 'package:autism/logic/cubit/add_child/cubit/children_cubit.dart';
import 'package:autism/presentation/widgets/add_child/floatingActionButton.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AddChild extends StatefulWidget {
  const AddChild({super.key});

  @override
  State<AddChild> createState() => _AddChildState();
}

class _AddChildState extends State<AddChild> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[200],
      floatingActionButton: FloatingActionButtonWidget(),

      body: BlocBuilder<ChildrenCubit, List<ChildModel>>(
        builder: (context, state) {
          if (state.isEmpty) {
            return const Center(child: Text('No children added yet'));
          }
          return SafeArea(
            child: ListView.builder(
              itemCount: state.length,
              itemBuilder: (context, index) {
                final child = state[index];
                return Padding(
                  padding: const EdgeInsets.all(15.0),
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: Colors.white,
                    ),
                    child: ListTile(
                      tileColor: Colors.white.withOpacity(0),
                      leading: CircleAvatar(
                        radius: 30,
                        backgroundImage: child.image != null
                            ? FileImage(child.image!)
                            : null,
                        child: child.image == null ? Icon(Icons.person) : null,
                      ),
                      title: Text(child.name),
                      subtitle: Text('Age: ${child.age} | Type: ${child.type}'),
                      trailing: IconButton(
                        icon: const Icon(Icons.delete, color: Colors.red),
                        onPressed: () {
                          context.read<ChildrenCubit>().removeChild(index);
                        },
                      ),
                    ),
                  ),
                );
              },
            ),
          );
        },
      ),
    );
  }
}
