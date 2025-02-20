import 'package:flutter/cupertino.dart';

class ValidacionDeData {
  static String? validarNumero(String? valor) {
    if (valor == null) {
      return 'Este campo es requerido';
    }

    if (valor.isEmpty) {
      return 'Este campo es requerido';
    }

    if (double.tryParse(valor) == null) {
      return 'Este campo debe ser un número';
    }

    return null;
  }

  static String? validarCampoObligatorio(String? valor) {
    if (valor == null) {
      return 'Este campo es requerido';
    }

    if (valor.isEmpty) {
      return 'Este campo es requerido';
    }

    return null;
  }
}

class Alertas {
  static void mostrarAlertaDeConfirmacion(BuildContext context,
      {required void Function(BuildContext) alBorrar}) {
    showCupertinoDialog(
      context: context,
      builder: (ctx) {
        return CupertinoAlertDialog(
          title: const Text('¿Seguro que quiere borrar?'),
          actions: [
            CupertinoDialogAction(
              child: const Text('Volver'),
              onPressed: () {
                Navigator.pop(ctx);
              },
            ),
            CupertinoDialogAction(
              isDestructiveAction: true,
              onPressed: () {
                alBorrar(ctx);
              },
              child: const Text('Borrar'),
            ),
          ],
        );
      },
    );
  }
}
