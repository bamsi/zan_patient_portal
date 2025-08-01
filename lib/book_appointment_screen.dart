import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:zan_patient_portal/appointment_provider.dart';

class BookAppointmentScreen extends StatefulWidget {
  const BookAppointmentScreen({super.key});

  @override
  State<BookAppointmentScreen> createState() => _BookAppointmentScreenState();
}

class _BookAppointmentScreenState extends State<BookAppointmentScreen> {
  CalendarFormat _calendarFormat = CalendarFormat.month;
  DateTime _focusedDay = DateTime.now();
  DateTime? _selectedDay;
  String? _selectedTimeSlot;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Book Appointment'),
      ),
      body: Column(
        children: [
          TableCalendar(
            firstDay: DateTime.utc(2010, 10, 16),
            lastDay: DateTime.utc(2030, 3, 14),
            focusedDay: _focusedDay,
            calendarFormat: _calendarFormat,
            selectedDayPredicate: (day) {
              return isSameDay(_selectedDay, day);
            },
            onDaySelected: (selectedDay, focusedDay) {
              setState(() {
                _selectedDay = selectedDay;
                _focusedDay = focusedDay;
                _selectedTimeSlot = null;
              });
              Provider.of<AppointmentProvider>(context, listen: false)
                  .getAvailableTimeSlots(selectedDay);
            },
            onFormatChanged: (format) {
              setState(() {
                _calendarFormat = format;
              });
            },
            onPageChanged: (focusedDay) {
              _focusedDay = focusedDay;
            },
          ),
          const SizedBox(height: 16),
          Consumer<AppointmentProvider>(
            builder: (context, provider, child) {
              if (provider.isLoading) {
                return const Center(child: CircularProgressIndicator());
              }
              if (provider.availableTimeSlots.isEmpty) {
                return const Center(child: Text('No available time slots'));
              }
              return Expanded(
                child: GridView.builder(
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 3,
                    childAspectRatio: 2.5,
                  ),
                  itemCount: provider.availableTimeSlots.length,
                  itemBuilder: (context, index) {
                    final timeSlot = provider.availableTimeSlots[index];
                    return InkWell(
                      onTap: () {
                        setState(() {
                          _selectedTimeSlot = timeSlot;
                        });
                      },
                      child: Card(
                        color: _selectedTimeSlot == timeSlot
                            ? Colors.blue.withOpacity(0.5)
                            : null,
                        child: Center(
                          child: Text(timeSlot),
                        ),
                      ),
                    );
                  },
                ),
              );
            },
          ),
          ElevatedButton(
            onPressed: _selectedDay != null && _selectedTimeSlot != null
                ? () {
                    showDialog(
                      context: context,
                      builder: (context) => AlertDialog(
                        title: const Text('Confirm Appointment'),
                        content: Text(
                          'Are you sure you want to book an appointment on ${_selectedDay!.toLocal()} at $_selectedTimeSlot?',
                        ),
                        actions: [
                          TextButton(
                            onPressed: () {
                              Navigator.pop(context);
                            },
                            child: const Text('Cancel'),
                          ),
                          TextButton(
                            onPressed: () {
                              Provider.of<AppointmentProvider>(context,
                                      listen: false)
                                  .bookAppointment(
                                date: _selectedDay!,
                                timeSlot: _selectedTimeSlot!,
                              );
                              Navigator.pop(context);
                              ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(
                                  content: Text('Appointment booked successfully'),
                                ),
                              );
                            },
                            child: const Text('Book'),
                          ),
                        ],
                      ),
                    );
                  }
                : null,
            child: const Text('Book Appointment'),
          ),
        ],
      ),
    );
  }
}
