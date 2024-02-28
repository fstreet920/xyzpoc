# xyzpoc
POC for deploying sample application to the cloud in a Kubernetes environment.

# App
## terminal testing:
python3 src/xyzpoc
curl http://127.0.0.1:5000/test

flake8 --ignore E501 src
python3 -m unittest discover src/test
coverage run --omit=/usr/lib/python3/dist-packages/* -m unittest discover src/test
coverage report -m
coverage html


### swagger:
http://127.0.0.1:5000/apidocs

