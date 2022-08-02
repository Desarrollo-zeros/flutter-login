class Product{
  final String Id;
  final String Detailt;
  final String Brand;
  final String Size;
  final String Length;
  final String File;

  Product({ required this.Id, required this.Detailt, required this.Brand, required this.Size, required this.Length, required this.File});

  factory Product.sendDoc(Map<String, dynamic> data){
      return  Product(Id : data['Id'] ?? '',
          Detailt : data['Detailt'] ?? '',
          Brand : data['Brand'] ?? '',
          Size : data['Size'] ?? '',
          Length : data['Length'] ?? '',
          File : data['File'] ?? '',
      );
  }

}