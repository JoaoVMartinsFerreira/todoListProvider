import 'package:flutter/material.dart';
import 'package:todolist_app/shared/widgets/inputs/text_input_widget.dart';

class TitleTextInputWidget extends StatelessWidget {
  final TextEditingController titleTEC;
  final FocusNode titleFN;
  final FocusNode descriptionFN;
  const TitleTextInputWidget({
    super.key,
    required this.titleTEC,
    required this.titleFN,
    required this.descriptionFN,
  });

  @override
  Widget build(BuildContext context) {
    return TextInputWidget(
      controller: titleTEC,
      focusNode: titleFN,
      label: 'Título',
      autoFocus: true,
      textCapitalization: TextCapitalization.words,
      onFieldSubmited: (_) => descriptionFN.requestFocus(),
      validator: (String? title){
        if(title == null || title.isEmpty){
          return 'Você precisa adicionarum título';
        }
        return null;
      }
    );
  }
}
