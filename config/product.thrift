include "auth.thrift"

namespace java product
namespace rb product
namespace py product

struct Note {
  1:i32 id
  2:string text
}

service Server {

  Note addNote(1:auth.User user, 2:string text),
  Note deleteNote(1:auth.User user, 2:i32 id)

}

