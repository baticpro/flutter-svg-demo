class WorkplaceModel {
  final String id;
  final bool isBooked;

  WorkplaceModel copyWith({
    String? id,
    bool? isBooked,
  }) {
    return WorkplaceModel(
      id: id ?? this.id,
      isBooked: isBooked ?? this.isBooked,
    );
  }

  const WorkplaceModel({required this.isBooked, required this.id});
}
