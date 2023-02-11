String revisaVaciosString(value) {
  if (value == null) {
    return '';
  }
  if (value == false) {
    return '';
  } else {
    return value;
  }
}

double revisaVaciosFloat(value) {
  if (value == null) {
    return 0.0;
  }
  return value == false ? 0.0 : value;
}

int revisaVaciosInt(value) {
  if (value == null) {
    return 0;
  }
  if (value == false) {
    return 0;
  } else {
    return value;
  }
}

List<dynamic> revisamasters(value) => value == false ? [0, ''] : value;
String crearLinkImagen(value) => value == false ? '' : value;
