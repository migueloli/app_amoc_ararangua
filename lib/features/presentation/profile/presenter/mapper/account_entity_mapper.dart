import '../../../../domain/entities/account_entity.dart';
import '../account_presenter.dart';

extension AccountEntityMapper on AccountEntity {
  AccountPresenter toPresenter() => AccountPresenter(
    id: id,
    status: status,
    cause: cause,
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
    categoryId: categoryId,
  );
}
