import 'error_entity.dart';

class EntityDTO<T> {
  T? data;
  ErrorBase? error;

  EntityDTO({this.data,this.error});

}