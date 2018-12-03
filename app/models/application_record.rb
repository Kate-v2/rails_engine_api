class ApplicationRecord < ActiveRecord::Base
  self.abstract_class = true


  # --- Filter ---

  def self.id_is(id)
    where(id: id)
  end

  def self.created_on(date)
    # binding.pry
    # where('CAST(created_at AS varchar) = ?', DateTime.parse(date).to_s).order(created_at: :asc)
    where("to_char(created_at, 'YYYY-MM-DD HH:MM:SS') = ?", date).order(created_at: :asc)
  end

  def self.updated_on(date)
    # where('CAST(updated_at AS varchar) = ?', DateTime.parse(date).to_s).order(created_at: :asc)
    where('CAST(updated_at AS varchar) = ?', DateTime.parse(date).to_s).order(created_at: :asc)
  end

  # --- Random ---

  def self.random
    order("RANDOM()").first
  end



end
