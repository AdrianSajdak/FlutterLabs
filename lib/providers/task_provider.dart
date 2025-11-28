import 'package:flutter/material.dart';
import '../models/task_model.dart';

enum TaskFilter { all, active, completed }
enum TaskSort { byDate, byPriority }

class TaskProvider extends ChangeNotifier {
  bool _isDarkMode = false;
  bool get isDarkMode => _isDarkMode;

  void toggleTheme() {
    _isDarkMode = !_isDarkMode;
    notifyListeners();
  }

  TaskFilter _currentFilter = TaskFilter.all;
  TaskFilter get currentFilter => _currentFilter;

  void setFilter(TaskFilter filter) {
    _currentFilter = filter;
    notifyListeners();
  }

  TaskSort _currentSort = TaskSort.byDate;
  TaskSort get currentSort => _currentSort;

  void setSort(TaskSort sort) {
    _currentSort = sort;
    notifyListeners();
  }

  String _searchQuery = '';
  String get searchQuery => _searchQuery;

  void setSearchQuery(String query) {
    _searchQuery = query;
    notifyListeners();
  }

  void clearSearch() {
    _searchQuery = '';
    notifyListeners();
  }

  List<TaskModel> filterAndSortTasks(List<TaskModel> tasks) {
    List<TaskModel> filteredTasks = tasks;

    switch (_currentFilter) {
      case TaskFilter.active:
        filteredTasks = tasks.where((task) => !task.isCompleted).toList();
        break;
      case TaskFilter.completed:
        filteredTasks = tasks.where((task) => task.isCompleted).toList();
        break;
      case TaskFilter.all:
        break;
    }

    if (_searchQuery.isNotEmpty) {
      filteredTasks = filteredTasks.where((task) {
        return task.title.toLowerCase().contains(_searchQuery.toLowerCase()) ||
            (task.description?.toLowerCase().contains(_searchQuery.toLowerCase()) ?? false);
      }).toList();
    }

    switch (_currentSort) {
      case TaskSort.byDate:
        filteredTasks.sort((a, b) => a.dueDate.compareTo(b.dueDate));
        break;
      case TaskSort.byPriority:
        filteredTasks.sort((a, b) => b.priority.compareTo(a.priority));
        break;
    }

    return filteredTasks;
  }

  Color getCategoryColor(String category) {
    switch (category.toLowerCase()) {
      case 'work':
        return Colors.blue;
      case 'personal':
        return Colors.green;
      case 'shopping':
        return Colors.orange;
      case 'health':
        return Colors.red;
      case 'education':
        return Colors.purple;
      case 'finance':
        return Colors.teal;
      default:
        return Colors.grey;
    }
  }

  Color getPriorityColor(int priority) {
    switch (priority) {
      case 3:
        return Colors.red;
      case 2:
        return Colors.orange;
      case 1:
        return Colors.green;
      default:
        return Colors.grey;
    }
  }

  ThemeData get lightTheme {
    return ThemeData(
      useMaterial3: true,
      brightness: Brightness.light,
      colorScheme: ColorScheme.fromSeed(
        seedColor: Colors.blue,
        brightness: Brightness.light,
      ),
      appBarTheme: const AppBarTheme(
        centerTitle: true,
        elevation: 0,
      ),
      cardTheme: const CardThemeData(
        elevation: 2,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(12)),
        ),
      ),
      inputDecorationTheme: InputDecorationTheme(
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
        ),
        filled: true,
      ),
    );
  }

  ThemeData get darkTheme {
    return ThemeData(
      useMaterial3: true,
      brightness: Brightness.dark,
      colorScheme: ColorScheme.fromSeed(
        seedColor: Colors.blue,
        brightness: Brightness.dark,
      ),
      appBarTheme: const AppBarTheme(
        centerTitle: true,
        elevation: 0,
      ),
      cardTheme: const CardThemeData(
        elevation: 2,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(12)),
        ),
      ),
      inputDecorationTheme: InputDecorationTheme(
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
        ),
        filled: true,
      ),
    );
  }

  static const List<String> categories = [
    'General',
    'Work',
    'Personal',
    'Shopping',
    'Health',
    'Education',
    'Finance',
  ];
}
