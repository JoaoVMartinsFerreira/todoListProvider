extension DateExtensionon on DateTime {
  String get formartDate {
    final formatedDay = day.toString().padLeft(2, '0');
    final formatedMonth = month.toString().padLeft(2, '0');

    final formatedYear = year.toString();
    return '$formatedDay/$formatedMonth/$formatedYear';
    }
  }
