include "auth.thrift"

namespace java notes
namespace rb notes
namespace py notes

struct Note {
  1:i32 id
  2:i32 user_id
  3:string text
}

service Server {
  Note addNote(1:auth.User user, 2:string text),
  bool deleteNote(1:auth.User user, 2:i32 id)
}

