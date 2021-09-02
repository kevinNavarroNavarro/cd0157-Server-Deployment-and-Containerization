FROM  python:stretch

COPY . /app
WORKDIR /app

RUN pip install --upgrade pip
RUN pip install -r requirements.txt

ENTRYPOINT ["gunicorn", "-b", ":8080", "main:APP"]



export URL="a403fa53a96514f12948dd65f87550c1-1498351496.us-east-2.elb.amazonaws.com"

export TOKEN=`curl -d '{"email":"test@test.com","password":"test"}' -H "Content-Type: application/json" -X POST $URL/auth  | jq -r '.token'`

curl --request GET $URL:80/contents -H "Authorization: Bearer ${TOKEN}" | jq
