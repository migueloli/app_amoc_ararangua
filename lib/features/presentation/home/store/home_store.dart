import 'package:mobx_triple/mobx_triple.dart';

import '../../../../core/errors/failures.dart';

class HomeStore extends MobXStore<Failure, int>{
  HomeStore() : super(0);

  void changePage(int page) => update(page);
}