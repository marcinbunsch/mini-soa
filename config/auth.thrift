namespace java auth
namespace rb auth
namespace py auth

struct User {
  1:i32 id
  2:string name
  3:string email
  4:string token
}

service Server {

  User getUserById(1:i32 id),
  User getUserByEmail(1:string email),
  User getUserByToken(1:string token)

}
