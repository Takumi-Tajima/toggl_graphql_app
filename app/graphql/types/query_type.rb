# frozen_string_literal: true

module Types
  class QueryType < Types::BaseObject
    field :node, Types::NodeType, null: true, description: 'Fetches an object given its ID.' do
      argument :id, ID, required: true, description: 'ID of the object.'
    end

    def node(id:)
      context.schema.object_from_id(id, context)
    end

    field :nodes, [Types::NodeType, { null: true }], null: true, description: 'Fetches a list of objects given a list of IDs.' do
      argument :ids, [ID], required: true, description: 'IDs of the objects.'
    end

    def nodes(ids:)
      ids.map { |id| context.schema.object_from_id(id, context) }
    end

    # Add root-level fields here.
    # They will be entry points for queries on your schema.

    # TODO: remove me
    field :test_field, String, null: false,
                               description: 'An example field added by the generator'
    def test_field
      'Hello World!'
    end

    field :user, resolver: Resolvers::UserResolver

    field :users, [Types::UserType], null: false
    def users
      User.all
    end
  end
end

# https://zenn.dev/igaiga/books/rails-practice-note/viewer/rails_graphql_workshop#1%E3%81%A4%E5%8F%96%E5%BE%97%E3%81%99%E3%82%8B-field-%3Auser
