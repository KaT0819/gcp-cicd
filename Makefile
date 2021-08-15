
HOST ?= asia.gcr.io
PROJECT ?= work-317400
IMAGE ?= sample

run:
	air

mod:
	go mod vendor

build:
	go build -mod=vendor

init:
	# go get github.com/gorilla/sessions
	go mod vendor
	go mod tidy




gcr_build:
	docker build -f Dockerfile --tag=$(HOST)/$(PROJECT)/$(IMAGE):latest .

gcr_push:
	docker push $(HOST)/$(PROJECT)/$(IMAGE):latest

gcr_list:
	gcloud container images list --repository=$(HOST)/$(PROJECT)

gcr_tag_upd:
	gcloud container images add-tag $(HOST)/$(PROJECT)/$(IMAGE):latest $(HOST)/$(PROJECT)/$(IMAGE):latest-2

gcr_tag_delete:
	gcloud container images untag $(HOST)/$(PROJECT)/$(IMAGE):latest-3

gcs-auth:
	# gsutil iam ch TYPE:EMAIL_ADDRESS:objectViewer gs://BUCKET_NAME
	# gsutil iam ch allUsers:objectViewer gs://asia.artifacts.work-317400.appspot.com
	gsutil iam ch user:katuyuki.toki@gmail.com:objectViewer gs://asia.artifacts.work-317400.appspot.com
