import 'dart:async';

import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'form_input_bloc.dart';

abstract class FormBloc extends Cubit<FormBlocState> {

  FormBloc(FormBlocState state) : super(state);

  List<FormInputBloc> fieldList = [];
  List<StreamSubscription> subscriptionValidationFieldList = [];

  loadForm() async {
    try {
      for (var field in fieldList) {
        field.formBloc ??= this;
        field.loadField();
        subscriptionValidationFieldList
            .add(field.validController.stream.listen((event) {
          emit(FormLoadedState());
          for (field in fieldList) {
            if (field.state is FormInputBlocStateInvalid) emitInvalid();
          }
        }));
      }

      emit(FormLoadedState());
    } catch (e) {
      emit(FormSubmitErrorState(e.toString()));
    }
  }

  refreshForm() async {
    emit(FormLoadingState());
    //loadForm();
    emit(FormLoadedState());
  }

  Future<dynamic> submitForm() async {
    for (var field in fieldList) {
      await field.fieldValidation();
    }

    if (fieldList
            .where((element) =>
                element.isVisible && element.state is FormInputBlocStateInvalid).isNotEmpty) {
      //emitInvalid();
      return false;
    }

    return true;
  }

  emitSuccess() async {
    emit(FormSuccessState());
  }

  emitFailure(String error) async {
    emit(FormSubmitErrorState(error));
  }

  emitInvalid() async {
    emit(FormInvalidState());
  }

  emitSubmiting() async {
    emit(FormSubmitingState());
  }

  @override
  Future<void> close() {
    for (var sub in subscriptionValidationFieldList) {
      sub.cancel();
    }
    for (var field in fieldList) {
      field.close();
    }
    return super.close();
  }
}

class FormBlocState extends Equatable {
  const FormBlocState();

  @override
  List<Object> get props => [];
}

class FormInitState extends FormBlocState {}

class FormLoadingState extends FormBlocState {}

class FormSubmitingState extends FormBlocState {}

class FormLoadedState extends FormBlocState {}

class FormSuccessState extends FormBlocState {}

class FormInvalidState extends FormLoadedState {}

class FormSubmitErrorState extends FormBlocState {
  final String error;

  const FormSubmitErrorState(this.error);

  @override
  List<Object> get props => [];
}

class FormErrorState extends FormSubmitErrorState {
  const FormErrorState(String error) : super(error);
}
