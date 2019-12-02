# README

## userテーブル
|Column|Type|Options|
|--|--|--|
|nickname |string|null: false, unique: true|
|email    |string|null: false, unique: true|
|password |string|null: false|

- has_many :comments
- has_many :reviews


## reviewテーブル
|Column|Type|Options|
|--|--|--|
|content | text |null: false|
|user_id | references | null: false, foreign_key: true |
|album_id | references | null: false, foreign_key: true|
|artist_id | references | null: false, foreign_key: true|

- has_many :tags, through: :reviews_tags
- has_many :reviews_tags
- belongs_to :user
- belongs_to :album


## albumテーブル
|Column|Type|Options|
|--|--|--|
|title     |string|null: false|
|artist_id |references | null: false, foreign_key: true |

- belongs_to :artist


## artistテーブル
|Column|Type|Options|
|--|--|--|
|name|string|null: false|

- has_many :albums


# commentテーブル
|Column|Type|Options|
|--|--|--|
|content   |text|null: false|
|user_id   |references |null: false, foreign_key: true|
|review_id |references |null: false, foreign_key: true|

- belongs_to :user
- belongs_to :review


## likeテーブル
|Column|Type|Options|
|--|--|--|
|flag | integer | null: false |
|user_id | references | null: false, foreign_key: true |
|review_id | references | null: false, foreign_key: true |

- belongs_to :user
- belongs_to :review


## tagテーブル
|Column|Type|Options|
|--|--|--|
|name|string|null: false|

- has_many :reviews, through: :reviews_tags
- has_many :reviews_tags


# reviews_tagsテーブル
|Column|Type|Options|
|--|--|--|
|album_id |references|null: false, foregin_key: true|
|tag_id   |references|null: false, foregin_key: true|

- belongs_to :review
- belongs_to :tag