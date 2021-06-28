module Types
  class QueryType < Types::BaseObject
    # Add `node(id: ID!) and `nodes(ids: [ID!]!)`
    include GraphQL::Types::Relay::HasNodeField
    include GraphQL::Types::Relay::HasNodesField

    # Add root-level fields here.
    # They will be entry points for queries on your schema.

    # TODO: remove me
    field :test_field, String, null: false,
          description: "An example field added by the generator" do
      argument :name, String, required: true
    end

    def test_field(name:)
      "Hello #{name}! #{context[:time]}"
    end

    field :author, Types::AuthorType, null: true, description: "One author" do
      argument :id, ID, required: true
    end

    def author(id:)
      # graphql uses camelCase version of the fields in the queries and results because it's preferred version on Json.
      # we may change it by using camelize: false in author_type.rb file. Let's say we write it for is_alive field in the model.
      # graphql query is that
      # {
      #   author(id: 1) {
      #     firstName
      #     lastName
      #     yob
      #     is_alive
      #     # we may add more fields here to be shown in the result.
      #   }
      # }

      # json result is that
      # {
      #   "data": {
      #     "author": {
      #       "firstName": "Ali",
      #       "lastName": "Bulut",
      #       "yob": 2001,
      #       "is_alive": true,
      #       "id": "1" # if we want to show id in the json data, it's type will be string always.
      #       there are 5 scalar types in GraphQL;
      #       - Int, Float, String, Boolean, ID
      #     }
      #   }
      # }
      Author.find(id)
    end

    field :authors, [Types::AuthorType], null: false, description: "All authors"

    def authors
      Author.all
    end

    field :login, String, null: true, description: "Login a user" do
      argument :email, String, required: true
      argument :password, String, required: true
    end

    # input
    # {
    #   login(email:"ali@mail.com", password:"testtest")
    # }
    #
    # output
    #
    # {
    #   "data": {
    #     "login": "f6db3cf701db264e915b39c30fc647f5bbd40806"
    #   }
    # }
    # "login": null => if it is null, that means credentials are wrong.

    def login(email:, password:)
      if user = User.find_by(email: email)&.authenticate(password)
        user.sessions.create.key
      end
    end

    # latest version of graphql query
    # {
    #   author(id: 1) {
    #     firstName
    #     lastName
    #     yob
    #     is_alive
    #     fullName
    #     coordinates {
    #       latitude
    #       longitude
    #     }
    #     publicationYears
    #   }
    #
    #   authors{
    #     id
    #     fullName
    #   }
    # }

    # latest version of the result
    # {
    #   "data": {
    #     "author": {
    #       "firstName": "Ali",
    #       "lastName": "Bulut",
    #       "yob": 2001,
    #       "is_alive": true,
    #       "fullName": "Ali Bulut",
    #       "coordinates": {
    #         "latitude": 67,
    #         "longitude": 7
    #       },
    #       "publicationYears": [
    #         1865,
    #         1873,
    #         1827
    #       ]
    #     },
    #     "authors": [
    #       {
    #         "id": "1",
    #         "fullName": "Ali Bulut"
    #       },
    #       {
    #         "id": "2",
    #         "fullName": "Ali2 Bulut2"
    #       }
    #     ]
    #   }
    # }
  end
end
