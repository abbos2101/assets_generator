extension MyVariableString on String {
  String get fileName {
    final index = lastIndexOf("/");
    if (index != -1) {
      return substring(index + 1);
    }
    return this;
  }

  String get name {
    final index = lastIndexOf("/");
    final index2 = lastIndexOf(".");
    if (index != -1) {
      if (index2 != -1) {
        return substring(index + 1, index2);
      }
      return substring(index + 1);
    }
    if (index2 != -1) {
      return substring(0, index2);
    }
    return substring(0);
  }

  String toCamelCase() {
    var data = replaceAll('.', '_').toSnakeCase();
    if (data.isEmpty) return "";
    var result = "";
    for (int i = 0; i < data.length; i++) {
      var temp = data[i];
      if (i > 0 && data[i - 1] == "_") {
        temp = data[i].toUpperCase();
      }
      result += temp;
    }
    return result.replaceAll("_", "");
  }

  String toPascalCase() {
    var data = replaceAll('.', '_').toSnakeCase();
    if (data.isEmpty) return "";
    data = "${data[0].toUpperCase()}${data.substring(1)}";
    var result = "";
    for (int i = 0; i < data.length; i++) {
      var temp = data[i];
      if (i > 0 && data[i - 1] == "_") {
        temp = data[i].toUpperCase();
      }
      result += temp;
    }
    return result.replaceAll("_", "");
  }

  String toSnakeCase() {
    var data = "";
    var result = "";

    if (!_hasLowerCase()) {
      return toLowerCase();
    }

    for (int i = 0; i < length; i++) {
      if (RegExp(r'^[A-Z]').hasMatch(this[i])) {
        data += "_";
      }
      data += this[i];
    }
    data = "_${data.toLowerCase()}_";
    data = data.replaceAll("-", "_");

    for (int i = 1; i < data.length; i++) {
      if (data[i - 1] != "_" || data[i] != "_") {
        result += data[i];
      }
    }

    if (result[result.length - 1] == "_") {
      result = result.substring(0, result.length - 1);
    }
    return result;
  }

  String removeExtraSpaces() => replaceAll(RegExp(r'\s+'), ' ').trim();

  bool _hasLowerCase() {
    for (int i = 0; i < length; i++) {
      if (RegExp(r'^[a-z]').hasMatch(this[i])) {
        return true;
      }
    }
    return false;
  }
}
