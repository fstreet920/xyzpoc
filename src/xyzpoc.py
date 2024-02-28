from flask import Flask
from flask import jsonify
from flask import make_response
from flasgger import Swagger
import logging
import sys
import os
import time

app = Flask(__name__)

# env variables
logLevel = os.environ.get('LOGLEVEL', 'INFO').upper()
listeningPort = os.environ.get('HEXMAP_PORT', '5000')

# setup logging
logging.basicConfig(stream=sys.stdout, level=logLevel)
requests_log = logging.getLogger("requests.packages.urllib3")
requests_log.setLevel(logLevel)
requests_log.propagate = True
app.logger.addHandler(logging.StreamHandler(sys.stdout))
app.logger.setLevel(logLevel)

# define template info for swagger
TEMPLATE = {
    'schemes': [
        'http'
    ],
    "info": {
        "title": "xyzpoc API",
        "description": "API for xyzpoc",
        "contact": {
            "name": "Fain Street",
            "email": "fains1966@gmail.com"
        },
        "version": "0.0.1"
    },
    "components": {
        "schemas": {
            "TestResponse": {
                "type": "object",
                "properties": {
                    "message": {
                        "type": "string",
                        "description": "static message"
                    },
                    "timestamp": {
                        "type": "integer",
                        "description": "timestamp in epoch time, seconds since 1970-01-01 00:00:00 UTC"
                    }
                }
            }
        }
    },
    'tags': [
        {
            'name': 'xyzpoc API',
            'description': 'Rest API for xyzpoc'
        },
    ]
}


@app.route('/healthz')
def healthz():
    '''
    Health Check used for kubernetes probes
    ---
    responses:
      200:
        description: OK
        content:
          text/plain:
          schema:
            type: string
            example: "healthy"
    '''
    resp = make_response('healthy', 200,)
    resp.mimetype = "text/plain"
    return resp


@app.route('/')
def root():
    '''
    Root place holder to respond if root accessed
    ---
    responses:
      200:
        description: OK
        content:
          text/plain:
          schema:
            type: string
            example: "use /test"
    '''
    resp = make_response('use /test', 200,)
    resp.mimetype = "text/plain"
    return resp


@app.route('/test')
def test():
    '''
    Test endpoint
    ---
    responses:
      200:
        description: "test response"
        schema:
            $ref: "#/components/schemas/TestResponse"
        examples:
            application/json: {"message": "Automate all the things!", "timestamp": 1529729125}
    '''
    epoch_time = int(time.time())
    test_resp = {"message": "Automate all the things!", "timestamp": epoch_time}
    resp = make_response(jsonify(test_resp), 200,)
    return resp


swag = Swagger(app, template=TEMPLATE)

# python3 src/flaskapp.py
if __name__ == '__main__':
    port = int(listeningPort)
    logging.info("start at port %s" % (port))
    app.run(host='0.0.0.0', port=port)
