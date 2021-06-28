module Types
  class MutationType < Types::BaseObject

    # we moved method and definition to mutations/create_author.rb file and called it from here.
    field :create_author, Types::AuthorType, mutation: Mutations::CreateAuthor
    field :update_author, GraphQL::Types::Boolean, mutation: Mutations::UpdateAuthor

    # update_author's output will be;
    # {
    #   "data": {
    #     "updateAuthor": true
    #   }
    # }
    # Because we choose Boolean for return type.

    # # instead of Types::AuthorType, we may use only AuthorType also.
    # field :create_author, Types::AuthorType, null: true, description: "Create an author" do
    #   argument :first_name, String, required: false
    #   argument :last_name, String, required: false
    #   argument :yob, Int, required: false
    #   argument :is_alive, Boolean, required: false, camelize: false
    # end
    #
    # def create_author(first_name:, last_name:, yob:, is_alive:)
    #   Author.create(first_name: first_name, last_name: last_name, yob: yob, is_alive: is_alive)
    # end

    # input:
    # mutation {
    #   createAuthor(firstName: "Ali3", lastName:"Bulut3", yob: 1999, is_alive: true) {
    #     id
    #     fullName
    #   }
    # }

    # output:
    # {
    #   "data": {
    #     "createAuthor": {
    #       "id": "3",
    #       "fullName": "Ali3 Bulut3"
    #     }
    #   }
    # }
  end
end
