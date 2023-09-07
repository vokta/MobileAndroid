class TandonDetail {
  final int id;
  final String nama;
  final String idTandon;
  final int persentase;
  final double latitude;
  final double longitude;
  final int ph;
  final int tds;
  final int ntu;

  TandonDetail({
    required this.id,
    required this.nama,
    required this.idTandon,
    required this.persentase,
    required this.latitude,
    required this.longitude,
    required this.ph,
    required this.tds,
    required this.ntu,
  });

  factory TandonDetail.fromJson(Map<String, dynamic> json) {
    return TandonDetail(
      id: json['id'],
      nama: json['nama'],
      idTandon: json['id_tandon'],
      persentase: json['persentase'],
      latitude: json['latitude'],
      longitude: json['longitude'],
      ph: json['ph'],
      tds: json['tds'],
      ntu: json['ntu'],
    );
  }
}