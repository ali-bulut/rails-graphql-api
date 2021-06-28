class Mutations::CreateAuthor < GraphQL::Schema::Mutation
  null true

  # argument :first_name, String, required: false
  # argument :last_name, String, required: false
  # argument :yob, Int, required: false
  # argument :is_alive, Boolean, required: false, camelize: false

  # by defining AuthorInputType in types/author_type.rb, we don't need to write all the fields like above anymore.
  argument :author, Types::AuthorInputType, required: true

  # def resolve(first_name:, last_name:, yob:, is_alive:)
  #   Author.create(first_name: first_name, last_name: last_name, yob: yob, is_alive: is_alive)
  # end

  # by defining AuthorInputType in types/author_type.rb, we don't need to write all the fields like above anymore.
  def resolve(author:)
    Author.create(author.to_h)
  end

  # if user is not superadmin then not allow to create new author.
  def self.authorized?(object, context)
    context[:current_user]&.is_superadmin?
  end

  # Query Variables

  # INPUT

  # Query Part
  # mutation createAuthor($firstName: String, $lastName: String, $yob: Int, $is_alive: Boolean) {
  #   createAuthor(firstName: $firstName, lastName: $lastName, yob: $yob, is_alive: $is_alive) {
  #     id
  #     fullName
  #   }
  # }

  # Query Variables Part
  # {"firstName": "Ali5", "lastName": "Bulut5", "yob": 1997, "is_alive": true }


  # OUTPUT
  # {
  #   "data": {
  #     "createAuthor": {
  #       "id": "5",
  #       "fullName": "Ali5 Bulut5"
  #     }
  #   }
  # }

end