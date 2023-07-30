import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_crud/homepage.dart';

class EditDataPage extends StatefulWidget {
  final Map ListData;
  const EditDataPage({Key? key, required this.ListData}) : super(key: key);

  @override
  State<EditDataPage> createState() => _EditDataPageState();
}

class _EditDataPageState extends State<EditDataPage> {
  final formKey = GlobalKey<FormState>();
  TextEditingController id = TextEditingController();
  TextEditingController nisn = TextEditingController();
  TextEditingController nama = TextEditingController();
  TextEditingController alamat = TextEditingController();
  TextEditingController pendidikan_agama = TextEditingController();
  TextEditingController pkn = TextEditingController();
  TextEditingController bahasa_indonesia = TextEditingController();
  TextEditingController matematika = TextEditingController();
  TextEditingController ipa = TextEditingController();
  TextEditingController ips = TextEditingController();
  TextEditingController seni_budaya = TextEditingController();
  TextEditingController bahasa_inggris = TextEditingController();
  TextEditingController penjaskes = TextEditingController();
  TextEditingController tik = TextEditingController();
  TextEditingController izin = TextEditingController();
  TextEditingController sakit = TextEditingController();
  TextEditingController tanpa_keterangan = TextEditingController();
  TextEditingController catatan = TextEditingController();

  Future _update() async {
    final response = await http.post(
      Uri.parse('https://perpusesgul4.000webhostapp.com/edit.php'),
      body: {
        "id": id.text,
        "nisn": nisn.text,
        "nama": nama.text,
        "alamat": alamat.text,
        "pendidikan_agama": pendidikan_agama.text,
        "pkn": pkn.text,
        "bahasa_indonesia": bahasa_indonesia.text,
        "matematika": matematika.text,
        "ipa": ipa.text,
        "ips": ips.text,
        "seni_budaya": seni_budaya.text,
        "bahasa_inggris": bahasa_inggris.text,
        "penjaskes": penjaskes.text,
        "tik": tik.text,
        "izin": izin.text,
        "sakit": sakit.text,
        "tanpa_keterangan": tanpa_keterangan.text,
        "catatan": catatan.text,
      },
    );
    if (response.statusCode == 200) {
      return true;
    }
    return false;
  }

