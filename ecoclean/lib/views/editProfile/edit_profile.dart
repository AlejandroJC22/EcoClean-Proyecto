
import 'package:image_picker/image_picker.dart';

//Obtener la imagen seleccionada por el usuario
pickImage(ImageSource source) async{
  final ImagePicker imagePicker = ImagePicker();
  //Clasificar los datos de la imagen
  XFile? _file = await imagePicker.pickImage(source: source);

  //Enviar los datos a add_data
  if(_file != null){
    return await _file.readAsBytes();
  }
  //En caso de no seleccionar imagen, mostrar error
  print('No image selected');
}


