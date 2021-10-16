import 'form_input_bloc.dart';

class FormDropDownBloc<T> extends FormInputBloc<T> {

  FormDropDownBloc({
    this.validator, this.onUpdated
  }) : super(
      FormInputBlocStateLoading(),
      validator:validator,
      onUpdated: onUpdated
  );

  @override String? Function(T? value)? validator;
  Function(T? oldValue, T? newValue)? onUpdated;

  List<T> dropdownList=[];

  @override
  set value(T? newValue) {
    pUpdateValue(newValue);
  }

  @override
  pUpdateValue(T? newValue) async {
    if (newValue!=null) {
      super.pUpdateValue(newValue);
    }
  }

}

