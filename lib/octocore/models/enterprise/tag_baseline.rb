require 'massive_record'

require 'octocore/baseline'
require 'octocore/schedeuleable'

module Octo
  class TagBaseline < MassiveRecord::ORM::Table
    extend Octo::Baseline
    extend Octo::Scheduleable

    belongs_to :enterprise, class_name: 'Octo::Enterprise'

    baselineable

    # Specify the type of counter
    baseline_for 'Octo::TagHit'
  end
end
