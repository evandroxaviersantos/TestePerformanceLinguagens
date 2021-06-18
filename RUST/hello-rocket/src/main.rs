#[macro_use] extern crate rocket;

#[get("/ping")]
fn index() -> &'static str {
    "Pong"
}

#[launch]
fn rocket() -> _ {
    rocket::build().mount("/", routes![index])
}