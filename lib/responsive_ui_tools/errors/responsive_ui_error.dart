class ResponsiveUIError extends Error {
  final String message;

  ResponsiveUIError(this.message);

  @override
  String toString() {
    return "ResponsiveUIError: $message";
  }
}
