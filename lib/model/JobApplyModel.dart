class JobApply {
  String applicantId;
  String jobStatus;
  String visaStatus;
  String medicalStatus;
  String amountStatus;
  String flightStatus;
  String jobId;
  String employeeId;
  String role;
  String securityDeposite;
  String documentStatus;
  String mop;
  String paymentDate;
  String visaDate;
    String visaexpiryDate;
  String finalPayment;
  String finalPaymentDate;
  String flightOn;
  String offerLetter;

  JobApply({
    required this.applicantId,
    required this.jobStatus,
    required this.visaStatus,
    required this.medicalStatus,
    required this.amountStatus,
    required this.flightStatus,
    required this.jobId,
    required this.employeeId,
    required this.role,
    required this.securityDeposite,
    required this.documentStatus,
    required this.mop,
    required this.paymentDate,
    required this.visaDate,
    required this.visaexpiryDate,
    required this.finalPayment,
    required this.finalPaymentDate,
    required this.flightOn,
    required this.offerLetter,
  });

  factory JobApply.fromJson(Map<String, dynamic> json) {
  return JobApply(
    applicantId: json['applicantid']?.toString() ?? '',
    jobStatus: json['jobstatus']?.toString() ?? '',
    visaStatus: json['visastatus']?.toString() ?? '',
    medicalStatus: json['medicalstatus']?.toString() ?? '',
    amountStatus: json['amountstatus']?.toString() ?? '',
    flightStatus: json['flightstatus']?.toString() ?? '',
    jobId: json['jobid']?.toString() ?? '',
    employeeId: json['employee_id']?.toString() ?? '',
    role: json['role']?.toString() ?? '',
    securityDeposite: json['security_deposite']?.toString() ?? '',
    documentStatus: json['document_status']?.toString() ?? '',
    mop: json['mop']?.toString() ?? '',
    paymentDate: json['payment_date']?.toString() ?? '',
    visaDate: json['visa_date']?.toString() ?? '',
    visaexpiryDate: json['visa_date']?.toString() ?? '',
    finalPayment: json['final_payment']?.toString() ?? '',
    finalPaymentDate: json['final_payment_date']?.toString() ?? '',
    flightOn: json['flight_on']?.toString() ?? '',
    offerLetter: json['offer_letter']?.toString() ?? '',
  );
}

  

  Map<String, dynamic> toJson() {
    return {
      'applicantid': applicantId,
      'jobstatus': jobStatus,
      'visastatus': visaStatus,
      'medicalstatus': medicalStatus,
      'amountstatus': amountStatus,
      'flightstatus': flightStatus,
      'jobid': jobId,
      'employee_id': employeeId,
      'role': role,
      'security_deposite': securityDeposite,
      'document_status': documentStatus,
      'mop': mop,
      'payment_date': paymentDate,
      'visa_date': visaDate,
      'visa_expirydate': visaexpiryDate,
      'final_payment': finalPayment,
      'final_payment_date': finalPaymentDate,
      'flight_on': flightOn,
      'offer_letter': offerLetter,
    };
  }
}
