class Banner_model {
  String thumbnail;
  String id;
  String? collectionId;

  Banner_model(this.collectionId, this.id, this.thumbnail);
  factory Banner_model.fromJson(Map<String, dynamic> jsonObject) {
    return Banner_model(
      jsonObject['collectionId'],
      jsonObject['id'],
      'https://pocketbase--bmabfep1.iran.liara.run/api/files/${jsonObject['collectionId']}/${jsonObject['id']}/${jsonObject['thumbnail']}',
    );
  }
}
