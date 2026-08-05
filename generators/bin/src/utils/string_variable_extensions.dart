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
    final data = toSnakeCase();
    if (data.isEmpty) return "";
    var result = "";
    for (int i = 0; i < data.length; i++) {
      var temp = data[i];
      if (i > 0 && data[i - 1] == "_") {
        temp = data[i].toUpperCase();
      }
      result += temp;
    }
    result = result.replaceAll("_", "");
    // Dart identifikatori raqam bilan boshlana olmaydi
    if (result.isNotEmpty && RegExp(r'[0-9]').hasMatch(result[0])) {
      result = "\$$result";
    }
    return result;
  }

  String toPascalCase() {
    var data = toSnakeCase();
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
    result = result.replaceAll("_", "");
    if (result.isNotEmpty && RegExp(r'[0-9]').hasMatch(result[0])) {
      result = "\$$result";
    }
    return result;
  }

  String toSnakeCase() {
    // 1. Har qanday ajratuvchini (bo'sh joy, -, ., /, va h.k.) "_" ga keltiramiz
    var source = replaceAll(RegExp(r'[^A-Za-z0-9]+'), '_');

    // 2. camelCase / PascalCase chegaralarini ajratamiz (faqat aralash holatda)
    var data = "";
    if (source._hasLowerCase()) {
      for (int i = 0; i < source.length; i++) {
        if (RegExp(r'[A-Z]').hasMatch(source[i])) {
          data += "_";
        }
        data += source[i];
      }
    } else {
      data = source;
    }

    // 3. Kichik harfga o'tkazib, ketma-ket "_" larni siqamiz va chetlarini kesamiz
    data = data.toLowerCase().replaceAll(RegExp(r'_+'), '_');
    if (data.startsWith('_')) data = data.substring(1);
    if (data.endsWith('_')) data = data.substring(0, data.length - 1);

    return data;
  }

  String removeExtraSpaces() => replaceAll(RegExp(r'\s+'), ' ').trim();

  bool _hasLowerCase() {
    for (int i = 0; i < length; i++) {
      if (RegExp(r'[a-z]').hasMatch(this[i])) {
        return true;
      }
    }
    return false;
  }
}
