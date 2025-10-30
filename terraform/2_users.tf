# #--- Admin User (CONNECT_MANAGED directory) ---
resource "aws_connect_user" "admin" {
  #depends_on  = [data.aws_connect_security_profile.admin, data.aws_connect_routing_profile.basic]

  instance_id = aws_connect_instance.test.id
  # Login credentials (CONNECT_MANAGED only)
  name                 = "my_admin"
  password             = "Password1234"
  routing_profile_id   = aws_connect_routing_profile.test.routing_profile_id
  security_profile_ids = [data.aws_connect_security_profile.admin.arn]

  identity_info {
    first_name = "AdminF"
    last_name  = "AdminL"
    email      = "Admin@Admin.com"
  }

  phone_config {
    phone_type                    = "SOFT_PHONE"
    after_contact_work_time_limit = 0
    auto_accept                   = true
    # desk_phone_number             = null
  }
}

resource "aws_connect_user" "new_order_agent" {
  instance_id          = aws_connect_instance.test.id
  name                 = "new_order"
  password             = "Password1234"
  routing_profile_id   = aws_connect_routing_profile.new_order.routing_profile_id
  security_profile_ids = [data.aws_connect_security_profile.agent.arn]

  identity_info {
    first_name = "neworder"
    last_name  = "agent"
  }

  phone_config {
    after_contact_work_time_limit = 0
    phone_type                    = "SOFT_PHONE"
  }
}

resource "aws_connect_user" "previous_order_agent" {
  instance_id          = aws_connect_instance.test.id
  name                 = "previous_order"
  password             = "Password1234"
  routing_profile_id   = aws_connect_routing_profile.previous_order.routing_profile_id
  security_profile_ids = [data.aws_connect_security_profile.agent.arn]

  identity_info {
    first_name = "previousorder"
    last_name  = "agent"
  }

  phone_config {
    after_contact_work_time_limit = 0
    phone_type                    = "SOFT_PHONE"
  }
}

resource "aws_connect_user" "recent_purchase_agent" {
  instance_id          = aws_connect_instance.test.id
  name                 = "recent_purchase"
  password             = "Password1234"
  routing_profile_id   = aws_connect_routing_profile.recent_purchase.routing_profile_id
  security_profile_ids = [data.aws_connect_security_profile.agent.arn]

  identity_info {
    first_name = "recentpurchase"
    last_name  = "agent"
  }

  phone_config {
    after_contact_work_time_limit = 0
    phone_type                    = "SOFT_PHONE"
  }
}

resource "aws_connect_user" "cross_agent_1" {
  instance_id          = aws_connect_instance.test.id
  name                 = "cross_agent_1"
  password             = "Password1234"
  routing_profile_id   = aws_connect_routing_profile.cross_skill.routing_profile_id
  security_profile_ids = [data.aws_connect_security_profile.agent.arn]

  identity_info {
    first_name = "cross"
    last_name  = "agent one"
  }

  phone_config {
    after_contact_work_time_limit = 0
    phone_type                    = "SOFT_PHONE"
  }
}

resource "aws_connect_user" "cross_agent_2" {
  instance_id          = aws_connect_instance.test.id
  name                 = "cross_agent_2"
  password             = "Password1234"
  routing_profile_id   = aws_connect_routing_profile.cross_skill.routing_profile_id
  security_profile_ids = [data.aws_connect_security_profile.agent.arn]

  identity_info {
    first_name = "cross"
    last_name  = "agent two"
  }

  phone_config {
    after_contact_work_time_limit = 0
    phone_type                    = "SOFT_PHONE"
  }
}

resource "aws_connect_user" "cross_agent_3" {
  instance_id          = aws_connect_instance.test.id
  name                 = "cross_agent_3"
  password             = "Password1234"
  routing_profile_id   = aws_connect_routing_profile.cross_skill.routing_profile_id
  security_profile_ids = [data.aws_connect_security_profile.agent.arn]

  identity_info {
    first_name = "cross"
    last_name  = "agent three"
  }

  phone_config {
    after_contact_work_time_limit = 0
    phone_type                    = "SOFT_PHONE"
  }
}