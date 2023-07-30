import 'package:flutter/material.dart';
import 'package:flutter_crud/editdata.dart';
import 'package:flutter_crud/tambahdata.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import 'package:flutter_crud/loginpage.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List _listdata = [];
  List _filteredData = [];
  bool _isloading = true;
  TextEditingController _searchController = TextEditingController();

  Future _getdata() async {
    try {
      final response = await http.get(
          Uri.parse('https://perpusesgul4.000webhostapp.com/read.php'));
      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        setState(() {
          _listdata = data;
          _filteredData = _listdata; // Initially, display all data
          _isloading = false;
        });
      }
    } catch (e) {
      print(e);
    }
  }

  // Function to filter data based on search input
  void _filterData(String query) {
    setState(() {
      _filteredData = _listdata.where((student) {
        final String name = student['nama'].toLowerCase();
        final String nisn = student['nisn'].toLowerCase();
        final String lowercaseQuery = query.toLowerCase();
        return name.contains(lowercaseQuery) || nisn.contains(lowercaseQuery);
      }).toList();
    });
  }

  Future _hapus(String id) async {
    try {
      final respone = await http.post(
          Uri.parse('https://perpusesgul4.000webhostapp.com/hapus.php'),
          body: {
            "nisn": id,
          });
      // print(respone.body);
      if (respone.statusCode == 200) {
        return true;
      }
      return false;
    } catch (e) {
      print(e);
    }
  }

  Future<void> _handleRefresh() async {
    setState(() {
      _isloading = true;
    });
    await _getdata();
    setState(() {
      _isloading = false;
      _filteredData = List.from(_listdata); // Reset filtered data to original data
    });
  }

  void _logout() {
    Navigator.pushAndRemoveUntil(
      context,
      MaterialPageRoute(builder: (context) => LoginPage()),
      (route) => false,
    );
  }

  @override
  void initState() {
    _getdata();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Halaman Guru"),
        actions: [
          IconButton(
            icon: Icon(Icons.refresh),
            onPressed: _handleRefresh, // Call the refresh function on button press
          ),
          IconButton(
            icon: Icon(Icons.logout),
            onPressed: _logout,
          ),
        ],
      ),
      body: _isloading
            ? Center(
                child: CircularProgressIndicator(),
              )
            : Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: TextField(
                      controller: _searchController,
                      onChanged: (query) {
                        _filterData(query); // Call the filter function on text change
                      },
                      decoration: InputDecoration(
                        hintText: 'Cari berdasarkan Nama atau NISN',
                        prefixIcon: Icon(Icons.search),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(8)),
                        ),
                      ),
                    ),
                  ),
                  Expanded(
                    child: ListView.builder(
                      itemCount: _filteredData.length,
                      itemBuilder: ((context, index) {
                        return Card(
                          child: InkWell(
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: ((context) => EditDataPage(
                                        ListData: {
                                          "id": _filteredData[index]['id'],
                                          "nisn": _filteredData[index]['nisn'],
                                          "nama": _filteredData[index]['nama'],
                                          "alamat": _filteredData[index]['alamat'],
                                          "pendidikan_agama": _filteredData[index]['pendidikan_agama'],
                                          "pkn": _filteredData[index]['pkn'],
                                          "bahasa_indonesia": _filteredData[index]['bahasa_indonesia'],
                                          "matematika": _filteredData[index]['matematika'],
                                          "ipa": _filteredData[index]['ipa'],
                                          "ips": _filteredData[index]['ips'],
                                          "seni_budaya": _filteredData[index]['seni_budaya'],
                                          "bahasa_inggris": _filteredData[index]['bahasa_inggris'],
                                          "penjaskes": _filteredData[index]['penjaskes'],
                                          "tik": _filteredData[index]['tik'],
                                          "izin": _filteredData[index]['izin'],
                                          "sakit": _filteredData[index]['sakit'],
                                          "tanpa_keterangan": _filteredData[index]['tanpa_keterangan'],
                                          "catatan": _filteredData[index]['catatan'],
                                        },
                                      )),
                                ),
                              );
                            },
                            child: ListTile(
                              title: Text(_filteredData[index]['nama'], style: TextStyle(fontSize: 15, color: Colors.black)),
                              subtitle: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text('NISN: ${_filteredData[index]['nisn']}'),
                                  Text('Kelas: ${_filteredData[index]['alamat']}'),
                                  Divider(),
                                  Text('Nilai Mata Pelajaran', style: TextStyle(fontSize: 15, color: Colors.black)),
                                  Divider(),
                                  Text('Pendidikan Agama: ${_filteredData[index]['pendidikan_agama']}'),
                                  Text('Pendidikan Kewarganegaraan: ${_filteredData[index]['pkn']}'),
                                  Text('Bahasa Indonesia: ${_filteredData[index]['bahasa_indonesia']}'),
                                  Text('Matematika: ${_filteredData[index]['matematika']}'),
                                  Text('Ilmu Pengetahuan Alam: ${_filteredData[index]['ipa']}'),
                                  Text('Ilmu Pengetahuan Sosial: ${_filteredData[index]['ips']}'),
                                  Text('Seni Budaya: ${_filteredData[index]['seni_budaya']}'),
                                  Text('Bahasa Inggris: ${_filteredData[index]['bahasa_inggris']}'),
                                  Text('Pendidikan Jasmani Kesehatan: ${_filteredData[index]['penjaskes']}'),
                                  Text('Teknologi Informasi Komunikasi: ${_filteredData[index]['tik']}'),
                                  Divider(),
                                  Text('Absensi (Hari)', style: TextStyle(fontSize: 15, color: Colors.black)),
                                  Divider(),
                                  Text('Izin: ${_filteredData[index]['izin']}'),
                                  Text('Sakit: ${_filteredData[index]['sakit']}'),
                                  Text('Tanpa Keterangan: ${_filteredData[index]['tanpa_keterangan']}'),
                                  Divider(),
                                  Text('Catatan', style: TextStyle(fontSize: 15, color: Colors.black)),
                                  Divider(),
                                  Text(_filteredData[index]['catatan']),
                                ],
                              ),
                              trailing: IconButton(
                                  onPressed: () {
                                    showDialog(
                                        context: context,
                                        builder: ((context) {
                                          return AlertDialog(
                                            content: Text(
                                                "Apa Anda Yakin Ingin Menghapus Data?"),
                                            actions: [
                                              ElevatedButton(
                                                  onPressed: () {
                                                    _hapus(_filteredData[index]['nisn'])
                                                        .then((value) {
                                                      if (value) {
                                                        final snackBar = SnackBar(
                                                          content: const Text(
                                                              'Data Berhasil Dihapus'),
                                                        );
                                                        ScaffoldMessenger.of(context)
                                                            .showSnackBar(snackBar);
                                                      } else {
                                                        final snackBar = SnackBar(
                                                          content: const Text(
                                                              'Data Gagal Dihapus'),
                                                        );
                                                        ScaffoldMessenger.of(context)
                                                            .showSnackBar(snackBar);
                                                      }
                                                    });
                                                    Navigator.pushAndRemoveUntil(
                                                        context,
                                                        MaterialPageRoute(
                                                            builder: ((context) =>
                                                                HomePage())),
                                                        (route) => false);
                                                  },
                                                  child: Text("Hapus")),
                                              ElevatedButton(
                                                  onPressed: () {
                                                    Navigator.of(context).pop();
                                                  },
                                                  child: Text("Batal"))
                                            ],
                                          );
                                        }));
                                  },
                                  icon: Icon(Icons.delete)),
                            ),
                          ),
                        );
                      }),
                    ),
                  ),
                ],
              ),
      
      floatingActionButton: FloatingActionButton(
          child: Text(
            "+",
            style: TextStyle(fontSize: 30),
          ),
          onPressed: () {
            Navigator.push(context,
                MaterialPageRoute(builder: ((context) => TambahData())));
          }),
    );
  }
}
