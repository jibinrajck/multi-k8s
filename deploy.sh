docker build -t jibinrajck/multi-client:latest -t jibinrajck/multi-client:$SHA  -f ./client/Dockerfile ./client
docker build -t jibinrajck/multi-server:latest -t jibinrajck/multi-server:$SHA -f ./server/Dockerfile ./server
docker build -t jibinrajck/multi-worker:latest -t jibinrajck/multi-worker:$SHA -f ./worker/Dockerfile ./worker
docker push jibinrajck/multi-client:latest
docker push jibinrajck/multi-server:latest
docker push jibinrajck/multi-worker:latest
docker push jibinrajck/multi-client:$SHA
docker push jibinrajck/multi-server:$SHA
docker push jibinrajck/multi-worker:$SHA
kubectl apply -f k8s

kubectl set image deployments/server-deployment server=jibinrajck/multi-server:$SHA
kubectl set image deployment/client-deployment client=jibinrajck/multi-client:$SHA
kubectl set image deployment/worker-deployment worker=jibinrajck/multi-worker:$SHA