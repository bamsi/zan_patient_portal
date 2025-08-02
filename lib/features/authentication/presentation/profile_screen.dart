import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:zan_patient_portal/l10n/app_localizations.dart';
import 'package:zan_patient_portal/theme_provider.dart';
import 'package:zan_patient_portal/authentication_provider.dart';
import 'package:zan_patient_portal/book_appointment_screen.dart';
import 'package:zan_patient_portal/manage_appointments_screen.dart';
import 'package:zan_patient_portal/billing_payments_screen.dart';
import 'package:zan_patient_portal/health_tracking_screen.dart';
import 'package:zan_patient_portal/medical_records_screen.dart';
import 'package:zan_patient_portal/prescriptions_screen.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _dobController = TextEditingController();
  final _genderController = TextEditingController();
  final _phoneController = TextEditingController();
  final _addressController = TextEditingController();
  final _emergencyContactController = TextEditingController();
  final _insuranceDetailsController = TextEditingController();

  @override
  void dispose() {
    _nameController.dispose();
    _dobController.dispose();
    _genderController.dispose();
    _phoneController.dispose();
    _addressController.dispose();
    _emergencyContactController.dispose();
    _insuranceDetailsController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    return Scaffold(
      appBar: AppBar(
        title: Text(l10n.profile),
        actions: [
          IconButton(
            onPressed: () {
              Provider.of<AuthenticationProvider>(context, listen: false)
                  .signOut();
            },
            icon: const Icon(Icons.logout),
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: ListView(
            children: [
              TextFormField(
                controller: _nameController,
                decoration: InputDecoration(labelText: l10n.name),
              ),
              TextFormField(
                controller: _dobController,
                decoration: InputDecoration(labelText: l10n.dob),
              ),
              TextFormField(
                controller: _genderController,
                decoration: InputDecoration(labelText: l10n.gender),
              ),
              TextFormField(
                controller: _phoneController,
                decoration: InputDecoration(labelText: l10n.phone),
              ),
              TextFormField(
                controller: _addressController,
                decoration: InputDecoration(labelText: l10n.address),
                obscureText: true,
              ),
              TextFormField(
                controller: _emergencyContactController,
                decoration: InputDecoration(labelText: l10n.emergencyContact),
                obscureText: true,
              ),
              TextFormField(
                controller: _insuranceDetailsController,
                decoration: InputDecoration(labelText: l10n.insuranceDetails),
                obscureText: true,
              ),
              const SizedBox(height: 16),
              ElevatedButton(
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    // Handle profile update logic
                  }
                },
                child: Text(l10n.save),
              ),
              const SizedBox(height: 16),
              ElevatedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const BookAppointmentScreen(),
                    ),
                  );
                },
                child: Text(l10n.bookAppointment),
              ),
              const SizedBox(height: 16),
              ElevatedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const ManageAppointmentsScreen(),
                    ),
                  );
                },
                child: Text(l10n.manageAppointments),
              ),
              const SizedBox(height: 16),
              ElevatedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const MedicalRecordsScreen(),
                    ),
                  );
                },
                child: Text(l10n.medicalRecords),
              ),
              const SizedBox(height: 16),
              ElevatedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const PrescriptionsScreen(),
                    ),
                  );
                },
                child: Text(l10n.prescriptions),
              ),
              const SizedBox(height: 16),
              ElevatedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const BillingPaymentsScreen(),
                    ),
                  );
                },
                child: Text(l10n.billingPayments),
              ),
              const SizedBox(height: 16),
              ElevatedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const HealthTrackingScreen(),
                    ),
                  );
                },
                child: Text(l10n.healthTracking),
              ),
              const SizedBox(height: 16),
              Consumer<ThemeProvider>(
                builder: (context, themeProvider, child) {
                  return SwitchListTile(
                    title: Text(l10n.highContrast),
                    value: themeProvider.highContrast,
                    onChanged: (value) {
                      themeProvider.toggleHighContrast();
                    },
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
