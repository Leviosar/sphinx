T enumFromString<T>(Iterable<T> values, String value){
  return values.firstWhere(
      (e) => e.toString().toUpperCase() == value.toUpperCase() || e.toString().split('.')[1].toUpperCase() == value.toUpperCase()
  );
}