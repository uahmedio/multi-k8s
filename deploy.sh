docker build -t uahmed9/multi-client:latest -t uahmed9/multi-client:$SHA -f ./client/Dockerfile ./client
docker build -t uahmed9/multi-server:latest -t uahmed9/multi-server:$SHA -f ./server/Dockerfile ./server
docker build -t uahmed9/multi-worker:latest -t uahmed9/multi-worker:$SHA -f ./worker/Dockerfile ./worker

docker push uahmed9/multi-client:latest
docker push uahmed9/multi-server:latest
docker push uahmed9/multi-worker:latest

docker push uahmed9/multi-client:$SHA
docker push uahmed9/multi-server:$SHA
docker push uahmed9/multi-worker:$SHA

kubectl apply -f k8s
kubectl set image deployments/server-deployment server=uahmed9/multi-server:$SHA
kubectl set image deployments/client-deployment client=uahmed9/multi-client:$SHA
kubectl set image deployments/worker-deployment worker=uahmed9/multi-worker:$SHA