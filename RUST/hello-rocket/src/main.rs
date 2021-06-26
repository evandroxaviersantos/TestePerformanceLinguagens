#[macro_use] extern crate rocket;

#[get("/ping")]
fn index() -> &'static str {
    "Pong"
}

#[launch]
fn rocket() -> _ {cargo build
    rocket::build().mount("/", routes![index])
}