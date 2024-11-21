import 'package:flutter/material.dart';
import '../models/plan_model.dart';
import '../models/todo_model.dart';

class AppProvider extends ChangeNotifier {
  List<Plan> _plans = [];
  List<ToDo> _todos = [];

  List<Plan> get plans => _plans;
  List<ToDo> get todos => _todos;

  // Add a plan to the list
  void addPlan(Plan plan) {
    _plans.add(plan);
    notifyListeners();
  }

  // Add a to-do to the list
  void addToDo(ToDo todo) {
    _todos.add(todo);
    notifyListeners();
  }

  // Toggle the completion status of a to-do
  void toggleToDoStatus(ToDo todo) {
    todo.isCompleted = !todo.isCompleted;
    notifyListeners();
  }

  // Filter plans by the selected date
  List<Plan> getPlansForDate(DateTime date) {
    return _plans.where((plan) {
      return plan.date.year == date.year &&
             plan.date.month == date.month &&
             plan.date.day == date.day;
    }).toList();
  }

// Filter to-dos by the selected date
List<ToDo> getToDosForDate(DateTime date) {
  return _todos.where((todo) {
    // Check if todo.date is not null before comparing
    return todo.date != null && 
           todo.date!.year == date.year &&
           todo.date!.month == date.month &&
           todo.date!.day == date.day;
  }).toList();
}
}