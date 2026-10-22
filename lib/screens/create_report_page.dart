import 'package:flutter/material.dart';

import '../models/issue.dart';
import '../theme/app_colors.dart';
import '../widgets/app_field_label.dart';

class CreateReportPage extends StatefulWidget {
  const CreateReportPage({super.key, required this.onSubmit});

  final ValueChanged<Issue> onSubmit;

  @override
  State<CreateReportPage> createState() => _CreateReportPageState();
}

class _CreateReportPageState extends State<CreateReportPage> {
  final _formKey = GlobalKey<FormState>();
  final _locationController = TextEditingController();
  final _descriptionController = TextEditingController();
  String _category = 'Jalan';

  static const _categories = [
    'Jalan',
    'Penerangan',
    'Kebersihan',
    'Drainase',
    'Fasilitas umum',
    'Lingkungan',
    'Lalu lintas',
    'Lainnya',
  ];

  @override
  void dispose() {
    _locationController.dispose();
    _descriptionController.dispose();
    super.dispose();
  }

  void _submit() {
    if (!_formKey.currentState!.validate()) return;
    widget.onSubmit(
      Issue(
        title: _category,
        category: _category,
        location: _locationController.text.trim(),
        description: _descriptionController.text.trim(),
        date: DateTime.now(),
      ),
    );
    Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.background,
        title: const Text(
          'Buat laporan',
          style: TextStyle(color: AppColors.navy, fontWeight: FontWeight.w800),
        ),
      ),
      body: Form(
        key: _formKey,
        child: ListView(
          padding: const EdgeInsets.fromLTRB(20, 12, 20, 28),
          children: [
            Container(
              height: 174,
              decoration: BoxDecoration(
                color: AppColors.paleBlue,
                borderRadius: BorderRadius.circular(22),
                border: Border.all(color: const Color(0xFFDDE8FF)),
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    height: 58,
                    width: 58,
                    decoration: const BoxDecoration(
                      color: Colors.white,
                      shape: BoxShape.circle,
                    ),
                    child: const Icon(
                      Icons.camera_alt_rounded,
                      color: AppColors.blue,
                      size: 27,
                    ),
                  ),
                  const SizedBox(height: 10),
                  const Text(
                    'Tambahkan foto kondisi',
                    style: TextStyle(color: AppColors.navy, fontWeight: FontWeight.w700),
                  ),
                  const SizedBox(height: 4),
                  const Text(
                    'Foto dapat ditambahkan saat kamera diintegrasikan',
                    style: TextStyle(color: Color(0xFF8491A5), fontSize: 11),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 22),
            const AppFieldLabel('Kategori laporan'),
            const SizedBox(height: 8),
            DropdownButtonFormField<String>(
              initialValue: _category,
              decoration: const InputDecoration(
                prefixIcon: Icon(Icons.category_outlined),
              ),
              items: _categories
                  .map(
                    (category) => DropdownMenuItem(
                      value: category,
                      child: Text(category),
                    ),
                  )
                  .toList(),
              onChanged: (value) {
                if (value != null) setState(() => _category = value);
              },
            ),
            const SizedBox(height: 18),
            const AppFieldLabel('Lokasi kejadian'),
            const SizedBox(height: 8),
            TextFormField(
              controller: _locationController,
              textCapitalization: TextCapitalization.sentences,
              decoration: const InputDecoration(
                hintText: 'Contoh: Jl. Merdeka, Kecamatan Pusat',
                prefixIcon: Icon(Icons.location_on_outlined),
              ),
              validator: (value) => value == null || value.trim().isEmpty
                  ? 'Lokasi wajib diisi'
                  : null,
            ),
            const SizedBox(height: 18),
            const AppFieldLabel('Ceritakan kerusakan'),
            const SizedBox(height: 8),
            TextFormField(
              controller: _descriptionController,
              minLines: 4,
              maxLines: 5,
              textCapitalization: TextCapitalization.sentences,
              decoration: const InputDecoration(
                hintText: 'Jelaskan kondisi dan dampaknya...',
                alignLabelWithHint: true,
              ),
              validator: (value) => value == null || value.trim().isEmpty
                  ? 'Deskripsi wajib diisi'
                  : null,
            ),
            const SizedBox(height: 25),
            SizedBox(
              height: 52,
              child: FilledButton.icon(
                onPressed: _submit,
                icon: const Icon(Icons.send_rounded, size: 18),
                label: const Text(
                  'Kirim laporan',
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                style: FilledButton.styleFrom(
                  backgroundColor: AppColors.blue,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
