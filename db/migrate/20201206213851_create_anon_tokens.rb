# frozen_string_literal: true

class CreateAnonTokens < ActiveRecord::Migration[6.0]
  def change
    create_table :tokens do |t|
      t.timestamps
    end
  end
end
