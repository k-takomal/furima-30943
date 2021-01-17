# README

## userテーブル

| column          | type   | options     |
| --------------- | ------ | ----------- |
| email           | string | null; false |
| password        | string | null; false |
| nickname        | string | null; false |
| last_name       | string | null; false |
| first_name      | string | null; false |
| last_name_kana  | string | null; false |
| first_name_kana | string | null; false |
| birthday        | date   | null; false |


## itemテーブル

| column      | type       | options     |
| ----------- | ---------- | ----------- |
| name        | string     | null; false |
| text        | text       | null; false |
| category    | integer    | null; false |
| condition   | integer    | null; false |
| postage     | integer    | null; false |
| area        | integer    | null; false |
| days        | integer    | null; false |
| price       | integer    | null; false |
| user        | references |             |


## addressテーブル

| column        | type      | options     |
| ------------- | --------- | ----------- |
| postal_code   | integer   | null; false |
| area          | integer   | null; false |
| cities        | string    | null; false |
| house_number  | string    | null; false |
| building_name | string    |             |
| tel           | integer   | null; false |
| user          | reference |             |


## ordersテーブル
| column  | type       | options     |
| ------- | ---------- | ----------- |
| item    | references |  
| address | references |