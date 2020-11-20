# テーブル設計

## users テーブル

| Column             | Type     | Options     |
| --------           | ------   | ----------- |
| name               | string   | null: false |
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
| user_id      | integer    | null: false       |

### Association

- belongs_to :user
- has_one    :achieve
- has_many   :fights

## achieves テーブル

| Column        | Type       | Options           |
| -------       | ---------- | ----------------- |
| target_id     | integer    | null: false       |

### Association

- belongs_to :target

## fights テーブル

| Column        | Type       | Options           |
| -------       | ---------- | ----------------- |
| target_id     | integer    | null: false       |
| user_id       | integer    | null: false       |

### Association

- belongs_to :target
- belongs_to :user
