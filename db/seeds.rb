#encoding: utf-8
u = User.create(:name => 'admin', :position_id => 1, :email => 'admin@demo.com',:password => '123456', :password_confirmation => '123456')
u.update_attribute :is_admin, true
