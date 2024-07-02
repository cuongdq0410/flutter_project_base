abstract class ModelItemMapper<R, M> {
  M mapperTo(R data);

  R mapperFrom(M m) => throw UnimplementedError();
}
