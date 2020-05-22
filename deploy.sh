docker build -t atsangarides/multi-client:latest -t atsangarides/multi-client:$SHA -f ./client/Dockerfile ./client
docker build -t atsangarides/multi-server:latest -t atsangarides/multi-server:$SHA -f ./server/Dockerfile ./server
docker build -t atsangarides/multi-worker:latest -t atsangarides/multi-worker:$SHA -f ./worker/Dockerfile ./worker
docker push atsangarides/multi-client:latest
docker push atsangarides/multi-server:latest
docker push atsangarides/multi-worker:latest
docker push atsangarides/multi-client:$SHA
docker push atsangarides/multi-server:$SHA
docker push atsangarides/multi-worker:$SHA
kubectl apply -f k8s
kubectl set image deployments/server-deployment server=atsangarides/multi-server:$SHA
kubectl set image deployments/client-deployment client=atsangarides/multi-client:$SHA
kubectl set image deployments/worker-deployment worker=atsangarides/multi-worker:$SHA