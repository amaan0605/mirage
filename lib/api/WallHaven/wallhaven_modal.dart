class WallHavenModal {
  String photographer;
  SrcModal src;

  WallHavenModal({this.photographer, this.src});

  factory WallHavenModal.fromMap(Map<String, dynamic> jsonData) {
    return WallHavenModal(
      src: SrcModal.fromMap(jsonData["src"]),
      photographer: jsonData['photographer'],
    );
  }
}

class SrcModal {
  String original;
  String small;
  String portrait;
  String large2x;
  String thumbnail;

  SrcModal(
      {this.original, this.portrait, this.small, this.large2x, this.thumbnail});

  factory SrcModal.fromMap(Map<String, dynamic> jsonData) {
    return SrcModal(
        original: jsonData['original'],
        large2x: jsonData['large2x'],
        small: jsonData['small'],
        portrait: jsonData['portrait'],
        thumbnail: jsonData['large']);
  }
}
