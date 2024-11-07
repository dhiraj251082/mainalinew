class DocumentModel1 {
  final int id;
  final int applicantId;
  final String fullLengthPhotoSize;
  final String fullLengthPhotoSizeStatus;
  final String passportSizePhoto;
  final String passportSizePhotoStatus;

  DocumentModel1({
    required this.id,
    required this.applicantId,
    required this.fullLengthPhotoSize,
    required this.fullLengthPhotoSizeStatus,
    required this.passportSizePhoto,
    required this.passportSizePhotoStatus,
  });

  factory DocumentModel1.fromJson(Map<String, dynamic> json) {
    return DocumentModel1(
      id: json['id'],
      applicantId: json['applicant_id'],
      fullLengthPhotoSize: json['full_length_photo_size'],
      fullLengthPhotoSizeStatus: json['full_length_photo_size_status'],
      passportSizePhoto: json['passport_size_photo'],
      passportSizePhotoStatus: json['passport_size_photo_status'],
    );
  }
}
