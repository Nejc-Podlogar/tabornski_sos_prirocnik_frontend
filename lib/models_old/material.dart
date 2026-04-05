
// Create a model class for Material that contains the following properties:
// a file to download, a name and a description.

class Material {
  final String file;
  final String name;
  final String description;

  Material({required this.file, required this.name, required this.description});

  factory Material.fromJson(Map<String, dynamic> json) {
    return Material(
      file: json['file'],
      name: json['name'],
      description: json['description'],
    );
  }

  Map<String, dynamic> toJson() => {
    'file': file,
    'name': name,
    'description': description,
  };
}