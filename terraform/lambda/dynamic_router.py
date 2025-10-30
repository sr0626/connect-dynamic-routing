import os, json, boto3

INSTANCE_ID = os.environ["CONNECT_INSTANCE_ID"]
connect = boto3.client("connect", region_name=os.getenv("REGION"))

# in-memory cache for cold-start reuse
_CACHE = {}

# Map IVR input → queue names (must match queue names in your Connect instance)
QUEUE_MAP = {
    "NewOrder": "My New Order Queue",
    "RepeatOrder": "My Previous Order Queue",
    "RecentPurchase": "My Recent Purchase Queue"
}


def _find_queue_arn_by_name(name: str) -> str | None:
    name = (name or "").strip()
    if not name:
        return None
    if name in _CACHE:
        return _CACHE[name]

    paginator = connect.get_paginator("list_queues")
    for page in paginator.paginate(InstanceId=INSTANCE_ID):
        for q in page.get("QueueSummaryList", []):
            if q.get("Name") == name:
                _CACHE[name] = q.get("Arn")
                return _CACHE[name]
    return None

def lambda_handler(event, _ctx):
    print("event", json.dumps(event))
    
    # Accept from Parameters or Contact Attributes
    #params = event.get("Details", {}).get("Parameters", {})
    #queue_name = params.get("queueName") or attrs.get("queueName") or params.get("CallReason") or attrs.get("CallReason")
    
    call_reason  = event.get("Details", {}).get("ContactData", {}).get("Attributes", {}).get("CallReason")
    print(f"call_reason: {call_reason}")
    queue_name = QUEUE_MAP.get(call_reason)
    print(f"Queue Name: {queue_name}")

    if not queue_name:
        queue_name = "My Basic Queue"

    arn = _find_queue_arn_by_name(queue_name)

    if not arn:
        return {"status": "error", "message": f"Queue not found: {queue_name}"}

    return {"status": "ok", "queueArn": arn, "queueName": queue_name}
