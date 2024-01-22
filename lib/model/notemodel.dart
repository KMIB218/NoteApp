class Kemo {
  int? notesId;
  String? notesTitle;
  String? notesContent;
  String? notesImage;
  int? notesUsers;

  Kemo(
      {this.notesId,
      this.notesTitle,
      this.notesContent,
      this.notesImage,
      this.notesUsers});

  Kemo.fromJson(Map<String, dynamic> json) {
    notesId = json['notes_id'];
    notesTitle = json['notes_title'];
    notesContent = json['notes_content'];
    notesImage = json['notes_image'];
    notesUsers = json['notes_users'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['notes_id'] = notesId;
    data['notes_title'] = notesTitle;
    data['notes_content'] = notesContent;
    data['notes_image'] = notesImage;
    data['notes_users'] = notesUsers;
    return data;
  }
}
