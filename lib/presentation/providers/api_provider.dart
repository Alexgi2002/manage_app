import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:manage_app/data/datasources/api.dart';
import 'package:manage_app/domain/repositories/remote/remote_repository.dart';

final apiProvider = StateProvider<RemoteRepository>((ref) {
  return ApiConsumer.getInstance();
});