class Contacts {
  final int id;
  final String firstName;
  final String lastName;
  final String email;
  final String contactNumber;

  Contacts({this.id,this.firstName,this.lastName,this.email,this.contactNumber});

  Map<String, dynamic> toMap(){
    return{
      'id':id,
      'firstName': firstName,
      'lastName': lastName,
      'email':email,
      'contactNumber': contactNumber

    };
  }

  @override
  String toString() {
    
    return 'Contacts{id: $id, firstName: $firstName, lastName: $lastName, email: $email, contactNumber: $contactNumber}';
  }
}