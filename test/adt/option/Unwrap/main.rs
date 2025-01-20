use std::panic;

fn main() {
    panic::set_hook(Box::new(|_| {}));

    let x: Option<i32> = Some(10);
    println!("{}", x.unwrap());
}
