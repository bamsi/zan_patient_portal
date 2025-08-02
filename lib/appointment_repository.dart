class AppointmentRepository {
  Future<List<String>> getAvailableTimeSlots(DateTime date) async {
    // Mock implementation
    await Future.delayed(const Duration(seconds: 1));
    return [
      '09:00 AM',
      '10:00 AM',
      '11:00 AM',
      '02:00 PM',
      '03:00 PM',
      '04:00 PM',
    ];
  }

  Future<void> bookAppointment({
    required DateTime date,
    required String timeSlot,
  }) async {
    // Mock implementation
    await Future.delayed(const Duration(seconds: 1));
  }
}
