import 'package:book_bike/data/entity/user_entity.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

abstract class UserRepository {
  Future<List<UserEntity>> getUsers();
}

class UserRepositoryImpl extends UserRepository {
  @override
  Future<List<UserEntity>> getUsers() async {
    final supabase = Supabase.instance.client;

    final data = await supabase.from('TAIKHOAN').select('*');
    final result = <UserEntity>[];

    for (var map in data) {
      print(map);
      final user = UserEntity(
          accountId: map['MATK'],
          userId: map['MAND'],
          password: map['MATKHAU'],
          displayName: map['TENNGUOIDUNG'],
          money: map['SODUTAIKHOAN'],
          phone: map['SDT'],
          email: map['EMAIL']);

      result.add(user);
    }

    return result;
  }
}
