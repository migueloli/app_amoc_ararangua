import 'package:kayta/validators.dart';
import 'package:kayta/extensions/string_extensions.dart';

String? validateName(String? value) => value != null && value.trim().length > 8
    ? null
    : "Nome precisa ter mais de 8 caracteres.";

String? validateDocument(String? value) => value != null && (CPFValidator.isValid(value) || CNPJValidator.isValid(value))
    ? null
    : "CPF/CNPJ inválido." ;

String? validatePhone(String? value) =>
    value != null &&
    RegExp(
      r'^(?:(?:\+|00)?(55)\s?)?(?:\(?([1-9][0-9])\)?\s?)?(?:((?:9\d|[2-9])\d{3})-?(\d{4}))$'
    ).hasMatch(
      value.trim().replaceAll(RegExp(r'[^a-zA-Z 0-9]+'), '')
    ) ? "Telefone inválido." : null;

String? validateZip(String? value) =>
    value != null &&
    RegExp(
      r'\d{2}.\d{3}-\d{3}'
    ).hasMatch(
      value.trim().replaceAll(RegExp(r'\s+'), '')
    ) ? null : "CEP inválido.";

String? validateAddress(String? value) => value != null && value.trim().length > 10
    ? null
    : "Endereço precisa ter mais de 10 caracteres";

String? validateNeighborhood(String? value) => value != null && value.trim().length > 3
    ? null
    : "Bairro precisa ter mais de 3 caracteres";

String? validateCity(String? value) => value != null && value.trim().length > 3
    ? null
    : "Cidade precisa ter mais de 3 caracteres.";

String? validateEmail(String? value) => value.isValidEmail
    ? null
    : 'E-mail inválido';

String? validatePassword(String? value) => value != null && value.trim().length >= 6
    ? null
    : "Senha precisa ter 6 ou mais caracteres.";