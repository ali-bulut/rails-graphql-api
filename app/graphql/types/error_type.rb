class Types::ErrorType < Types::BaseObject
  description "An ActiveRecord Error"

  field :field_name, String, null: false, camelize: false
  field :messages, [String], null: false
end