# Создание GKE через Terraform 

## Начальная настройка

Установите [Google Cloud SDK](https://cloud.google.com/sdk/downloads) и [Terraform](https://www.terraform.io/intro/getting-started/install.html)

Сконфигурируйте Google Cloud SDK. Отсюда и дальше в командах-примерах предполагается, что проект в GCP носит имя *second-conquest-290015*.

```bash
gcloud init
```

Создайте Service Account для пайплайна:

```bash
gcloud iam service-accounts create terraform

gcloud iam service-accounts keys create service_account_terraform_credentials.json \
    --iam-account terraform@second-conquest-290015.iam.gserviceaccount.com

gcloud projects add-iam-policy-binding second-conquest-290015 \
    --member serviceAccount:terraform@second-conquest-290015.iam.gserviceaccount.com \
    --role roles/editor
```

Необходимо активировать Kubernetes в консоли GCP.

Создайте state хранилище для Terraform в Google Storage:

```bash
gsutil mb gs://second-conquest-290015/

gsutil acl ch -u terraform@second-conquest-290015.iam.gserviceaccount.com:OWNER \
    gs://second-conquest-290015/
```

## Использование

```bash
terraform init -backend-config=backend-gcs.tfvars

terraform apply
```

## Удаление ресурсов

```bash
terraform destroy

gsutil rm -r gs://second-conquest-290015/
```
