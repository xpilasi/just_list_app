class ProductMethod {
  static bool isInteger({required String value}) {
    bool intChecked = true;
    try {
      int newValue = int.parse(value);

      newValue is int ? intChecked == true : intChecked == false;
    } catch (e) {
      intChecked = false;
    }

    return intChecked;
  }

  static bool isBoolean({required String value}) {
    bool intChecked = true;
    try {
      double newValue = double.parse(value);

      newValue is double ? intChecked == true : intChecked == false;
    } catch (e) {
      intChecked = false;
    }

    return intChecked;
  }
}
