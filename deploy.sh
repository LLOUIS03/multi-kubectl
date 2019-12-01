docker build -t llouis/multi-client:latest -t llouis/multi-client:$SHA -f ./client/Dockerfile ./client
docker build -t llouis/multi-server:latest -t llouis/multi-server:$SHA -f ./server/Dockerfile ./server
docker build -t llouis/multi-worker:latest -t llouis/multi-worker:$SHA -f ./worker/Dockerfile ./worker

docker push llouis/multi-client:latest
docker push llouis/multi-server:latest
docker push louis/multi-worker:latest

docker push llouis/multi-client:$SHA
docker push llouis/multi-server:$SHA
docker push louis/multi-worker:$SHA

kubectl apply -f k8s
kubectl set image deployments/server-deployment server=llouis/multi-server:$SHA
kubectl set image deployments/client-deployment client=llouis/multi-client:$SHA
kubectl set image deployments/worker-deployment worker=llouis/multi-worker:$SHA