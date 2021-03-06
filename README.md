# ujhgj_platform
ujhgj Platform repository

##### HW #1

1. Подготовлен образ и k8s-манифест для веб-сервера, отдающего содержимое папки /app на 8000 порту.
2. Подготовлен k8s-манифест для пода hipster-frontend (заимствованы только переменные окружения).

##### HW #2

1. Добавлены ReplicaSets и соответствующие Deployments для hipster-frontend и hipster-paymentservice.
2. Для hipster-paymentservice подготовлены варианты Deployments со стратегиями развёртывания
    - blue-green update
    - reverse rolling update.
3. Заготовлен DaemonSet для развёртывания node-exporter для worker и master нод.

##### HW #3

1. Task 01
    1. Создан Service Account bob, выдана роль admin в рамках всего кластера.
    1. Создан Service Account dave без доступа к кластеру.
1. Task 02
    1. Создан Namespace prometheus.
    1. Создан Service Account carol в этом Namespace.
    1. Всем Service Account в Namespace prometheus Выдана возможность делать get, list, watch в отношении Pods всего кластера.
1. Task 03
    1. Создан Namespace dev.
    1. Создан Service Account jane в Namespace dev.
    1. Для jane выдана роль admin в рамках Namespace dev.
    1. Создан Service Account ken в Namespace dev.
    1. Для ken выдана роль view в рамках Namespace dev.

##### HW #4

1. Созданы Deployment с readiness и liveness probes для подов.
1. Создан сервис, предоставляющий доступ к подам через ClusterIP.
1. Рассмотрены схемы маршрутизации на базе iptables и IPVS.
1. Установлен MetalLB, добавлен маршрут для трафика из хостовой системы на MetalLB.
1. Создан сервис, предоставляющий доступ к подам через MetalLB.
1. Настроены сервисы (TCP+UDP) типа LoadBalancer, предоставляющий доступ к подам kube-dns.
1. В кластер установлен nginx-ingress-controller, настроен эндпойнт для тестового приложения через ingress.
1. В кластер установлен kubernetes-dashboard и настроен ingress для него, предоставляющий доступ по пути /dashboard.
1. Рассмотрена функция  nginx ingress контроллера включения канареечнего траффика.

##### HW #5
1. Создан statefulset для minio и headless сервис для доступа к statefulset
1. Добавлен secret для использованяия в шаблоне пода для minio

##### HW #6
1. Развёрнут K8s кластер в GKE при помощи Terraform
1. Установлен чарт nginx-ingress из stable репозитория https://kubernetes-charts.storage.googleapis.com
1. Установлен чарт jetstack/cert-manager v1.0.2 (вместе с CIDR), добавлен ACME ClusterIssuer
1. Установлен чарт chartmuseum с tls сертификатом
1. Создан демо-чарт demosphen, опубликован в chartmuseum
        
        helm create demosphen
        helm package demosphen
        curl -uchart:museum --data-binary "@demosphen-0.1.0.tgz" https://chartmuseum.35.246.147.156.nip.io/api/charts

а затем установлен в кластере из chartmuseum

        helm repo add my-chartmuseum https://chart:museum@chartmuseum.35.246.147.156.nip.io
        kubectl create ns demosphen
        helm upgrade --install demosphen my-chartmuseum/demosphen --wait --namespace=demosphen
1. Установлен и настроен чарт harbor
1. Установка nginx-ingress, cert-manager и harbor перенесена в helmfile
1. Создан чарты hipster-shop и frontend, где первый включает в список зависимостей второй, а так же чарт redis от bitnami 
1. Сервисы paymentservice и shippingservice вынесены из общего манифеста и сгенерированы через jsonnet, при помощи kubecfg
1. Сервис cartservice вынесен из общего манифеста из сгенерирован через kustomize с возможностью разделить окружения

##### HW #7
1. Созданы CustomResourceDefinition и CustomResource для Mysql сервера
2. Доработал оператор из примера в ДЗ.

Оператор написан на Kopf (Python) и создаёт Service, Deployment, а так же по два PV и PVC
для хранилища Mysql и для бэкапа. Оператор бэкапит базу при удалении CustomResource, а при создании CustomResource 
пытается восстановить базу из бэкапа, управляя ресурсами типа Job:
 ```
k get jobs
NAME                         COMPLETIONS   DURATION   AGE
backup-mysql-instance-job    1/1           2s         2m32s
restore-mysql-instance-job   1/1           15m        16m
```
В паке `test` есть два скрипт: `fill_db.sh` заполняет базу данными, а `select_test.sh` получает данные из базы.
```
+----+-------------+
| id | name        |
+----+-------------+
|  1 | some data   |
|  2 | some data-2 |
+----+-------------+
```
Чтобы задеплоить оператор в кластер создаются ServiceAccount, ClusterRole и ClusterRoleBinding и Deployment.
Исходники и Dockerfile находятся в директории `build`. 
