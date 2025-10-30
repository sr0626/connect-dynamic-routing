resource "aws_connect_routing_profile" "test" {
  description               = "My Routing Profile"
  name                      = "My Routing Profile"
  instance_id               = aws_connect_instance.test.id
  default_outbound_queue_id = data.aws_connect_queue.basic_queue.queue_id

  media_concurrencies {
    channel     = "VOICE"
    concurrency = 1
  }

  queue_configs {
    channel  = "VOICE"
    queue_id = aws_connect_queue.test.queue_id
    priority = 1
    delay    = 2
  }
}

resource "aws_connect_routing_profile" "new_order" {
  description               = "My New Order Routing Profile"
  name                      = "My New Order Routing Profile"
  instance_id               = aws_connect_instance.test.id
  default_outbound_queue_id = data.aws_connect_queue.basic_queue.queue_id

  media_concurrencies {
    channel     = "VOICE"
    concurrency = 1
  }

  queue_configs {
    channel  = "VOICE"
    queue_id = aws_connect_queue.new_order.queue_id
    priority = 1
    delay    = 0
  }
}

resource "aws_connect_routing_profile" "previous_order" {
  description               = "My Previous Order Routing Profile"
  name                      = "My Previous Order Routing Profile"
  instance_id               = aws_connect_instance.test.id
  default_outbound_queue_id = data.aws_connect_queue.basic_queue.queue_id

  media_concurrencies {
    channel     = "VOICE"
    concurrency = 1
  }

  queue_configs {
    channel  = "VOICE"
    queue_id = aws_connect_queue.previous_order.queue_id
    priority = 1
    delay    = 0
  }
}

resource "aws_connect_routing_profile" "recent_purchase" {
  description               = "My Recent Purchase Routing Profile"
  name                      = "My Recent Purchase Routing Profile"
  instance_id               = aws_connect_instance.test.id
  default_outbound_queue_id = data.aws_connect_queue.basic_queue.queue_id

  media_concurrencies {
    channel     = "VOICE"
    concurrency = 1
  }

  queue_configs {
    channel  = "VOICE"
    queue_id = aws_connect_queue.recent_purchase.queue_id
    priority = 1
    delay    = 0
  }
}

resource "aws_connect_routing_profile" "cross_skill" {
  description               = "My Cross Skill Routing Profile"
  name                      = "My Corss Skill Routing Profile"
  instance_id               = aws_connect_instance.test.id
  default_outbound_queue_id = data.aws_connect_queue.basic_queue.queue_id

  media_concurrencies {
    channel     = "VOICE"
    concurrency = 1
  }

  queue_configs {
    channel  = "VOICE"
    queue_id = aws_connect_queue.new_order.queue_id
    priority = 1
    delay    = 20
  }

  queue_configs {
    channel  = "VOICE"
    queue_id = aws_connect_queue.previous_order.queue_id
    priority = 1
    delay    = 20
  }

  queue_configs {
    channel  = "VOICE"
    queue_id = aws_connect_queue.recent_purchase.queue_id
    priority = 1
    delay    = 20
  }
}
