# テーブル設計

## users テーブル(ユーザー情報)

| Column             | Type       | Options                   |
|--------------------|------------|---------------------------|
| nickname           | string     | null: false               |
| email              | string     | null: false, unique: true |
| encrypted_password | string     | null: false               |
| last_name          | string     | null: false               |
| first_name         | string     | null: false               |
| last_name_kana     | string     | null: false               |
| first_name_kana    | string     | null: false               |
| birth              | date       | null: false               |


### Association

* has_many :items
* has_many :orders

## Items テーブル(商品情報)

| Column              | Type       | Options                        |
|---------------------|------------|--------------------------------|
| name                | string     | null: false                    |
| description         | text       | null: false                    |
| category_id         | integer    | null: false                    |
| condition_id        | integer    | null: false                    |
| shipping_fee_id     | integer    | null: false                    |
| shipping_area_id    | integer    | null: false                    |
| shipping_day_id     | integer    | null: false                    |
| price               | integer    | null: false                    |
| user_id             | references | null: false, foreign_key: true |

### Association

- belongs_to :user
- has_one :orders
  extend ActiveHash::Associations::ActiveRecordExtensions
- belongs_to :category
- belongs_to :condition
- belongs_to :shipping_fee
- belongs_to :shipping_area
- belongs_to :shipping_days

## Orders テーブル(購入記録)

| Column            | Type       | Options                        |
|-------------------|------------|--------------------------------|
| item_id           | references | null: false, foreign_key: true |
| user_id           | references | null: false, foreign_key: true |


### Association

- belongs_to :item
- belongs_to :user
- has_one :Shipping_addresses

## Shipping_addresses テーブル(発送先住所)

| Column            | Type       | Options                        |
|-------------------|------------|--------------------------------|
| postal_code       | string     | NOT NULL                       |
| prefecture_id     | integer    | NOT NULL                       |
| city              | string     | NOT NULL                       |
| address_line      | string     | NOT NULL                       |
| building_name     | string     |                                |
| phone_number      | string     | NOT NULL                       |
| order_id          | references | null: false, foreign_key: true |



### Association

- belongs_to :order
  extend ActiveHash::Associations::ActiveRecordExtensions
- belongs_to :prefecture
