require 'massive_record'
require 'securerandom'
require 'octocore-hbase/helpers/kong_helper'

module Octo
  class Authorization < MassiveRecord::ORM::Table
    include Octo::Helpers::KongHelper


    column_family :info do

      field :username

      field :enterprise_id
      field :email
      field :apikey
      field :session_token
      field :custom_id
      field :password
      field :admin, :boolean
      timestamps
    end

    attr_accessible :username, :enterprise_id, :email, :apikey,
      :session_token, :custom_id, :password, :admin
  end

  def next_id
    SecureRandom.uuid
  end

end

