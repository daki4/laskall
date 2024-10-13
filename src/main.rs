fn main() {
    let valSome: Option<i32> = Some(111);
    let valNone: Option<i32> = None;
    let valSomeClone = valSome.clone();
    let valNoneClone = valNone.clone();

    let resultOk: Result<Option<i32>, Option<i32>> = Ok(valSome);
    let resultErr: Result<Option<i32>, Option<i32>> = Err(valNone);
    
    fn optPatternMatch(value: Option<i32>) -> i32 {
        match value {
            Some(val) => val,
            None => 11,
        }
    }

    fn resPatternMatch(value: Result<Option<i32>, Option<i32>>) -> Option<i32> {
        match value {
            Ok(val) => val,
            Err(val) => val,
        }
    }

    println!("Option returned: {}", optPatternMatch(valSomeClone));
    println!("Option returned: {}", optPatternMatch(valNoneClone));

    println!("Result returned: {}", optPatternMatch(resPatternMatch(resultOk)));
    println!("Result returned: {}", optPatternMatch(resPatternMatch(resultErr)));
}
