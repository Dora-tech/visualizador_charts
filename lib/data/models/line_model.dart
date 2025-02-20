class LineModel {
  final List<double> ejeX;
  final List<double> ejeY;

  LineModel({required this.ejeX, required this.ejeY});

  factory LineModel.convertirDeDataLocal(
      ({List<String> datosEjeX, List<String> datosEjeY}) data) {
    return LineModel(
      ejeX: data.datosEjeX.map((elemento) {
        return double.parse(elemento);
      }).toList(),
      ejeY: data.datosEjeY.map((elemento) {
        return double.parse(elemento);
      }).toList(),
    );
  }
}
