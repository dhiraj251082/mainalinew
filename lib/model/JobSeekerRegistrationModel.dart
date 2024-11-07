class JobseekerFormData {
  String? applicantId;
  String? applicantName;
  String? fatherSpouseName;
  String? dob; // Assuming formattedDOB is a String
  String? gender;
  String? maritalStatus;
  String? customerPhoneNo;
  String? customerWhatsapp;
  String? customerEmail;
  String? height;
  String? weight;
  String? presentAddress1;
  String? presentAddress2;
  String? presentPin;
  String? district;
  String? state;
  String? country;
  String? passportNo;
  String? passportExpiryDate;

  JobseekerFormData({
    this.applicantId,
    this.applicantName,
    this.fatherSpouseName,
    this.dob,
    this.gender,
    this.maritalStatus,
    this.customerPhoneNo,
    this.customerWhatsapp,
    this.customerEmail,
    this.height,
    this.weight,
    this.presentAddress1,
    this.presentAddress2,
    this.presentPin,
    this.district,
    this.state,
    this.country,
    this.passportNo,
    this.passportExpiryDate,
  });

  Map<String, dynamic> toJson() {
    return {
      'applicant_id': applicantId,
      'applicant_name': applicantName,
      'fatherspourse_name': fatherSpouseName,
      'dob': dob,
      'gender': gender,
      'marital_status': maritalStatus,
      'customer_phoneno': customerPhoneNo,
      'customer_whatsapp': customerWhatsapp,
      'customer_email': customerEmail,
      'height': height,
      'weight': weight,
      'present_address1': presentAddress1,
      'present_address2': presentAddress2,
      'present_pin': presentPin,
      'district': district,
      'state': state,
      'country': country,
      'passport_no': passportNo,
      'passport_expiry_date': passportExpiryDate,
    };
  }
}
