import 'package:flutter/material.dart';
import 'package:todolist_app/shared/widgets/texts/text_widget.dart';

class LoadingErrorWidget extends StatelessWidget {
  final bool isLoading;
  final String? error;
  final void Function() loadTodosAndDneTodos;
  const LoadingErrorWidget({
    required this.isLoading,
    required this.loadTodosAndDneTodos,
    required this.error,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: isLoading
          ? const CircularProgressIndicator()
          : Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                TextWidget(
                  error!,
                  textAlign: TextAlign.center,
                ),
                const SizedBox(
                  height: 8,
                ),
                ElevatedButton(
                  onPressed: loadTodosAndDneTodos,
                  style: const ButtonStyle(backgroundColor: WidgetStatePropertyAll(
                    Colors.red
                  )),
                  child: const TextWidget(
                    'Tentar Novamente'
                  ),
                ),
              ],
            ),
    );
  }
}
