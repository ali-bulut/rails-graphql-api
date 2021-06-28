class Types::UserType < Types::BaseObject
  description "A User"

  field :id, ID, null: true
  field :email, String, null: true
  field :is_superadmin, Boolean, null: true, camelize: false

  # hide user_type(currentUser:User) from the documentation(schema) if not logged in.
  def self.visible?(context)
    !!context[:current_user]
  end
end