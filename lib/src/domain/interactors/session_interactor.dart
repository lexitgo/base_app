import 'dart:async';

import 'package:base_app/src/data/repos/users_repo.dart';
import 'package:base_app/src/domain/entities/session_entity.dart';
import 'package:base_app/src/domain/i_repo/i_users_repo.dart';
import 'package:base_app/src/extensions/rx_ext.dart';

class InteractorSession {

  late IRepoUsers _repo;

  InteractorSession({required IRepoUsers repo}) {
    _repo=repo;
  }

  Rxv<EntitySession?> get session => _repo.session;

  Future<bool> logoutUser() async {
    return await _repo.logoutUser();
  }

  close() {
    _repo.close();
  }

}