import 'package:app_amoc_ararangua/core/errors/failures.dart';
import 'package:flutter_triple/flutter_triple.dart';

class HomeStore extends NotifierStore<Failure, int>{
  HomeStore() : super(0);

  changePage(int page) => update(page);
}