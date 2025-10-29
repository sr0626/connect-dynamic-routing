import base64, json

def lambda_handler(event, context):
    for rec in event.get("Records", []):
        try:
            raw = base64.b64decode(rec["kinesis"]["data"])
            obj = json.loads(raw)
        except Exception as e:
            obj = {"_error": str(e)}
        print(json.dumps(obj))
    return {"status": "ok", "records": len(event.get("Records", []))}
