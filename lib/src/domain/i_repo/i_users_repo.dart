import 'package:base_app/src/domain/entities/dto_entity.dart';
import 'package:base_app/src/domain/entities/session_entity.dart';
import 'package:base_app/src/extensions/rx_ext.dart';

abstract class IRepoUsers {

  var session=Rxv<EntitySession?>(null);

  Future<EntityDTO<bool>> login(String username, String password);
  Future<EntityDTO<bool>> register(String username, String password);

  logoutUser();

  close();

}