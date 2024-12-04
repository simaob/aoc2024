use std::io::{stdout, Write};
use std::io::{self, BufRead};
use std::fs::File;

fn main() {
    let file = File::open("../input.txt");

    let reader = io::BufReader::new(file);

    let line_count = reader.lines().count();


    let mut lock = stdout().lock();
    writeln!(lock, "{}", "Did the thing").unwrap();
}
