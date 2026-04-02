class UserModel {
  final int? id;
  final String name;
  final String email;
  final String? batch;
  final TrainingModel? training;
  final int? trainingId;

  UserModel({
    this.id,
    required this.name,
    required this.email,
    this.batch,
    this.training,
    this.trainingId,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      id: json['id'],
      name: json['name'] ?? '',
      email: json['email'] ?? '',
      batch: json['batch']?.toString(),
      training: json['training'] != null
          ? TrainingModel.fromJson(json['training'])
          : null,
      trainingId: json['training_id'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'email': email,
      'batch': batch,
      'training_id': trainingId,
    };
  }
}

class TrainingModel {
  final int id;
  final String namaTraining;

  TrainingModel({required this.id, required this.namaTraining});

  factory TrainingModel.fromJson(Map<String, dynamic> json) {
    return TrainingModel(
      id: json['id'] ?? 0,
      namaTraining:
          json['title'] ??
          json['nama_training'] ??
          json['name'] ??
          json['training_name'] ??
          '',
    );
  }

  @override
  String toString() => namaTraining;
}
