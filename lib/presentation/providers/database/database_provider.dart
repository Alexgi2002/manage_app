import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:manage_app/data/database/database.dart';
import 'package:manage_app/domain/repositories/local/local_repository.dart';

final databaseProvider = StateProvider<LocalRepository>((ref) {
  return Database.instance;
});