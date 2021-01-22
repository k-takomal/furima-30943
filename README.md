# README

## usersテーブル

| column             | type   | options                   |
| ------------------ | ------ | ------------------------- |
| email              | string | null: false, unique: true |
| encrypted_password | string | null: false               |
| nickname           | string | null: false               |
| last_name          | string | null: false               |
| first_name         | string | null: false               |
| last_name_kana     | string | null: false               |
| first_name_kana    | string | null: false               |
| birthday           | date   | null: false               |

### Association
- has_many :items
- has_many :orders


## itemsテーブル

| column       | type       | options           |
| ------------ | ---------- | ----------------- |
| name         | string     | null: false       |
| text         | text       | null: false       |
| category_id  | integer    | null: false       |
| condition_id | integer    | null: false       |
| postage_id   | integer    | null: false       |
| area_id      | integer    | null: false       |
| days_id      | integer    | null: false       |
| price        | integer    | null: false       |
| user         | references | foreign_key: true |

### Association
- belongs_to :user
- has_one :order


## addressテーブル

| column        | type      | options           |
| ------------- | --------- | ----------------- |
| postal_code   | string    | null: false       |
| area_id       | integer   | null: false       |
| cities        | string    | null: false       |
| house_number  | string    | null: false       |
| building_name | string    |                   |
| tel           | string    | null: false       |
| order         | reference | foreign_key: true |

### Association
- belongs_to :order


## ordersテーブル
| column  | type       | options           |
| ------- | ---------- | ----------------- |
| item    | references | foreign_key: true |
| user    | references | foreign_key: true |

### Association
- belongs_to :item
- belongs_to :user
- has_one :address