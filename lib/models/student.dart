class Student {
  int? id;
  String firstName;
  String lastName;
  String tgUsername;
  String tgChatId;
  String phone;
  String github;
  String school;
  String region;
  Student({
    this.id,
    required this.firstName,
    required this.lastName,
    required this.tgUsername,
    required this.tgChatId,
    required this.phone,
    required this.github,
    required this.school,
    required this.region,
  });

  factory Student.getStudent(Map data) {
    return Student(
      id: data['id'],
      firstName: data['first_name'],
      lastName: data['last_name'],
      github: data['github'],
      phone: data['phone'],
      tgUsername: data['tg_username'],
      tgChatId: data['tg_chat_id'],
      school: data['school'],
      region: data['region'],
    );
  }
}
