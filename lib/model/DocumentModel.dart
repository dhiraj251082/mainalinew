import 'dart:io';

  class DocumentModel {
    String applicationId;
    // String vediokyc;
    File? passportFront;
    File? passportBack;
    File? passportFull;
    File? technicalQualification;
    File? experience;
    File? highestQualification;
    File? fullLengthPhoto;
    File? passportSizePhoto;
    File? vCertificate;
    File? other1;
    String otherName1;
    File? other2;
    String otherName2;
    File? other3;
    String otherName3;
    File? other4;
    String otherName4;
  
    DocumentModel({
   required this.applicationId,
      // required this.vediokyc,
     this.passportFront,
    this.passportBack,
 this.passportFull,
      this.technicalQualification,
      this.experience,
      this.highestQualification,
      this.fullLengthPhoto,
      this.passportSizePhoto,
      this.vCertificate,
      this.other1,
      this.otherName1 = '', // Provide a default value or mark it as required
      this.other2,
      this.otherName2 = '', // Provide a default value or mark it as required
      this.other3,
      this.otherName3 = '', // Provide a default value or mark it as required
      this.other4,
      this.otherName4 = '', // Provide a default value or mark it as required
    });
  
    File? getFieldFile(String fieldName) {
      switch (fieldName) {
        case 'passportFront':
          return passportFront;
        case 'passportBack':
          return passportBack;
        case 'passportFull':
          return passportFull;
        case 'technicalQualification':
          return technicalQualification;
        case 'experience':
          return experience;
        case 'vCertificate':        
          return vCertificate;
          
          
          case 'fullLengthPhoto':
              return fullLengthPhoto;
            
            case 'passportSizePhoto':
        return passportSizePhoto;
          
        case 'highestQualification':
          return highestQualification;
        case 'other1':
          return other1;
       
        case 'other2':
          return other2;
        case 'other3':
          return other3;
        case 'other4':
          return other4;
  
        // Add cases for other fields
        default:
          return null;
      }
    }
void setFieldFile(String fieldName, File selectedFile) {
    switch (fieldName) {
      case 'passportFront':
        passportFront = selectedFile;
        break;
      case 'passportBack':
        passportBack = selectedFile;
        break;
      case 'passportFull':
        passportFull = selectedFile;
        break;
      case 'technicalQualification':
        technicalQualification = selectedFile;
        break;
      case 'experience':
        experience = selectedFile;
        break;

          case 'fullLengthPhoto':
        fullLengthPhoto = selectedFile;
        break;

          case 'passportSizePhoto':
        passportSizePhoto = selectedFile;
        break;

        
      case 'vCertificate':
        vCertificate = selectedFile;
        break;
      case 'highestQualification':
        highestQualification = selectedFile;
        break;
      case 'other1':
        other1 = selectedFile;
        break;
      case 'other2':
        other2 = selectedFile;
        break;
      case 'other3':
        other3 = selectedFile;
        break;
      case 'other4':
        other4 = selectedFile;
        break;
      // Add cases for other fields
    }
  }
   List<DocumentField> documentFields = [
    DocumentField('passportFront'),
    DocumentField('passportBack'),
    DocumentField('passportFull'),
    DocumentField('technicalQualification'),
    DocumentField('experience'),
    DocumentField('highestQualification'),
    DocumentField('fullLengthPhoto'),
    DocumentField('passportSizePhoto'),
    DocumentField('vCertificate'),
    DocumentField('other1'),
    DocumentField('other2'),
    DocumentField('other3'),
    DocumentField('other4'),
    // Add other fields
  ];

  
    static List<String> documentFieldsList = [
      'applicationId',
      'passportFront',
      'passportBack',
      'passportFull',
      'highestQualification',
      'passportSizePhoto',
      'fullLengthPhoto',
      'vCertificate',
      'experience',
      'other1',
      'other2',
      'other3',
      'other4',
      'otherName1',
      'otherName2',
      'otherName3',
      'otherName4',
    ];

  }
  class DocumentField {
    final String fieldName;
  
    DocumentField(this.fieldName);
  
    bool isImage() {
      // Your logic to determine if the field is an image or a PDF
      // Replace this with your actual logic
      List<String> imageExtensions = ['jpg', 'jpeg', 'png'];
      List<String> pdfExtensions = ['pdf'];
  
      String extension = fieldName.split('.').last.toLowerCase();
  
      return imageExtensions.contains(extension) || pdfExtensions.contains(extension);
    }
    
  }
  
  
  

