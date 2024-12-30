# pip installs
install:
	pip install -U pip && pip install -r requirements.txt

install-dev:
	pip install -U pip && pip install -r requirements_dev.txt

# local docker deployment
docker-build:
	docker build -t bg-remover .

docker-run:
	docker run -p 8501:8501 bg-remover

# push to docker hub
docker-hub-tag:
	docker tag bg-remover stephenosullivan/bg-remover:latest

docker-hub-push:
	docker push stephenosullivan/bg-remover:latest

# push to gcr 
gcr-tag:
	docker tag bg-remover eu.gcr.io/$(PROJECT_ID)/bg-remover:latest

gcr-push:
	docker push eu.gcr.io/$(PROJECT_ID)/bg-remover:latest

# deploy using cloud run to europe-west2
cloud-run-deploy:
	gcloud run deploy streamlit-bg-remover \
		--image eu.gcr.io/$(PROJECT_ID)/bg-remover:latest \
		--platform managed \
		--region europe-west2 \
		--allow-unauthenticated \
		--port 8501 \
		--memory 2Gi \
		--cpu 1 \
		--min-instances 0 \
		--max-instances 1

