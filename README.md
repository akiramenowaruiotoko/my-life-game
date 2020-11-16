# テーブル設計

## users テーブル

| Column             | Type     | Options     |
| --------           | ------   | ----------- |
| nickname           | string   | null: false |
| email              | string   | null: false |
| encrypted_password | string   | null: false |
| free_time          | time     | null: false |
| private            | boolean  | null: false |

### Association

- has_many :targets
- has_many :fights

## targets テーブル

| Column       | Type       | Options           |
| ------       | ------     | -----------       |
| content      | string     | null: false       |
| target_date  | date       | null: false       |
| achieve      | boolean    | null: false       |
| user         | references | foreign_key: true |

### Association

- belongs_to :user
- has_many   :fights

## fights テーブル

| Column        | Type       | Options           |
| -------       | ---------- | ----------------- |
| target        | references | foreign_key: true |
| user          | references | foreign_key: true |

### Association

- belongs_to :target
- belongs_to :user