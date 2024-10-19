enum DaysOfWeek {
  sunday,
  monday,
  tuesday,
  wednesday,
  thursday,
  friday,
  saturday,
}

extension DaysOfWeekExtension on DaysOfWeek {
  static List<DaysOfWeek> toList() {
    return DaysOfWeek.values.map((day) => day).toList();
  }

  // Method to convert the first letter of a specific day to uppercase
  String capitalizeFirstLetter(String value) {
    if (value.isEmpty) return value;
    return value[0].toUpperCase() + value.substring(1).toLowerCase();
  }
}
