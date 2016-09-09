require 'massive_record'

module Octo
  # A model for tracking the user web flow
  # Used to build a markov model on the basis
  #  of the activity. eg p1 --> p2 will be entered
  #  with weight 1, and increased by +1 every time any
  #  user goes from p1 to p2
  class FunnelTracker < MassiveRecord::ORM::Table

    column_family :info do

      field :enterprise_id

      field :p1
      field :direction, :integer
      field :p2
      field :weight, :integer
    end

  end
end
