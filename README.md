# データベース設計

## users テーブル

| Column             | Type   | Options     |
| ------------------ | ------ | ----------- |
| nickname           | string | null: false |
| email              | string | null: false |
| encrypted_password | string | null: false |
| family_name        | string | null: false |
| first_name         | string | null: false |
| family_name_kana   | string | null: false |
| first_name_kana    | string | null: false |
| birth_day          | date   | null: false |

### Association

- has_many :items
- has_one  :profile

## profiles テーブル

| Column             | Type       | Options                        |
| ------------------ | ---------- | ------------------------------ |
| credit_card_number | bigint     | null: false                    |
| expiration_month   | tinyint(2) | null: false                    |
| expiration_year    | tinyint(2) | null: false                    |
| security_code      | tinyint    | null: false                    |
| postal_code        | integer    | null: false                    |
| prefecture         | string     | null: false                    |
| city               | string     | null: false                    |
| house_number       | string     | null: false                    |
| building_name      | string     | null: false                    |
| phone_number       | bigint     | null: false                    |
| user               | references | null: false, foreign_key: true |

### Association

- has_many :purchase_logs
- belongs_to :user

## items テーブル

| Column        | Type       | Options                        |
| ------------- | ---------- | ------------------------------ |
| title         | string     | null: false                    |
| description   | text       | null: false                    |
| category      | string     | null: false                    |
| condition     | string     | null: false                    |
| delivery_fee  | string     | null: false                    |
| ship_from     | string     | null: false                    |
| delivery_days | string     | null: false                    |
| price         | string     | null: false                    |
| user          | references | null: false, foreign_key: true |
| purchase_log  | references | null: true , foreign_key: true |

### Association

- belongs_to : user
- belongs_to : purchase_log

## purchase_logs テーブル

| Column  | Type       | Options                        |
| --------| ---------- | ------------------------------ |
| item    | references | null: false, foreign_key: true |
| profile | references | null: false, foreign_key: true |

### Association

- has_many :items
- belongs_to :profile