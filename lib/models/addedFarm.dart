class addedFarm{
  addedFarm({
    this.name,
    this.cost,
    this.group,
    this.location,
    this.company,
    this.quantity,
    this.image,
    this.description,
  });

  String? name;
  int? cost;
  String? group;
  String? location;
  String? company;
  int? quantity;
  String? image;
  String? description;

  factory addedFarm.fromMap(Map<String, dynamic> json) => addedFarm(
    name: json["name"] as String?,
    cost: json["Cost"] as int?,
    group: json["group"] as String?,
    location: json["location"] as String?,
    company: json["company"] as String?,
    quantity: json["quantity"] as int?,
    image: json["image"] as String?,
    description: json["description"] as String?,
  );

  Map<String, dynamic> toMap() => {
    "name": name,
    "Cost": cost,
    "group": group,
    "location": location,
    "company": company,
    "quantity": quantity,
    "image": image,
    "description": description,
  };
}
