import 'form_input_bloc.dart';

class FormCheckboxBloc extends FormInputBloc<bool> {

  @override String? Function(bool? value)? validator;

  FormCheckboxBloc({this.validator}) : super(FormInputBlocStateLoading(),validator:validator);

  @override
  set value(bool? newValue) {
    pUpdateValue(newValue);
  }

}

