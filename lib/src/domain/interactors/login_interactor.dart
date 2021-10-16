import 'package:base_app/src/domain/entities/dto_entity.dart';
import 'package:base_app/src/domain/i_repo/i_users_repo.dart';

class InteractorLogin {

  late IRepoUsers _repo;

  InteractorLogin({required IRepoUsers repo}) {
    _repo=repo;
  }

  Future<EntityDTO<bool>> login(String username, String password) async {
    return await _repo.login(username,password);
  }

}