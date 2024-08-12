import 'package:analyzer/dart/element/element.dart';
import 'package:analyzer/dart/element/visitor.dart';

class ModelVisitor extends SimpleElementVisitor<void> {
  var _className = '';

  @override
  void visitConstructorElement(ConstructorElement element) {
    _className = "${element.returnType}".replaceAll("*", "");
  }

  String get className => _className;
}
