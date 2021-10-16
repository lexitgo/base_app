import 'dart:async';
import 'dart:developer';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'form_bloc.dart';

class FormInputBlocState<T> extends Equatable {

  final T? value;
  const FormInputBlocState(this.value);

  @override
  List<Object?> get props => [value];

}

class FormInputBlocStateLoaded<T> extends FormInputBlocState {
  const FormInputBlocStateLoaded(value) : super(value);

}

class FormInputBlocStateLoading extends FormInputBlocState {
  const FormInputBlocStateLoading() : super(null);

  @override
  List<Object> get props => [];

}

class FormInputBlocStateInvalid<T> extends FormInputBlocStateLoaded {

  final String errorText;
  const FormInputBlocStateInvalid(T? value, this.errorText) : super(value);

  @override
  List<Object?> get props => [value];
}


abstract class FormInputBloc<T> extends Cubit<FormInputBlocState>{
  FormInputBloc(
      FormInputBlocState state,
      {this.validator,
      T? initialValue,
      this.isVisible = true,
      this.maskFormatter,
      this.onUpdated}) : super(state) {
    pValue=initialValue;
    _focus.addListener(onFocusChange);
  }

  @protected
  T? pValue;
  
  bool isVisible;
  T? get value => pValue;

  set value(T? newValue);
  
  
  final TextInputFormatter? maskFormatter;
  
  StreamController<FormInputBlocState> validController=StreamController.broadcast();

  FormBloc? formBloc;

  String? Function(T? value)? validator;
  Function(T? oldValue, T? newValue)? onUpdated;

  final FocusNode _focus = new FocusNode();
  FocusNode get getFocus => _focus;

  setFocus() {
    _focus.requestFocus();
  }

  loadField() async {
    emit(FormInputBlocStateLoaded(pValue));
    validController.add(state);
  }

  setValidator(String Function(T? value)? validation) {
    this.validator=validation;
  }

  @protected
  pUpdateValue(T? newValue) async {
    var oldValue=pValue;
    pValue=newValue;
    await loadField();
    if (onUpdated!=null) onUpdated!(oldValue,newValue);
  }

  fieldValidation() async {
    try {
      if (validator!=null && isVisible) {
        var validationResult = validator!(pValue);
        if (validationResult != null) {
          emit(FormInputBlocStateInvalid(pValue, validationResult));
          validController.add(state);
          return false;
        } else {
          return true;
        }
      } else return true;
        //formBloc.emitInvalid();
    } catch (e) {
      log(e.toString());
      return false;
    }
  }

  onFocusChange() async {
    /*if (!_focus.hasFocus) fieldValidation();
    else {
    }*/
  }

  @override Future<void> close() {
    validController.close();
    return super.close();
  }



}