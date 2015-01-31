namespace java billing
namespace rb billing
namespace py billing

service Server {

  bool isPremiumUser(1:i32 user_id),
  bool makePremiumUser(1:i32 user_id)
  bool makeResularUser(1:i32 user_id)

}
