import 'package:flutter/material.dart';
import 'package:zan_patient_portal/appointment_repository.dart';

class AppointmentProvider with ChangeNotifier {
  final AppointmentRepository _appointmentRepository;

  AppointmentProvider({
    required AppointmentRepository appointmentRepository,
  }) : _appointmentRepository = appointmentRepository;

  List<String> _availableTimeSlots = [];
  bool _isLoading = false;

  List<String> get availableTimeSlots => _availableTimeSlots;
  bool get isLoading => _isLoading;

  Future<void> getAvailableTimeSlots(DateTime date) async {
    _isLoading = true;
    notifyListeners();
    _availableTimeSlots = await _appointmentRepository.getAvailableTimeSlots(date);
    _isLoading = false;
    notifyListeners();
  }

  Future<void> bookAppointment({
    required DateTime date,
    required String timeSlot,
  }) async {
    _isLoading = true;
    notifyListeners();
    await _appointmentRepository.bookAppointment(
      date: date,
      timeSlot: timeSlot,
    );
    _isLoading = false;
    notifyListeners();
  }
}
