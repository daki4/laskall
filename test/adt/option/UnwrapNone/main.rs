use std::panic;

fn main() {
    panic::set_hook(Box::new(|_| {}));

    let x: Option<i32> = None;
    let val = panic::catch_unwind(|| x.unwrap());
    println!("{}", val.is_err() == true);
}
