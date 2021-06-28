class Types::AuthorInputType < GraphQL::Schema::InputObject
  graphql_name "AuthorInputType"
  description "All the attributes for creating an author"

  argument :first_name, String, required: false
  argument :last_name, String, required: false
  argument :yob, Int, required: false
  argument :is_alive, Boolean, required: false, camelize: false

  # by defining that part, we don't need to write all the fields again and again. Our input will be;
  #
  # Query Part
  # mutation createAuthor($author: AuthorInputType!) {
  #   createAuthor(author: $author) {
  #     id
  #     fullName
  #   }
  # }
  #
  # Query Variables Part
  # {
  #   "author": {"firstName": "Ali5", "lastName": "Bulut5", "yob": 1997, "is_alive": true }
  # }
end

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
  field :full_name, String, null: true
  field :coordinates, Types::CoordinatesType, null: true
  # [Int] => means that return type will be array of integers.
  field :publication_years, [Int], null: false

  def full_name
    # by using object we are able to reach selected Author object.
    ([object.first_name, object.last_name].compact).join(" ")
  end
end