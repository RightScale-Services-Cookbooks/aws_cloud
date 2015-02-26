actions :set, :get
default_action :set

attribute :name, :kind_of => String, :default => "", :name_attribute => true
attribute :value, :kind_of => String, :default => ""
attribute :resources, :kind_of => String, :default => ""
