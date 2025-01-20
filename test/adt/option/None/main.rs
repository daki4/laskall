fn main() {
    let x: Option<i32> = None;
    match x {
        Some(val) => println!("{}", val),
        None => println!("None"),
    }
}
