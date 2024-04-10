class DataSource {
  final String message;
  const DataSource({
    required this.message,
  });
}

class DataFailure extends DataSource {
  const DataFailure({
    required super.message,
  });
}

class DataSuccess<T> extends DataSource {
  final T data;
  const DataSuccess({
    required this.data,
    required super.message,
  });
}
