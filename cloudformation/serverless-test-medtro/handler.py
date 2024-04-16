import jwt

def dummy_handler(event, context):
    print(jwt.__version__)
    pass