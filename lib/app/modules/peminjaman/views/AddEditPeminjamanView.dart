import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sislab/app/data/peminjaman_response.dart';
import 'package:sislab/app/modules/peminjaman/controllers/peminjaman_controller.dart';

class AddEditPeminjamanView extends StatefulWidget {
  final bool isEdit;
  final PeminjamanResponse? data;

  const AddEditPeminjamanView({
    super.key,
    this.isEdit = false,
    this.data,
  });

  @override
  State<AddEditPeminjamanView> createState() => _AddEditPeminjamanViewState();
}

class _AddEditPeminjamanViewState extends State<AddEditPeminjamanView> {
  final _formKey = GlobalKey<FormState>();
  final kegiatanCtrl = TextEditingController();
  final tanggalCtrl = TextEditingController();
  final waktuCtrl = TextEditingController();
  final idBarangCtrl = TextEditingController();
  final jumlahBarangCtrl = TextEditingController();

  int? selectedAnggotaId;
  int? selectedRuanganId;

  final controller = Get.find<PeminjamanController>();

  @override
  void initState() {
    super.initState();
    if (widget.isEdit && widget.data != null) {
      selectedAnggotaId = widget.data!.idAnggota;
      kegiatanCtrl.text = widget.data!.jenisKegiatan ?? '';
      selectedRuanganId = widget.data!.idRuangan;
      tanggalCtrl.text = widget.data!.tanggalPeminjaman ?? '';
      waktuCtrl.text = widget.data!.waktuPeminjaman ?? '';
      idBarangCtrl.text = widget.data!.idBarang?.join(',') ?? '';
      jumlahBarangCtrl.text = widget.data!.jumlahPinjam?.join(',') ?? '';
    }
    controller.fetchPeminjaman(); // Ambil data awal
  }

  List<DropdownMenuItem<int>> getDropdownItems(List<int> ids, {String prefix = 'ID'}) {
    final unique = ids.toSet().toList();
    return unique
        .map((id) => DropdownMenuItem(value: id, child: Text('$prefix $id')))
        .toList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.isEdit ? 'Edit Peminjaman' : 'Tambah Peminjaman'),
        centerTitle: true,
        backgroundColor:
            widget.isEdit ? Colors.orange.shade100 : Colors.teal.shade100,
        foregroundColor: Colors.black87,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => Get.back(),
        ),
      ),
      backgroundColor: const Color(0xFFF9FAFB),
      body: Obx(() {
        final peminjamanList = controller.peminjamanList;

        return SingleChildScrollView(
          padding: const EdgeInsets.all(20),
          child: Form(
            key: _formKey,
            child: Column(
              children: [
                _buildInfoCard(),
                DropdownButtonFormField<int>(
                  value: selectedAnggotaId,
                  items: getDropdownItems(
                      peminjamanList.map((e) => e.idAnggota ?? 0).toList(),
                      prefix: "Anggota"),
                  onChanged: (val) => setState(() => selectedAnggotaId = val),
                  decoration: _inputDecoration("Pilih ID Anggota", Icons.badge),
                  validator: (val) =>
                      val == null ? "ID Anggota wajib dipilih" : null,
                ),
                const SizedBox(height: 12),
                _buildInput(kegiatanCtrl, 'Jenis Kegiatan', Icons.event),
                const SizedBox(height: 12),
                DropdownButtonFormField<int>(
                  value: selectedRuanganId,
                  items: getDropdownItems(
                      peminjamanList.map((e) => e.idRuangan ?? 0).toList(),
                      prefix: "Ruangan"),
                  onChanged: (val) => setState(() => selectedRuanganId = val),
                  decoration:
                      _inputDecoration("Pilih ID Ruangan", Icons.meeting_room),
                  validator: (val) =>
                      val == null ? "ID Ruangan wajib dipilih" : null,
                ),
                const SizedBox(height: 12),
                _buildInput(tanggalCtrl, 'Tanggal Peminjaman (YYYY-MM-DD)',
                    Icons.date_range),
                const SizedBox(height: 12),
                _buildInput(waktuCtrl, 'Waktu Peminjaman (HH:MM)',
                    Icons.access_time),
                const SizedBox(height: 12),
                _buildInput(idBarangCtrl, 'ID Barang (pisahkan dengan koma)',
                    Icons.widgets),
                const SizedBox(height: 12),
                _buildInput(jumlahBarangCtrl,
                    'Jumlah Pinjam (pisahkan dengan koma)', Icons.numbers),
                const SizedBox(height: 24),
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton.icon(
                    icon: Icon(widget.isEdit ? Icons.save : Icons.add),
                    label: Text(widget.isEdit
                        ? 'Simpan Perubahan'
                        : 'Tambah Peminjaman'),
                    onPressed: () {
                      if (_formKey.currentState!.validate()) {
                        final peminjaman = PeminjamanResponse(
                          idAnggota: selectedAnggotaId,
                          jenisKegiatan: kegiatanCtrl.text,
                          idRuangan: selectedRuanganId,
                          tanggalPeminjaman: tanggalCtrl.text,
                          waktuPeminjaman: waktuCtrl.text,
                          idBarang: idBarangCtrl.text
                              .split(',')
                              .map((e) => int.tryParse(e.trim()) ?? 0)
                              .toList(),
                          jumlahPinjam: jumlahBarangCtrl.text
                              .split(',')
                              .map((e) => int.tryParse(e.trim()) ?? 0)
                              .toList(),
                        );

                        if (widget.isEdit) {
                          // TODO: update logic
                          Get.snackbar("Sukses", "Data berhasil diupdate");
                        } else {
                          controller.addPeminjaman(peminjaman);
                          Get.snackbar("Sukses", "Data berhasil ditambahkan");
                        }
                        Get.back();
                      }
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor:
                          widget.isEdit ? Colors.orange : Colors.teal,
                      padding: const EdgeInsets.symmetric(vertical: 14),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      }),
    );
  }

  Widget _buildInfoCard() {
    return Container(
      padding: const EdgeInsets.all(16),
      margin: const EdgeInsets.only(bottom: 20),
      decoration: BoxDecoration(
        color: widget.isEdit ? Colors.orange.shade50 : Colors.teal.shade50,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        children: [
          Icon(
            widget.isEdit ? Icons.edit_calendar : Icons.add_box,
            color: widget.isEdit ? Colors.orange : Colors.teal,
            size: 32,
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Text(
              widget.isEdit
                  ? "Ubah data peminjaman yang sudah ada."
                  : "Masukkan data untuk menambahkan peminjaman baru.",
              style: const TextStyle(fontSize: 15),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildInput(TextEditingController controller, String label, IconData icon) {
    return TextFormField(
      controller: controller,
      decoration: _inputDecoration(label, icon),
      validator: (value) =>
          value == null || value.isEmpty ? 'Tidak boleh kosong' : null,
    );
  }

  InputDecoration _inputDecoration(String label, IconData icon) {
    return InputDecoration(
      labelText: label,
      prefixIcon: Icon(icon, color: Colors.blueGrey),
      filled: true,
      fillColor: Colors.white,
      contentPadding: const EdgeInsets.symmetric(vertical: 16, horizontal: 16),
      border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: const BorderSide(color: Colors.teal, width: 2),
      ),
    );
  }
}
