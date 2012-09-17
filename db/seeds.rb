Citygate::Engine.load_seed

puts 'Creating permissions for paddy pigeon...'
permissions = [
  # Guest
  {:action => "index", :subject_class => "home", :role_id => nil },
  # Member
  {:action => "create", :subject_class => "Group", :role_id => 1 },
  {:action => "manage", :subject_class => "Group", :conditions => "user_id#user.id", :role_id => 1 },
  {:action => "create", :subject_class => "Event", :role_id => 1 },
  {:action => "manage", :subject_class => "Event", :conditions => "user_id#user.id", :role_id => 1 },
  {:action => "create", :subject_class => "Message", :role_id => 1 },
  {:action => "manage", :subject_class => "Message", :conditions => "user_id#user.id", :role_id => 1 },
  {:action => "create", :subject_class => "Contact", :role_id => 1 },
  {:action => "manage", :subject_class => "Contact", :conditions => "user_id#user.id", :role_id => 1 },
  # Admin
  {:action => "manage", :subject_class => "all", :role_id => 2 }
]
permissions.each do |attributes| 
  Citygate::Permission.create attributes
end unless Citygate::Permission.find_by_action_and_subject_class_and_role_id("create","Group",nil)