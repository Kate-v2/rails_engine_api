class ApplicationRecord < ActiveRecord::Base
  self.abstract_class = true


  # --- Filter ---

  def self.id_is(id)
    find(id)
  end

  def self.created_on(date)
    where(created_at: date)
  end

  def self.updated_on(date)
    where(updated_at: date)
  end

  # --- Random ---

  def self.random
    order("RANDOM()").first
  end




end
