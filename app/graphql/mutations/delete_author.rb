class Mutations::DeleteAuthor < GraphQL::Schema::Mutation
  null true

  argument :id, ID, required: false

  def resolve(id:)
    Author.find(id)&.destroy!
  end
end