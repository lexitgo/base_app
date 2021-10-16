import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';
import 'form_input_bloc.dart';

class FormTextBloc extends FormInputBloc<String> {

  ///Use only for binding to view
  late TextEditingController textController;
  
  @override String? Function(String? value)? validator;
  final TextInputFormatter? maskFormatter;

  FormTextBloc({
      String? initialValue,
      this.validator,
      this.maskFormatter,
      Function(String? oldValue, String? newValue)? onUpdated}
  ) : super(
      const FormInputBlocStateLoading(),
      validator:validator,
      initialValue:initialValue ?? "",
      maskFormatter:maskFormatter,
      onUpdated:onUpdated) {
    textController=TextEditingController(text: initialValue);
    textController.addListener(() {
      pUpdateValue(textController.text);
    });
  }

  clear() {
    textController.clear();
    pUpdateValue("");
  }

  @override
  set value(String? newValue) {
    textController.text = newValue ?? "";
    pUpdateValue(newValue);
  }



}

