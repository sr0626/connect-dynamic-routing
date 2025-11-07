resource "aws_connect_contact_flow" "test" {
  instance_id  = aws_connect_instance.test.id
  name         = "My Dynamic Routing Flow"
  description  = "My Dynamic Routing Flow"
  type         = "CONTACT_FLOW"
  content      = file("${path.module}/../json/contact_flows/MyDynamicRoutingFlow.json")
  #content      = local.contact_flow_content
  content_hash = filebase64sha256("${path.module}/../json/contact_flows/MyDynamicRoutingFlow.json")
}

locals {
  contact_flow_content = templatefile("${path.module}/../json/contact_flows/MyDynamicRoutingFlow.json", {
    queue_arn = aws_connect_queue.test.arn
    queue_id  = aws_connect_queue.test.id
  })
}

data "aws_connect_contact_flow" "basic" {
  instance_id = aws_connect_instance.test.id
  name        = "Sample inbound flow (first contact experience)"
}
