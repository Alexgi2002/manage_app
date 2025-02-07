import 'package:isar/isar.dart';
import 'package:manage_app/data/storage.dart';
import 'package:manage_app/domain/entities/user.dart';
import 'package:manage_app/domain/repositories/local/usecases/user_repository.dart';

class UserDb extends UserRepository {

  final Isar isar;

  UserDb(this.isar);

  @override
  Future<void> deleteUser(int id) async {
    isar.writeTxn(() async {
      await isar.users.delete(id);
    });
  }

  @override
  Future<User?> getUser(int id) async {
    return await isar.users.get(id);
  }

  @override
  Future<List<User>> getUsers(Rol rol) async {
    return await isar.users.filter().rolEqualTo(rol).findAll(); 
  }

  @override
  Future<void> saveUser(User user) async {
    isar.writeTxn(() async {
      await isar.users.put(user);
    });
  }
  
  @override
  Future<void> saveUsers(List<User> users) {
    return isar.writeTxn(() async {
      for(final user in users){
        await isar.users.put(user);
      }
    });
  }
  
  @override
  Future<bool> login(String name, String password) async {
    final user = await isar.users.filter().nameEqualTo(name).findFirst();
    if(user != null && user.password == password){
      Storage.instance.setId(user.id);
      return true;
    }
    
    return false;
  }
  
  @override
  Future<bool> changePassword(int id, String password, String newPassword) async {
    final user = await isar.users.get(id);
    if(user != null && user.password == password){
      user.password = newPassword;
      isar.writeTxn(() async {
        isar.users.put(user);
      });
      return true;
    }

    return false;
  }
}