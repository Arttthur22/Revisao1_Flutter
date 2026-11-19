class Validadores {
  static String? textoObrigatorio(String? valor) {
    if (valor == null || valor.trim().isEmpty) {
      return 'Este campo é obrigatório e não pode conter somente espaços.';
    }
    return null;
  }

  static String? quantidade(String? valor) {
    final texto = valor?.trim() ?? '';
    if (texto.isEmpty) {
      return 'Informe uma quantidade.';
    }
    // Somente dígitos: recusa letras, sinal negativo e casas decimais.
    if (!RegExp(r'^[0-9]+$').hasMatch(texto) || int.tryParse(texto) == null) {
      return 'Use somente números inteiros maiores ou iguais a zero.';
    }
    return null;
  }
}
