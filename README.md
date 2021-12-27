# wind

Приложение называется wind, в этой ветке находится само приложение, БД находитя в ветке "main" ["main"](https://github.com/Tukorekt/TestEclipse/tree/main)

*Комментарии к приложению
1) Дизайн выполнен в не самом элегантном стиле, но должно быть понятно и логично (как было сказано под мобильные девайсы);
2) Билдил только без ключа, дебаг-версию;
3) Код старался писть по рекомедациям, так что иногда он будет выглядеть не совсем понятным из-за нежелательности превышать 80 символов в строке и моей приывычки раскрывать виджеты на несколько строк;
4) Использовал ахитектуру flutter_bloc как основу;
5) Строковые значения хранил с помощью пакета intl;
6) В main классе спользовал глобальные переменные, потому что были проблемы с передачей аргументов в некоторые страницы и данные доходили с опозданием от отрисовки страницы;
7) С кешированием работаю буквально второй раз, решил разбить данные на несколько файлов (по файлу для элементов: список пользователей, нформаця о пользователях, посты, альбомы);
8) Отдельно хочу сказать про http запросы. Испытал проблему, когда запрос данных с header-ом не получал коректные данные, а при запросе по ссылке всегда получал нужные, поэтому пришлось GET запросы оформлять в строке ссылки;
9) Тесты не писал, практка есть, но для unit тестов блока (насколько я помню) с http запросами нужно создавать локальные значения данных, а тут буквально все приложение состоит из них. Имеется практика widget тестов, но не решился.
10) APK можно скачать здесь
