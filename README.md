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

docker build . -f ./docker/Dockerfile -t streetplaya/xyzpoc:0.0.1
docker run -p 5000:5000 streetplaya/xyzpoc:0.0.1
docker push streetplaya/xyzpoc:0.0.1

minikube addon ingress

kubectl create ns xyzpoc
helm template ./chart -n xyzpoc
helm install xyzpoc ./chart -n xyzpoc
watch kubectl ingress -n xyzpoc xyzpoc-ingress
REM once the ip address is present
curl http://{ingress-ip}/test

### swagger:
http://127.0.0.1:5000/apidocs

