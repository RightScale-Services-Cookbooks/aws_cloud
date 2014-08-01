require 'net/http'
Net::HTTP.get('169.254.169.254', '/latest/meta-data/').to_s.split("\n").each do |attr|
  if !attr.include?("/")
    default["aws_cloud"]["meta-data"]["#{attr}"] = Net::HTTP.get('169.254.169.254', "latest/meta-data/#{attr}")
  end
end

