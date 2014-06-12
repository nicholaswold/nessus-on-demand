class User
  include ActiveAttr::Model

  attribute :name, :type => String
  attribute :calnet, :type => Integer
  attribute :email, :type => String
  attribute :admin, :type => Boolean, :default => false

  @@all_users = []

  def initialize(attributes={})
    super
    @@all_users<< self
  end

  def self.all
    @@all_users
  end
end

f = YAML::load_file(File.join(Rails.root, 'config/users.yml'))
f["Users"]["Standard"].each do |name, values|
  User.new(name: name, calnet: values["calnet"], email: values["email"])
end
f["Users"]["Admin"].each do |name, values|
  User.new(name: name, calnet: values["calnet"], email: values["email"], admin: true)
end
