import 'package:flutter/foundation.dart';

T tryCast<T>(dynamic x, T fallback){
    try {
      return x as T;
    } catch(e){
      debugPrint('$e: when trying to cast $x to $T!');
      return fallback;
    }
}