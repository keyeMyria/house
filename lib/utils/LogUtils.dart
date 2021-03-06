class LogUtils {
  static const bool debug = !bool.fromEnvironment("dart.vm.product");

  const LogUtils();

  static log(dynamic msg) {
    if (debug) {
      print(msg);
    }
  }
}
