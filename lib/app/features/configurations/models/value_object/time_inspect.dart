import 'package:crono_cube/app/shared/interfaces/value_object.dart';

class TimeInspect<T> extends ValueObject<int> {
  TimeInspect({required super.value});

  @override
  String? validate(String? value) {
    String? message;

    if (int.tryParse(value ?? "") == null) {
      message = "Insira um numero inteiro valido";
    }

    return message;
  }
}
