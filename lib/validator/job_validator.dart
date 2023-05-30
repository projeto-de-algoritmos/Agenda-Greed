String? jobValidator(String hour) {
  int intHour = int.parse(hour);
  if (intHour < 8) {
    return "Tarefa deve conter 8 ou mais horas";
  }
  if (intHour > 22) {
    return "Tarefa deve conter no máximo 22 horas";
  }

  return null;
}
