String imgSrcToPkmnName(String src) {
  final splitSrc = src.split('/');
  return splitSrc.last.split('.png')[0];
}