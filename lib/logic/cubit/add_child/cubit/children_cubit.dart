import 'dart:io';
import 'package:flutter_bloc/flutter_bloc.dart';

class ChildModel {
  final String name;
  final String age;
  final String type;
  final File? image;

  ChildModel({
    required this.name,
    required this.age,
    required this.type,
    this.image,
  });
}

class ChildrenCubit extends Cubit<List<ChildModel>> {
  ChildrenCubit() : super([]);

  void addChild(ChildModel child) {
    final updatedList = List<ChildModel>.from(state)..add(child);
    emit(updatedList);
  }

  void removeChild(int index) {
    final updatedList = List<ChildModel>.from(state)..removeAt(index);
    emit(updatedList);
  }
}
