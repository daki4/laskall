fn main() {
    let x = Some(10);
    match x {
        Some(val) => println!("{}", val),
        None => println!("None"),
    }
}
