import 'dart:async';
import 'package:base_app/src/data/api/exceptions.dart';
import 'package:base_app/src/domain/entities/dto_entity.dart';
import 'package:base_app/src/domain/entities/error_entity.dart';
import 'package:base_app/src/domain/entities/session_entity.dart';
import 'package:base_app/src/domain/i_repo/i_users_repo.dart';
import 'package:base_app/src/extensions/rx_ext.dart';
import '../api/api_service.dart';

class RepoUsers implements IRepoUsers {

  final ApiService _apiService;

  @override
  var session=Rxv<EntitySession?>(null);

  RepoUsers(this._apiService);

  Future<bool> initAndCheckLogged() async {
    return false;
  }

  
  @override
  Future<EntityDTO<bool>> login(String username, String password) async {
    try {
      var result = await _apiService.login(username, password);
      session.value = result;
      return EntityDTO(
         data: true
      );
    } on ApiException catch (e) {
      if (e.message.contains("doesn't exist")) {
        return register(username, password);
      } else {
        return EntityDTO(
            error: ErrorBase(
                message: e.message
            )
        );
      }
    } catch (e,s) {
      return EntityDTO(
          error: ErrorBase(
              message: e.toString()
          )
      );
    }
  }

  @override
  Future<EntityDTO<bool>> register(String username, String password) async {
    try {
      var result = await _apiService.register(username, password);
      session.value = result;
      return EntityDTO(
          data: true
      );
    } on ApiException catch (e) {
      return EntityDTO(
          error: ErrorBase(
              message: e.message
          )
      );
    } catch (e,s) {
      return EntityDTO(
          error: ErrorBase(
              message: e.toString()
          )
      );
    }
  }

  @override
  Future<bool> logoutUser() async {
    try {
      session.value=null;
      return true;
    } catch (e) {
      return false;
    }
  }

  @override
  close() {
    session.close();
  }

}