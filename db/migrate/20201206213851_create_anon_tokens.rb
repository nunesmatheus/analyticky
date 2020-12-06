# frozen_string_literal: true

class CreateAnonTokens < ActiveRecord::Migration[6.0]
  def change
    create_table :tokens, &:timestamps
  end
end
