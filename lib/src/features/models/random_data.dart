import 'dart:math';
import 'package:flutter/material.dart';

class RandomData {
  Random random = Random();
  late ValueNotifier<int> _a;
  late ValueNotifier<int> _b;
  late ValueNotifier<int> operator;
  late ValueNotifier<String> string;
  late ValueNotifier<List<double>> list;

  RandomData() {
    _a = ValueNotifier(random.nextInt(10));
    _b = ValueNotifier(random.nextInt(10) + 1);
    operator = ValueNotifier(random.nextInt(4));
    list = ValueNotifier(_getList());
    string = ValueNotifier(getString());
  }

  List<double> _getList() {
    List<double> temp = _createList();
    while (temp.length != temp.toSet().length) {
      temp = _createList();
    }
    return temp..shuffle();
  }

  List<double> _createList() {
    return [
      correctAnswer(),
      ...List.generate(3, (index) => random.nextInt(20).toDouble())
    ];
  }

  double correctAnswer() {
    String sign = _getOperator();
    return switch (sign) {
      "+" => add(),
      "-" => sub(),
      "*" => ink(),
      "/" => div(),
      _ => 0,
    };
  }

  double add() {
    return (_a.value + _b.value).toDouble();
  }

  double sub() {
    return (_a.value - _b.value).toDouble();
  }

  double ink() {
    return (_a.value * _b.value).toDouble();
  }

  double div() {
    return (_a.value / _b.value).toDouble();
  }

  String _getOperator() {
    return ["+", "-", "*", "/"].elementAt(operator.value);
  }

  String getString() {
    return "${_a.value} ${_getOperator()} ${_b.value} = ?";
  }

  void reset() {
    _a.value = random.nextInt(10);
    _b.value = random.nextInt(10) + 1;
    operator.value = random.nextInt(4);
    list.value = _getList();
    string.value = getString();
  }
}
