import 'package:flutter_triple/flutter_triple.dart';

import '../../../../core/errors/failures.dart';

class HomeStore extends NotifierStore<Failure, int>{
  HomeStore() : super(0);

  changePage(int page) => update(page);
}