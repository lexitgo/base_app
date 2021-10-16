import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:base_app/src/presentation/bloc/form/base/form_blocs.dart';

class WidgetFormTextField extends StatefulWidget {
  WidgetFormTextField({
    Key? key,
    required this.bloc,
    required this.decor,
    this.textStyle,
    this.keyboardType,
    this.hideCharacters=false,
    this.cursorColor,
    this.isReadOnly=false
  }) : super(key: key);

  final FormTextBloc bloc;
  final InputDecoration decor;
  final TextStyle? textStyle;
  final TextInputType? keyboardType;
  final bool hideCharacters;
  final Color? cursorColor;
  final bool isReadOnly;

  @override
  State<StatefulWidget> createState() => _WidgetFormTextFieldState();

}

class _WidgetFormTextFieldState extends State<WidgetFormTextField> {

  @override
  void initState() {
    super.initState();
  }

  @override
  void didUpdateWidget(covariant WidgetFormTextField oldWidget) {
    super.didUpdateWidget(oldWidget);
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<FormTextBloc,FormInputBlocState>(
        bloc: widget.bloc,
        builder: (context,state) {
          return Column(
            children: [
              TextFormField(
                readOnly: widget.isReadOnly,
                enabled: !(widget.isReadOnly),
                obscureText: widget.hideCharacters,
                style: widget.textStyle,
                controller:widget.bloc.textController,
                inputFormatters: widget.bloc.maskFormatter!=null ? [widget.bloc.maskFormatter!] : null,
                keyboardType: widget.keyboardType,
                focusNode: widget.bloc.getFocus,
                cursorColor: widget.cursorColor,
                decoration: widget.decor.copyWith(
                  suffixIcon: ((widget.bloc.value ?? '').isNotEmpty && !widget.isReadOnly)
                      ? IconButton(icon: Icon(Icons.close), onPressed: () {
                          widget.bloc.clear();
                        }) : SizedBox(),
                  errorText: state is FormInputBlocStateInvalid ? state.errorText : null,
                  errorBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(15.0),
                      borderSide: BorderSide(
                        color: Theme.of(context).errorColor,
                      )
                  ),
                  focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(15.0),
                      borderSide: BorderSide(
                        width: 1,
                        color: state is FormInputBlocStateInvalid
                            ? Theme.of(context).errorColor
                            : widget.cursorColor ?? Colors.transparent,
                      )
                  ),
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(15.0),
                      borderSide: BorderSide(
                        width: 1,
                        color: state is FormInputBlocStateInvalid
                            ? Theme.of(context).errorColor
                            : widget.cursorColor ?? Colors.transparent,
                      )
                  ),
                ),
              ),
              SizedBox(height: 4),
            ],
          );
        });
  }
}