  @override
  void initState() {
    id.text = widget.ListData['id'];
    nisn.text = widget.ListData['nisn'];
    nama.text = widget.ListData['nama'];
    alamat.text = widget.ListData['alamat'];
    pendidikan_agama.text = widget.ListData['pendidikan_agama'];
    pkn.text = widget.ListData['pkn'];
    bahasa_indonesia.text = widget.ListData['bahasa_indonesia'];
    matematika.text = widget.ListData['matematika'];
    ipa.text = widget.ListData['ipa'];
    ips.text = widget.ListData['ips'];
    seni_budaya.text = widget.ListData['seni_budaya'];
    bahasa_inggris.text = widget.ListData['bahasa_inggris'];
    penjaskes.text = widget.ListData['penjaskes'];
    tik.text = widget.ListData['tik'];
    izin.text = widget.ListData['izin'];
    sakit.text = widget.ListData['sakit'];
    tanpa_keterangan.text = widget.ListData['tanpa_keterangan'];
    catatan.text = widget.ListData['catatan'];
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Edit Data")),
      body: Form(
        key: formKey,
        child: SingleChildScrollView(
          // Wrap the content with SingleChildScrollView
          padding: EdgeInsets.all(10),
          child: Column(
            children: [
              Padding(
                padding: EdgeInsets.only(left:15, bottom: 15, right: 15, top:5), //apply padding to all four sides
                child: Text("Data Diri Siswa",
                  style: TextStyle(fontSize: 20, color: Colors.black)),
              ),
              TextFormField(
                controller: nisn,
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                  labelText: "NISN",
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                validator: (value) {
                  if (value!.isEmpty) {
                    return "NISN tidak Boleh Kosong";
                  }
                },
              ),
              SizedBox(height: 10),
              TextFormField(
                controller: nama,
                decoration: InputDecoration(
                  labelText: "Nama",
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                validator: (value) {
                  if (value!.isEmpty) {
                    return "Nama Tidak Boleh Kosong";
                  }
                },
              ),
              SizedBox(height: 10),
              TextFormField(
                controller: alamat,
                decoration: InputDecoration(
                  labelText: "Kelas",
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                validator: (value) {
                  if (value!.isEmpty) {
                    return "Kelas Tidak Boleh Kosong";
                  }
                },
              ),
              SizedBox(
                height: 10,
              ),
              Padding(
                padding: EdgeInsets.only(left:15, bottom: 15, right: 15, top:5), //apply padding to all four sides
                child: Text("Nilai Siswa",
                  style: TextStyle(fontSize: 20, color: Colors.black)),
              ),
              TextFormField(
                controller: pendidikan_agama,
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                  labelText: "Pendidikan Agama",
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                validator: (value) {
                  if (value!.isEmpty) {
                    return "Nilai Tidak Boleh Kosong";
                  }
                },
              ),
              SizedBox(
                height: 10,
              ),
              TextFormField(
                controller: pkn,
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                  labelText: "PKN",
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                validator: (value) {
                  if (value!.isEmpty) {
                    return "Nilai Tidak Boleh Kosong";
                  }
                },
              ),
              SizedBox(
                height: 10,
              ),
              TextFormField(
                controller: bahasa_indonesia,
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                  labelText: "Bahasa Indonesia",
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                validator: (value) {
                  if (value!.isEmpty) {
                    return "Nilai Tidak Boleh Kosong";
                  }
                },
              ),
              SizedBox(
                height: 10,
              ),
              TextFormField(
                controller: matematika,
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                  labelText: "Matematika",
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                validator: (value) {
                  if (value!.isEmpty) {
                    return "Nilai Tidak Boleh Kosong";
                  }
                },
              ),
              SizedBox(
                height: 10,
              ),
              TextFormField(
                controller: ipa,
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                  labelText: "IPA",
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                validator: (value) {
                  if (value!.isEmpty) {
                    return "Nilai Tidak Boleh Kosong";
                  }
                },
              ),
              SizedBox(
                height: 10,
              ),
              TextFormField(
                controller: ips,
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                  labelText: "IPS",
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                validator: (value) {
                  if (value!.isEmpty) {
                    return "Nilai Tidak Boleh Kosong";
                  }
                },
              ),
              SizedBox(
                height: 10,
              ),
              TextFormField(
                controller: seni_budaya,
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                  labelText: "Seni Budaya",
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                validator: (value) {
                  if (value!.isEmpty) {
                    return "Nilai Tidak Boleh Kosong";
                  }
                },
              ),
              SizedBox(
                height: 10,
              ),
              TextFormField(
                controller: bahasa_inggris,
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                  labelText: "Bahasa Inggris",
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                validator: (value) {
                  if (value!.isEmpty) {
                    return "Nilai Tidak Boleh Kosong";
                  }
                },
              ),
              SizedBox(
                height: 10,
              ),
              TextFormField(
                controller: penjaskes,
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                  labelText: "Penjaskes",
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                validator: (value) {
                  if (value!.isEmpty) {
                    return "Nilai Tidak Boleh Kosong";
                  }
                },
              ),
              SizedBox(
                height: 10,
              ),
              TextFormField(
                controller: tik,
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                  labelText: "TIK",
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                validator: (value) {
                  if (value!.isEmpty) {
                    return "Nilai Tidak Boleh Kosong";
                  }
                },
              ),
              SizedBox(
                height: 10,
              ),
              Padding(
                padding: EdgeInsets.only(left:15, bottom: 15, right: 15, top:5), //apply padding to all four sides
                child: Text("Absensi Siswa (Hari)",
                  style: TextStyle(fontSize: 20, color: Colors.black)),
              ),
              TextFormField(
                controller: izin,
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                  labelText: "Izin",
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                validator: (value) {
                  if (value!.isEmpty) {
                    return "Izin tidak Boleh Kosong";
                  }
                },
              ),
              SizedBox(height: 10),
              TextFormField(
                controller: sakit,
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                  labelText: "Sakit",
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                validator: (value) {
                  if (value!.isEmpty) {
                    return "Sakit Tidak Boleh Kosong";
                  }
                },
              ),
              SizedBox(height: 10),
              TextFormField(
                controller: tanpa_keterangan,
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                  labelText: "Tanpa Keterangan",
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                validator: (value) {
                  if (value!.isEmpty) {
                    return "Tanpa Keterangan Tidak Boleh Kosong";
                  }
                },
              ),
              SizedBox(
                height: 10,
              ),
              Padding(
                padding: EdgeInsets.only(left:15, bottom: 15, right: 15, top:5), //apply padding to all four sides
                child: Text("Catatan Untuk Siswa",
                  style: TextStyle(fontSize: 20, color: Colors.black)),
              ),
              TextFormField(
                controller: catatan,
                decoration: InputDecoration(
                  labelText: "Catatan",
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                validator: (value) {
                  if (value!.isEmpty) {
                    return "Catatan tidak Boleh Kosong";
                  }
                },
              ),
              SizedBox(height: 10),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                onPressed: () {
                  if (formKey.currentState!.validate()) {
                    _update().then((value) {
                      if (value) {
                        final snackBar = SnackBar(
                          content: const Text('Data Berhasil Diupdate'),
                        );
                        ScaffoldMessenger.of(context).showSnackBar(snackBar);
                      } else {
                        final snackBar = SnackBar(
                          content: const Text('Data Gagal Diupdate'),
                        );
                        ScaffoldMessenger.of(context).showSnackBar(snackBar);
                      }
                    });
                    Navigator.pushAndRemoveUntil(
                      context,
                      MaterialPageRoute(builder: ((context) => HomePage())),
                      (route) => false,
                    );
                  }
                },
                child: Text("Update"),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
