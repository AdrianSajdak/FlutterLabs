import 'package:cloud_firestore/cloud_firestore.dart';
import '../models/task_model.dart';

class DatabaseService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final String _collectionName = 'tasks';

  CollectionReference get _tasksCollection =>
      _firestore.collection(_collectionName);

  Stream<List<TaskModel>> getTasks() {
    return _tasksCollection
        .orderBy('createdAt', descending: true)
        .snapshots()
        .map((snapshot) {
      return snapshot.docs.map((doc) {
        return TaskModel.fromMap(doc.data() as Map<String, dynamic>, doc.id);
      }).toList();
    });
  }

  Stream<List<TaskModel>> getTasksForDate(DateTime date) {
    DateTime startOfDay = DateTime(date.year, date.month, date.day);
    DateTime endOfDay = DateTime(date.year, date.month, date.day, 23, 59, 59);

    return _tasksCollection
        .where('dueDate',
            isGreaterThanOrEqualTo: Timestamp.fromDate(startOfDay))
        .where('dueDate', isLessThanOrEqualTo: Timestamp.fromDate(endOfDay))
        .snapshots()
        .map((snapshot) {
      return snapshot.docs.map((doc) {
        return TaskModel.fromMap(doc.data() as Map<String, dynamic>, doc.id);
      }).toList();
    });
  }

  Future<String> addTask(TaskModel task) async {
    try {
      DocumentReference docRef = await _tasksCollection.add(task.toMap());
      return docRef.id;
    } catch (e) {
      throw Exception('Failed to add task: $e');
    }
  }

  Future<void> updateTask(TaskModel task) async {
    if (task.id == null) {
      throw Exception('Task ID is required for update');
    }
    try {
      await _tasksCollection.doc(task.id).update(task.toMap());
    } catch (e) {
      throw Exception('Failed to update task: $e');
    }
  }

  Future<void> deleteTask(String taskId) async {
    try {
      await _tasksCollection.doc(taskId).delete();
    } catch (e) {
      throw Exception('Failed to delete task: $e');
    }
  }

  Future<void> toggleTaskCompletion(String taskId, bool isCompleted) async {
    try {
      await _tasksCollection.doc(taskId).update({
        'isCompleted': isCompleted,
      });
    } catch (e) {
      throw Exception('Failed to toggle task: $e');
    }
  }

  Future<TaskModel?> getTaskById(String taskId) async {
    try {
      DocumentSnapshot doc = await _tasksCollection.doc(taskId).get();
      if (doc.exists) {
        return TaskModel.fromMap(
            doc.data() as Map<String, dynamic>, doc.id);
      }
      return null;
    } catch (e) {
      throw Exception('Failed to get task: $e');
    }
  }

  Future<Map<String, dynamic>> getStatistics() async {
    try {
      QuerySnapshot snapshot = await _tasksCollection.get();
      List<TaskModel> tasks = snapshot.docs.map((doc) {
        return TaskModel.fromMap(doc.data() as Map<String, dynamic>, doc.id);
      }).toList();

      int total = tasks.length;
      int completed = tasks.where((task) => task.isCompleted).length;
      int active = total - completed;
      int overdue = tasks.where((task) => task.isOverdue).length;

      Map<String, int> categoryCount = {};
      for (var task in tasks) {
        categoryCount[task.category] = (categoryCount[task.category] ?? 0) + 1;
      }

      Map<String, int> priorityCount = {
        'Low': tasks.where((task) => task.priority == 1).length,
        'Medium': tasks.where((task) => task.priority == 2).length,
        'High': tasks.where((task) => task.priority == 3).length,
      };

      return {
        'total': total,
        'completed': completed,
        'active': active,
        'overdue': overdue,
        'categoryCount': categoryCount,
        'priorityCount': priorityCount,
      };
    } catch (e) {
      throw Exception('Failed to get statistics: $e');
    }
  }
}
