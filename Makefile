live:
	pipenv run uvicorn foo.main:app --reload

IMAGE_TAG ?= latest
IMAGE_NAME ?= ghcr.io/chalyi/aws-apprunner-poc:$(IMAGE_TAG)

docker:
	docker build . --tag ${IMAGE_NAME}

docker-image-publish:
	docker push ${IMAGE_NAME}

docker-run:
	docker run -it -p 8000:80 ${IMAGE_NAME}
