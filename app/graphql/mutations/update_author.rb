class Mutations::UpdateAuthor < GraphQL::Schema::Mutation
  null true

  argument :author, Types::AuthorInputType, required: true

  def resolve(author:)
    Author.find(author[:id])&.update(author.to_h)
  end
end