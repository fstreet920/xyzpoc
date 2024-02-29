FROM python:3.11-slim-buster

# create workdir structure
RUN mkdir -p /usr/src/xyzpoc
# set a directory for the app
WORKDIR /usr/src/xyzpoc

# copy all the files to the container
COPY src/xyzpoc.py .
COPY ./requirements.txt .

# install dependencies
RUN pip install --no-cache-dir -r requirements.txt

EXPOSE 5000

CMD ["python", "./xyzpoc.py"]
