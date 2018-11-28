
module APIHelper

  def json_data
    JSON.parse(response.body)['data']
  end

  def json_attribute(hash, attr_key)
    hash['attributes'][attr_key]
  end

end
