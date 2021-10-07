import '../../../../domain/entities/account_entity.dart';
import '../account_presenter.dart';

extension AccountPresenterMapper on AccountPresenter {
  AccountEntity toEntity() => AccountEntity(
    id: id,
    name: name,
    document: document,
    email: email,
    phone: phone,
    zip: zip,
    address: address,
    number: number,
    neighborhood: neighborhood,
    city: city,
    state: state,
    isWorker: isWorker,
    description: description,
    status: status,
    cause: cause,
    categoryId: categoryId,
  );
}