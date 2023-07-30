import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:flutter_crud/loginpage.dart';

class OrangTuaPage extends StatefulWidget {
  const OrangTuaPage({Key? key});

  @override
  State<OrangTuaPage> createState() => _OrangTuaPageState();
}

class _OrangTuaPageState extends State<OrangTuaPage> {
  List _listdata = [];
  List _filteredData = [];
  bool _isloading = true;
  int _selectedBottomNavItem = 0;
  final TextEditingController _searchController = TextEditingController();

  Future _getdata() async {
    try {
      final response =
          await http.get(Uri.parse('https://perpusesgul4.000webhostapp.com/read.php'));
      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        setState(() {
          _listdata = data;
          _filteredData = data;
          _isloading = false;
        });
      }
    } catch (e) {
      print(e);
    }
  }

  void _logout() {
    // Navigate to the LoginPage and remove all previous routes from the stack
    Navigator.pushAndRemoveUntil(
      context,
      MaterialPageRoute(builder: (context) => LoginPage()),
      (route) => false,
    );
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

  // Function to handle refresh
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

  @override
  void initState() {
    _getdata();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: _selectedBottomNavItem == 0
            ? Text("Halaman Orang Tua")
            : Text("Peringkat"),
        actions: [
          IconButton(
            icon: Icon(Icons.refresh),
            onPressed: _handleRefresh, // Call the refresh function on button press
          ),
          IconButton(
            icon: Icon(Icons.logout),
            onPressed: _logout, // Call the logout function on button press
          ),
        ],
      ),
      body: _isloading
          ? Center(
              child: CircularProgressIndicator(),
            )
          : _selectedBottomNavItem == 0
              ? Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: TextField(
                        controller: _searchController,
                        onChanged: (query) {
                          _filterData(query); // Call the filter function on text change
                        },
                        decoration: InputDecoration(
                          labelText: 'Cari berdasarkan Nama atau NISN',
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
                                    builder: (context) => DetailPage(data: _filteredData[index]),
                                  ),
                                );
                              },
                              child: ListTile(
                                title: Text(_filteredData[index]['nama'],
                                    style: TextStyle(fontSize: 15, color: Colors.black)),
                                subtitle: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text('NISN: ${_filteredData[index]['nisn']}'),
                                    Text('Kelas: ${_filteredData[index]['alamat']}'),
                                  ],
                                ),
                              ),
                            ),
                          );
                        }),
                      ),
                    ),
                  ],
                )
              : RankingPage(dataList: _listdata),
      bottomNavigationBar: _BottomNavigation(
        selectedBottomNavItem: _selectedBottomNavItem,
        onTabTapped: (index) {
          setState(() {
            _selectedBottomNavItem = index; // Update the selected index when tapped
          });
        },
      ),
    );
  }
}


class _BottomNavigation extends StatelessWidget {
  final int selectedBottomNavItem;
  final Function(int) onTabTapped;

  _BottomNavigation({required this.selectedBottomNavItem, required this.onTabTapped});

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      type: BottomNavigationBarType.fixed,
      currentIndex: selectedBottomNavItem,
      items: [
        BottomNavigationBarItem(
          icon: Icon(Icons.home, color: selectedBottomNavItem == 0 ? Colors.blue : null),
          label: 'Home',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.pie_chart, color: selectedBottomNavItem == 1 ? Colors.blue : null),
          label: 'Peringkat',
        ),
      ],
      onTap: (index) {
        onTabTapped(index);
      },
    );
  }
}

class DetailPage extends StatelessWidget {
  final Map<String, dynamic> data;

