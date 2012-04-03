function(doc) {
  if(doc.type == "link") {
    emit(doc.views, null);
  }
}
