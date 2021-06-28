class Types::AuthorType < Types::BaseObject
  description "An author"

  # null fields means that, if returned record contains null field that we select to be not null by writing null: false,
  # it will return an json error instead of the json result.
  # here is the sample error result
  # {
  #   "data": {
  #     "author": null
  #   },
  #   "errors": [
  #     {
  #       "message": "Cannot return null for non-nullable field Author.yob"
  #     }
  #   ]
  # }
  field :id, ID, null: false
  field :first_name, String, null: true
  field :last_name, String, null: true
  field :yob, Int, null: false
  field :is_alive, Boolean, null: true, camelize: false
end