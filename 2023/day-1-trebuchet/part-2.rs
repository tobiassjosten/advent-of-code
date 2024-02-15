use std::io::{self, BufRead};

/*
e three
e five
e nine
e one

n seven
n ten

o two
r four
t eight
x six
z zero
*/

fn main() {
    const RADIX: u32 = 10;

    let mut result = 0;

    let stdin = io::stdin();

    for line in stdin.lock().lines() {
        let l = line.unwrap();

        for c in l.chars() { 
            if c.is_numeric() {
                result += c.to_digit(RADIX).unwrap() * 10;
                break
            }
        }

        for c in l.chars().rev() { 
            if c.is_numeric() {
                result += c.to_digit(RADIX).unwrap();
                break
            }
        }
    }

    println!("{}", result);
}
