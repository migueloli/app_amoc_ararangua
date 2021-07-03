import 'package:kayta/validators.dart';
import 'package:kayta/extensions/string_extensions.dart';

const INVALID_SHORT_NAME_MESSAGE = 'Nome precisa ter mais de 2 caracteres.';
const INVALID_DOCUMENT_MESSAGE = 'CPF/CNPJ inválido.';
const INVALID_PHONE_MESSAGE = 'Telefone inválido.';
const INVALID_ZIP_CODE_MESSAGE = 'CEP inválido.';
const INVALID_SHORT_ADDRESS_MESSAGE = 'Endereço precisa ter mais de 10 caracteres';
const INVALID_SHORT_NEIGHBORHOOD_MESSAGE = 'Bairro precisa ter mais de 3 caracteres';
const INVALID_EMAIL_MESSAGE = 'E-mail inválido';
const INVALID_SHORT_PASSWORD_MESSAGE = 'Senha precisa ter 6 ou mais caracteres.';
const INVALID_SHORT_DESCRIPTION_MESSAGE = 'Descrição precisa ter mais de 20 caracteres.';

String? validateName(String? value) => value != null && value.trim().length >= 3
    ? null
    : INVALID_SHORT_NAME_MESSAGE;

String? validateDocument(String? value) => value != null && (CPFValidator.isValid(value) || CNPJValidator.isValid(value))
    ? null
    : INVALID_DOCUMENT_MESSAGE;

String? validatePhone(String? value) =>
    value != null &&
    RegExp(
      r'^(?:(?:\+|00)?(55)\s?)?(?:(?:\(?[1-9][0-9]\)?)?\s?)?(?:((?:9\d|[2-9])\d{3})-?(\d{4}))$'
    ).hasMatch(
      value.trim()
    ) ? null : INVALID_PHONE_MESSAGE;

String? validateZip(String? value) =>
    value != null &&
    RegExp(
      r'\d{2}.\d{3}-\d{3}'
    ).hasMatch(
      value.trim().replaceAll(RegExp(r'\s+'), '')
    ) ? null : INVALID_ZIP_CODE_MESSAGE;

String? validateAddress(String? value) => value != null && value.trim().length >= 6
    ? null
    : INVALID_SHORT_ADDRESS_MESSAGE;

String? validateNeighborhood(String? value) => value != null && value.trim().length >= 4
    ? null
    : INVALID_SHORT_NEIGHBORHOOD_MESSAGE;

String? validateEmail(String? value) => value.isValidEmail
    ? null
    : INVALID_EMAIL_MESSAGE;

String? validatePassword(String? value) => value != null && value.trim().length >= 6
    ? null
    : INVALID_SHORT_PASSWORD_MESSAGE;

String? validateDescription(String? value) => value != null && value.trim().length >= 20
    ? null
    : INVALID_SHORT_DESCRIPTION_MESSAGE;

String? validateCity(String? value) => value != null && value.trim().length > 3
    ? null
    : "Cidade precisa ter mais de 3 caracteres.";
