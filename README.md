# OCaml ETL Project - Eduardo Mendes Vaz

## Summary

The goal of this project is to develop an ETL program that summarizes the data contained on the files under ```/etl/data```. 

The summarization made by the program should group the **orders** (```/etl/data/order.csv```) and their **order items** (```/etl/data/order_item.csv```) into the following example table:

| order_id | total_amount | total_taxes |
|-----------|-------------|-------------|
| 1         | 1345.88     | 20.34       |
| 5         | 34.54       | 2.35        |
| 14        | 334.44      | 30.4        |

The summarization should also receive arguments in which to filter. These arguments relate to the **status** and **origin** fields from the **order** table.

In addition to the main features, 7 custom features were proposed:

- The program should be able to read data from an internet file (exposed via http protocol);
- The program should be able to save data in and SQLite database;
- The program should be able to join the **order** and **order_item** tables before transforming the data;
- The program should be managed using [```dune```](https://dune.readthedocs.io/en/stable/);
- The program's utility functions should be documentated using the **docstring** format;
- The program should be able to create an additional output that groups the average revenue and tax for each month (and year);
- The project should include tests for all pure functions.

The following steps were followed during the development of this project:

- [Initialization](#initialization)
- [Basic Features Implementation](#basic-features-implementation)
- [Custom Features Implementation](#custom-features-implementation)
- [Testing](#testing)

The steps in which Generative AI (such as ChatGPT and Gemini) where used are flagged, and the details of the usage are described on the end of their section.

## Initialization *

The initialization step of the development included:

- Creating the dune structure
- Creating the main file for the project
- Creating auxiliary functions to read data (CSV functions)

### * AI Usage

During the development of this section, Generative AI was used for the following purpose:

- Understanding the structure generated by the dune project manager;
- Creating the functions used to read data from csv files with ocaml.

## Basic Features Implementation

## Custom Features Implementation

## Testing
