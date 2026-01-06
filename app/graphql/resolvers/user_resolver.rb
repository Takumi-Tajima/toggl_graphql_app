module Resolvers
  class UserResolver < GraphQL::Schema::Resolver
    type Types::UserType, null: true

    argument :id, ID, required: true

    def resolve(id:)
      User.find(id)
    end
  end
end
