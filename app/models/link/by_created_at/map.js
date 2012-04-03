function(doc) {
  if(doc.type == "link" && doc.created_at != null) {
    emit(doc.created_at, null);
  }
}
