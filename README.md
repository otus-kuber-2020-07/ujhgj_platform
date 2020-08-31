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
