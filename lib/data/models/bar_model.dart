class BarModel {
  final List<String> ejeX;
  final List<double> ejeY;

  BarModel({required this.ejeX, required this.ejeY});

  factory BarModel.convertirDeDataLocal(
      ({List<String> datosEjeX, List<String> datosEjeY}) data) {
    final barrasDatosEjeX = data.datosEjeX;
    final barrasDatosEjeY = data.datosEjeY.map((elemento) {
      return double.parse(elemento);
    }).toList();

    return BarModel(ejeX: barrasDatosEjeX, ejeY: barrasDatosEjeY);
  }
}
