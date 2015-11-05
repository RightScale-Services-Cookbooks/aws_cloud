if defined?(ChefSpec)
  def create_cred_file_aws(message)
    ChefSpec::Matchers::ResourceMatcher.new(:aws, :create_cred_file, message)
  end
  
  def connect_aws_lb(message)
    ChefSpec::Matchers::ResourceMatcher.new(:aws_lb, :connect, message)
  end
  
  def disconnect_aws_lb(message)
    ChefSpec::Matchers::ResourceMatcher.new(:aws_lb, :disconnect, message)
  end
end
