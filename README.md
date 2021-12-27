# TestEclipse

В этой ветке находится JSON БД, основная программа находится в ветке ["master"](https://github.com/Tukorekt/TestEclipse/tree/master)

*Примечания по БД и сервису

В бд присутствуют ограничения, которые преодолеваются только установкой локальной БД, из таких:
1) Ограничение на количество символов (10000)
2) Ограничение на изменениях (зменения не будут сохраняться между запросами, при PUT и POST получить новые данные можно только в этом же запросе, в котором и отправлял)
3) Ограничение на ветках (Доступны ветки только по путям уровней 0,1, кастомизация доступа так же доступна только с установкойлокальной БД и настройкой (насколько я понял из репозитория разработчика))
Поэтому: Пользователей только 2, многие данные урезаны, не серчайте, отправки данных на сервер есть как реквест с кодом 201 и новой БД, но, фактически, данные на сервере и в файле на GitHub не обновляются
