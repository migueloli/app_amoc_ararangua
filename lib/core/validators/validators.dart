import 'package:kayta/extensions/string_extensions.dart';
import 'package:kayta/validators.dart';

const invalidShortNameMessage = 'Nome precisa ter mais de 2 caracteres.';
const invalidDocumentMessage = 'CPF/CNPJ inválido.';
const invalidPhoneMessage = 'Telefone inválido.';
const invalidZipCodeMessage = 'CEP inválido.';
const invalidShortAddressMessage = 'Endereço precisa ter mais de 10 caracteres';
const invalidShortNeighborhoodMessage = 'Bairro precisa ter mais de 3 caracteres';
const invalidEmailMessage = 'E-mail inválido';
const invalidShortPasswordMessage = 'Senha precisa ter 6 ou mais caracteres.';
const invalidShortDescriptionMessage = 'Descrição precisa ter mais de 20 caracteres.';

String? validateName(String? value) => value != null && value.trim().length >= 3
    ? null
    : invalidShortNameMessage;

String? validateDocument(String? value) => value != null && (CPFValidator.isValid(value) || CNPJValidator.isValid(value))
    ? null
    : invalidDocumentMessage;

String? validatePhone(String? value) =>
    value != null &&
    RegExp(
      r'^(?:(?:\+|00)?(55)\s?)?(?:(?:\(?[1-9][0-9]\)?)?\s?)?(?:((?:9\d|[2-9])\d{3})-?(\d{4}))$'
    ).hasMatch(
      value.trim()
    ) ? null : invalidPhoneMessage;

String? validateZip(String? value) =>
    value != null &&
    RegExp(
      r'\d{2}.\d{3}-\d{3}'
    ).hasMatch(
      value.trim().replaceAll(RegExp(r'\s+'), '')
    ) ? null : invalidZipCodeMessage;

String? validateAddress(String? value) => value != null && value.trim().length >= 6
    ? null
    : invalidShortAddressMessage;

String? validateNeighborhood(String? value) => value != null && value.trim().length >= 4
    ? null
    : invalidShortNeighborhoodMessage;

String? validateEmail(String? value) => value.isValidEmail
    ? null
    : invalidEmailMessage;

String? validatePassword(String? value) => value != null && value.trim().length >= 6
    ? null
    : invalidShortPasswordMessage;

String? validateDescription(String? value) => value != null && value.trim().length >= 20
    ? null
    : invalidShortDescriptionMessage;

String? validateCity(String? value) => value != null && value.trim().length > 3
    ? null
    : "Cidade precisa ter mais de 3 caracteres.";
