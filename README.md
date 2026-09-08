# 15_1
# Домашнее задание к занятию «Организация сети»

### Подготовка к выполнению задания

1. Домашнее задание состоит из обязательной части, которую нужно выполнить на провайдере Yandex Cloud, и дополнительной части в AWS (выполняется по желанию). 
2. Все домашние задания в блоке 15 связаны друг с другом и в конце представляют пример законченной инфраструктуры.  
3. Все задания нужно выполнить с помощью Terraform. Результатом выполненного домашнего задания будет код в репозитории. 
4. Перед началом работы настройте доступ к облачным ресурсам из Terraform, используя материалы прошлых лекций и домашнее задание по теме «Облачные провайдеры и синтаксис Terraform». Заранее выберите регион (в случае AWS) и зону.

---
### Задание 1. Yandex Cloud 

**Что нужно сделать**

1. Создать пустую VPC. Выбрать зону.
2. Публичная подсеть.

 - Создать в VPC subnet с названием public, сетью 192.168.10.0/24.
 - Создать в этой подсети NAT-инстанс, присвоив ему адрес 192.168.10.254. В качестве image_id использовать fd80mrhj8fl2oe87o4e1.
 - Создать в этой публичной подсети виртуалку с публичным IP, подключиться к ней и убедиться, что есть доступ к интернету.
3. Приватная подсеть.
 - Создать в VPC subnet с названием private, сетью 192.168.20.0/24.
 - Создать route table. Добавить статический маршрут, направляющий весь исходящий трафик private сети в NAT-инстанс.
 - Создать в этой приватной подсети виртуалку с внутренним IP, подключиться к ней через виртуалку, созданную ранее, и убедиться, что есть доступ к интернету.
<img width="1026" height="210" alt="image" src="https://github.com/user-attachments/assets/b93bd176-f6ee-482b-b3d8-487fa2a64b92" />
<img width="1838" height="680" alt="image" src="https://github.com/user-attachments/assets/bc336096-3836-431d-a42b-74ce6989d763" />
<img width="936" height="281" alt="image" src="https://github.com/user-attachments/assets/d0e1ef7f-4a7a-4c84-b6db-6631fc4625db" />
<img width="1849" height="802" alt="image" src="https://github.com/user-attachments/assets/db67ccc8-e14f-4e30-af9e-f4aa41048221" />
<img width="1573" height="282" alt="image" src="https://github.com/user-attachments/assets/3d31624c-aa10-4338-8ce5-cae486f94d6c" />
<img width="1405" height="246" alt="image" src="https://github.com/user-attachments/assets/04dc852f-3265-4254-ba52-d44faeb9a6c6" />
<img width="1490" height="245" alt="image" src="https://github.com/user-attachments/assets/f6322c8f-8388-434b-b26e-c3216cd780cb" />
<img width="1529" height="196" alt="image" src="https://github.com/user-attachments/assets/243c912b-03d5-42d0-9273-9c389cec2b25" />


Resource Terraform для Yandex Cloud:

- [VPC subnet](https://registry.terraform.io/providers/yandex-cloud/yandex/latest/docs/resources/vpc_subnet).
- [Route table](https://registry.terraform.io/providers/yandex-cloud/yandex/latest/docs/resources/vpc_route_table).
- [Compute Instance](https://registry.terraform.io/providers/yandex-cloud/yandex/latest/docs/resources/compute_instance).
