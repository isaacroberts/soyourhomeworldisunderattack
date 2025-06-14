

// You want an enum for font iDs

//Second enum for bold /ital

class FontInterm {
  final String family;
  final double size;
  final bool? bold;
  final bool italic;
  final double? weight;
  final int? color;

  const FontInterm(this.family, this.size, this.italic,
      {this.bold, this.weight, this.color});
}
