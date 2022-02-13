class WallpaperModel {
  String photographer;
  int photographer_id;
  String photographer_url;
  SrcModal src;

  WallpaperModel(
      {this.photographer,
      this.photographer_id,
      this.photographer_url,
      this.src});

  factory WallpaperModel.fromMap(Map<String, dynamic> jsonData) {
    return WallpaperModel(
      src: SrcModal.fromMap(jsonData["src"]),
      photographer: jsonData['photographer'],
      photographer_id: jsonData['photographer_id'],
      photographer_url: jsonData['photographer_url'],
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
