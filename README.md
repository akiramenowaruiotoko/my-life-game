# テーブル設計

## users テーブル

| Column             | Type     | Options     |
| --------           | ------   | ----------- |
| nickname           | string   | null: false |
| email              | string   | null: false |
| encrypted_password | string   | null: false |
| private            | boolean  | null: false |
| free_time          | time     |             |

### Association

- has_many :targets
- has_many :fights

## targets テーブル

| Column       | Type       | Options           |
| ------       | ------     | -----------       |
| content      | string     | null: false       |
| date         | date       | null: false       |
| user         | references | foreign_key: true |

### Association

- belongs_to :user
- has_one    :achieve
- has_many   :fights

## achieves テーブル

| Column        | Type       | Options           |
| -------       | ---------- | ----------------- |
| achieve       | boolean    | null: false       |
| target        | references | foreign_key: true |

### Association

- belongs_to :target

## fights テーブル

| Column        | Type       | Options           |
| -------       | ---------- | ----------------- |
| target        | references | foreign_key: true |
| user          | references | foreign_key: true |

### Association

- belongs_to :target
- belongs_to :user
