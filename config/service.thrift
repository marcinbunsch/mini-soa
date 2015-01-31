struct Resource {
  1:i32 id,
  2:string name
}

service Service {

   list<Resource> find(1:map<string,string> params),
   Resource get(1:i32 id),
   Resource create(1:map<string,string> params),
   Resource update(1:i32 id, 2:map<string,string> params),
   bool destroy(1:i32 id)

}

