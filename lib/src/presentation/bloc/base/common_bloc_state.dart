import 'package:equatable/equatable.dart';

class BlocCommonState extends Equatable {
  @override
  List<Object> get props => [];
}

class BlocCommonStateLoaded extends BlocCommonState {
  
}

class BlocCommonStateLoading extends BlocCommonState {

}

class BlocCommonStateEmpty extends BlocCommonState {

}

class BlocCommonStateError extends BlocCommonState {
  final String errorText;

  BlocCommonStateError(this.errorText);

  @override
  List<Object> get props => [errorText];
}

class BlocCommonListPopupError extends BlocCommonState {

  final String message;

  BlocCommonListPopupError(this.message);

  @override
  List<Object> get props => [message];
}
