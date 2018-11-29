docker build -t rhtwl/multi-client:latest -t rhtwl/multi-client:$SHA -f ./client/Dockerfile ./client
docker build -t rhtwl/multi-server:latest -t rhtwl/multi-server:$SHA -f ./server/Dockerfile ./server
docker build -t rhtwl/multi-worker:latest -t rhtwl/multi-worker:$SHA -f ./worker/Dockerfile ./worker
docker push rhtwl/multi-client:latest
docker push rhtwl/multi-server:latest
docker push rhtwl/multi-worker:latest
docker push rhtwl/multi-client:$SHA
docker push rhtwl/multi-server:$SHA
docker push rhtwl/multi-worker:$SHA

kubectl apply -f k8s
kubectl set image deployments/server-deployment server=rhtwl/multi-server:$SHA
kubectl set image deployments/client-deployment client=rhtwl/multi-client:$SHA
kubectl set image deployments/client-workder worker=rhtwl/multi-worker:$SHA

