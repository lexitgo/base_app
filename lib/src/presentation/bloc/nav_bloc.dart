import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:base_app/src/utils/routing/routes.dart';

class BlocNavState extends Equatable {
  @override
  List<Object> get props => [];
}

class BlocNavNavigating extends BlocNavState {

}

class BlocNavNavigatingToRoute extends BlocNavNavigating {
  final BaseRoute route;

  BlocNavNavigatingToRoute(this.route);
}

class BlocNavNavigateToDefault extends BlocNavNavigatingToRoute {
  BlocNavNavigateToDefault(BaseRoute route) : super(route);
}

class BlocNavNavigateToPush extends BlocNavNavigatingToRoute {
  BlocNavNavigateToPush(BaseRoute route) : super(route);
}

class BlocNavNavigateToRemove extends BlocNavNavigatingToRoute {
  BlocNavNavigateToRemove(BaseRoute route) : super(route);
}

class BlocNavNavigateToReplace extends BlocNavNavigatingToRoute {
  BlocNavNavigateToReplace(BaseRoute route) : super(route);
}


class BlocNavPop extends BlocNavNavigating {
  final dynamic data;

  BlocNavPop(this.data);
}

class BlocNavShowSnackBar extends BlocNavNavigating {
  final String text;

  BlocNavShowSnackBar(this.text);
}


class BlocNav extends Cubit<BlocNavState> {

  BlocNav() : super(BlocNavState());

  goToRemoveAll(BaseRoute route) {
    emit(BlocNavNavigateToRemove(route));
    emit(BlocNavState());
  }

  goTo(BaseRoute route,{bool useDefaultPushType=true}) {
    if (useDefaultPushType) {
      emit(BlocNavNavigateToDefault(route));
    } else {
      emit(BlocNavNavigateToPush(route));
    }
    emit(BlocNavState());
  }
  
  goToReplacement(BaseRoute route) {
    emit(BlocNavNavigateToReplace(route));
    emit(BlocNavState());
  }

  showSnackBar(String text) {
    emit(BlocNavShowSnackBar(text));
    emit(BlocNavState());
  }

  pop(dynamic data) {
    emit(BlocNavPop(data));
  }

  @override
  Future<void> close() {
    return super.close();
  }

}