function(doc) {
  if(doc.type == "link" && doc.session_id != null) {
    emit(doc.session_id, null);
  }
}
