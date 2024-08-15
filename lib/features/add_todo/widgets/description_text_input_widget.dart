import 'package:flutter/material.dart';
import 'package:todolist_app/shared/widgets/inputs/text_input_widget.dart';

class DescriptionTextInputWidget extends StatelessWidget {
  final TextEditingController descriptionTEC;
  final FocusNode descriptionFN;
  final FocusNode todoDateFN;
  const DescriptionTextInputWidget({
    super.key,
    required this.descriptionTEC,
    required this.descriptionFN, 
    required this.todoDateFN,
  });

  @override
  Widget build(BuildContext context) {
    return TextInputWidget(
      controller: descriptionTEC,
      focusNode: descriptionFN,
      label: 'Descrição',
      minLines: 4,
      maxLines: 6,
      textCapitalization: TextCapitalization.sentences,
      onFieldSubmited: (_) => todoDateFN.requestFocus(),
    );
  }
}