  const DetailPage({required this.data});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Detail'),
      ),
      body: ListView(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              'Nama: ${data['nama']}',
              style: TextStyle(fontSize: 18),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              'NISN: ${data['nisn']}',
              style: TextStyle(fontSize: 18),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              'Kelas: ${data['alamat']}',
              style: TextStyle(fontSize: 18),
            ),
          ),
          SingleChildScrollView(
            scrollDirection: Axis.vertical,
            child: DataTable(
              columns: [
                DataColumn(label: Text('Mata Pelajaran')),
                DataColumn(label: Text('Nilai')),
                DataColumn(label: Text('Keterangan')),
              ],
              rows: [
                DataRow(cells: [
                  DataCell(Text('Pendidikan Agama')),
                  DataCell(Text(data['pendidikan_agama'].toString())),
                  DataCell(Text(int.parse(data['pendidikan_agama']) >= 75 ? 'Lulus' : 'Tidak Lulus')),
                ]),
                DataRow(cells: [
                  DataCell(Text('Pendidikan Kewarganegaraan')),
                  DataCell(Text(data['pkn'].toString())),
                  DataCell(Text(int.parse(data['pkn']) >= 75 ? 'Lulus' : 'Tidak Lulus')),
                ]),
                DataRow(cells: [
                  DataCell(Text('Bahasa Indonesia')),
                  DataCell(Text(data['bahasa_indonesia'].toString())),
                  DataCell(Text(int.parse(data['bahasa_indonesia']) >= 75 ? 'Lulus' : 'Tidak Lulus')),
                ]),
                DataRow(cells: [
                  DataCell(Text('Matematika')),
                  DataCell(Text(data['matematika'].toString())),
                  DataCell(Text(int.parse(data['matematika']) >= 75 ? 'Lulus' : 'Tidak Lulus')),
                ]),
                DataRow(cells: [
                  DataCell(Text('Ilmu Pengetahuan Alam')),
                  DataCell(Text(data['ipa'].toString())),
                  DataCell(Text(int.parse(data['ipa']) >= 75 ? 'Lulus' : 'Tidak Lulus')),
                ]),
                DataRow(cells: [
                  DataCell(Text('Ilmu Pengetahuan Sosial')),
                  DataCell(Text(data['ips'].toString())),
                  DataCell(Text(int.parse(data['ips']) >= 75 ? 'Lulus' : 'Tidak Lulus')),
                ]),
                DataRow(cells: [
                  DataCell(Text('Seni Budaya')),
                  DataCell(Text(data['seni_budaya'].toString())),
                  DataCell(Text(int.parse(data['seni_budaya']) >= 75 ? 'Lulus' : 'Tidak Lulus')),
                ]),
                DataRow(cells: [
                  DataCell(Text('Bahasa Inggris')),
                  DataCell(Text(data['bahasa_inggris'].toString())),
                  DataCell(Text(int.parse(data['bahasa_inggris']) >= 75 ? 'Lulus' : 'Tidak Lulus')),
                ]),
                DataRow(cells: [
                  DataCell(Text('Pendidikan Jasmani Kesehatan')),
                  DataCell(Text(data['penjaskes'].toString())),
                  DataCell(Text(int.parse(data['penjaskes']) >= 75 ? 'Lulus' : 'Tidak Lulus')),
                ]),
                DataRow(cells: [
                  DataCell(Text('Teknologi Informasi Komunikasi')),
                  DataCell(Text(data['tik'].toString())),
                  DataCell(Text(int.parse(data['tik']) >= 75 ? 'Lulus' : 'Tidak Lulus')),
                ]),
              ],
            ),
          ),
          SizedBox(height: 20),
          SingleChildScrollView(
            scrollDirection: Axis.vertical,
            child: DataTable(
              columns: [
                DataColumn(label: Text('Absensi')),
                DataColumn(label: Text('Hari')),
              ],
              rows: [
                DataRow(cells: [
                  DataCell(Text('Izin')),
                  DataCell(Text(data['izin'].toString())),
                ]),
                DataRow(cells: [
                  DataCell(Text('Sakit')),
                  DataCell(Text(data['sakit'].toString())),
                ]),
                DataRow(cells: [
                  DataCell(Text('Tanpa Keterangan')),
                  DataCell(Text(data['tanpa_keterangan'].toString())),
                ]),
              ],
            ),
          ),
          SizedBox(height: 20),
          SingleChildScrollView(
            scrollDirection: Axis.vertical,
            child: DataTable(
              columns: [
                DataColumn(label: Text('Catatan')),
              ],
              rows: [
                DataRow(cells: [
                  DataCell(Text(data['catatan'].toString())),
                ]),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class RankingPage extends StatefulWidget {
  final List dataList;

  RankingPage({required this.dataList});

  @override
  _RankingPageState createState() => _RankingPageState();
}

class _RankingPageState extends State<RankingPage> {
  List<Map<String, dynamic>> _filteredData = [];

  @override
  void initState() {
    _filteredData = List.from(widget.dataList); // Initialize _filteredData with the original dataList
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    // Calculate the average scores for each student and sort the list in descending order
    List<Map<String, dynamic>> studentsWithAvgScore = [];
    for (var student in _filteredData) {
      double avgScore = (double.parse(student['pendidikan_agama']) +
              double.parse(student['pkn']) +
              double.parse(student['bahasa_indonesia']) +
              double.parse(student['matematika']) +
              double.parse(student['ipa']) +
              double.parse(student['ips']) +
              double.parse(student['seni_budaya']) +
              double.parse(student['bahasa_inggris']) +
              double.parse(student['penjaskes']) +
              double.parse(student['tik'])) /
          10.0;

      studentsWithAvgScore.add({
        'nama': student['nama'],
        'nisn': student['nisn'],
        'average_score': avgScore,
      });
    }

    studentsWithAvgScore.sort((a, b) => b['average_score'].compareTo(a['average_score']));

    return Scaffold(
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              itemCount: studentsWithAvgScore.length * 2 + 1, // *2 for the separator lines +1 for the header row
              itemBuilder: (context, index) {
                if (index == 0) {
                  // Header row
                  return Padding(
                    padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Expanded(
                          flex: 1,
                          child: Text('No.', style: TextStyle(fontWeight: FontWeight.bold)),
                        ),
                        Expanded(
                          flex: 3,
                          child: Text('Nama', style: TextStyle(fontWeight: FontWeight.bold)),
                        ),
                        Expanded(
                          flex: 2,
                          child: Text('NISN', style: TextStyle(fontWeight: FontWeight.bold)),
                        ),
                        Expanded(
                          flex: 2,
                          child: Text('Rata-rata', style: TextStyle(fontWeight: FontWeight.bold)),
                        ),
                      ],
                    ),
                  );
                } else if (index.isEven) {
                  // Separator lines
                  return Divider(
                    height: 1,
                    thickness: 1,
                    indent: 16,
                    endIndent: 16,
                  );
                } else {
                  // Data rows
                  final student = studentsWithAvgScore[index ~/ 2];
                  return Padding(
                    padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Expanded(
                          flex: 1,
                          child: Text((index ~/ 2 + 1).toString()),
                        ),
                        Expanded(
                          flex: 3,
                          child: Text(student['nama']),
                        ),
                        Expanded(
                          flex: 2,
                          child: Text(student['nisn']),
                        ),
                        Expanded(
                          flex: 2,
                          child: Text(student['average_score'].toStringAsFixed(2)),
                        ),
                      ],
                    ),
                  );
                }
              },
            ),
          ),
        ],
      ),
    );
  }
}

