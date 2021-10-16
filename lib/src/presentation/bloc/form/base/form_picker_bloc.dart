import 'form_input_bloc.dart';

class FormPickerBloc extends FormInputBloc<int> {

  @override String? Function(int? value)? validator;

  FormPickerBloc({this.validator}) : super(FormInputBlocStateLoading(),validator:validator);

  @override
  set value(int? newValue) {
    pUpdateValue(newValue);
  }

}

