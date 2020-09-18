# Build the images with both git sha and latest 
docker build -t ragabi/multi-client:latest -t ragabi/multi-client:$SHA -f ./client/Dockerfile ./client
docker build -t ragabi/multi-server:latest -t ragabi/multi-server:$SHA -f ./client/Dockerfile ./server
docker build -t ragabi/multi-worker:latest -t ragabi/multi-worker:$SHA -f ./client/Dockerfile ./worker

# Push the images with both git sha and latest 
docker push ragabi/multi-client:latest
docker push ragabi/multi-server:latest
docker push ragabi/multi-worker:latest
# Push the images with both git sha and latest 
docker push ragabi/multi-client:$SHA
docker push ragabi/multi-server:$SHA
docker push ragabi/multi-worker:$SHA

kubectl apply -f k8s

kubectl set image deployments/client-deployment client=ragabi/multi-client:$SHA
kubectl set image deployments/server-deployment server=ragabi/multi-server:$SHA
kubectl set image deployments/worker-deployment worker=ragabi/multi-worker:$SHA