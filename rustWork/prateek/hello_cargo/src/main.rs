#[macro_use]
extern crate error_chain;
extern crate pulldown_cmark as cmark;
extern crate tempdir;
extern crate glob;
extern crate bytecount;

//use std::env;
use std::fs::File;
use std::io::{self, Read, Write, Error as IoError};
//use std::mem;
//use std::path::{PathBuf, Path};
//use std::collections::HashMap;
//use cmark::{Parser, Event, Tag};

fn main() {
    let _ = markdown_files_of_directory();
}
/// ```
pub fn markdown_files_of_directory() {
    use glob::{glob_with, MatchOptions};
    let mut out = Vec::new();
    let opts = MatchOptions {
        case_sensitive: false,
        require_literal_separator: false,
        require_literal_leading_dot: false,
    };

    println!("in markdown function");
    for path in glob_with("**/*.md",opts).unwrap() {
        if let Ok(path) = path {
            println!("{:?}", path.display());
            println!("{:?}", path.to_str());
            out.push(path);
        }
    }
    //let filename = out.pop();
    ////Need to implement directory file reading
    let filename = "C++.md";
    println!("Pop last element: {:?}", filename);

    println!("In file {}", filename);

    let mut f = File::open(filename).expect("file not found");

    let mut contents = String::new();
    f.read_to_string(&mut contents)
        .expect("something went wrong reading the file");

    println!("With text:\n{}", contents);
    
    let parser = Parser::new(s);
    //let mut parser = 
}



