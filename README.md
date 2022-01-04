# Theatre API
---

### REST-API ###

Входная точка ``http://localhost:300/api`` (изменяется в конфиге).

Формат - простой JSON API, ответ:

HTTP status:
* 200 Successful request. Body will contain a JSON hash of response data;
* 400 Error: details in response body;
* 401 Authentication error: response body will contain an explanation
* 404 Not found
* 500 Other errors

#### Заголовки
```
"Accept: application/json"
"Content-type: application/json"
```

#### Авторизация по токену: обязательна при каждом запросе
Для общих запросов необходимо передавать [ACCESS_API_TOKEN] - выдается администратором системы.
Для DEV режима ACCESS_API_TOKEN = '123456'
```
"Authorization: Bearer [ACCESS_API_TOKEN]"

Если не верный токен:
status: 401
{"error":"Unauthorized!"}
```

__1 Получение списка спектаклей__
```
GET /spectacles

"Authorization: Bearer [ACCESS_API_TOKEN]"
```

Пример:
```
curl -H "Authorization: Bearer [ACCESS_API_TOKEN]" \
     -H "Accept: application/json" -H "Content-type: application/json" \
     -X GET -d ' {}'
     http://localhost:3000/api/spectacles
```

Ответ:
```
status: 200
{
    "spectacles": [
        {
            "id": 1,
            "name": "first",
            "date_from": "2022-01-03",
            "date_to": "2022-01-05"
        },
        {
            "id": 3,
            "name": "second",
            "date_from": "2022-01-11",
            "date_to": "2022-01-12"
        }
    ]
}
```
При неверном токене:
```
status: 401
{"error":"Unauthorized!"}
```

__2 Создание спектакля__
```
POST /spectacles

"Authorization: Bearer [ACCESS_API_TOKEN]"
{
 "name" - (обязательно, Название)
 "date_from" - (обязательно, Дата начала (19-02-2019))
 "date_to" - (обязательно, Дата окончания (21-03-2019))
}
```

Пример:
```
curl -H "Authorization: Bearer [ACCESS_API_TOKEN]" \
     -H "Accept: application/json" -H "Content-type: application/json" \
     -X POST -d ' { "name": "test", "date_from": "19-02-2019", "date_to": "21-03-2019" }'
     http://localhost:3000/api/spectacles
```
Если спектакль успешно создан.
Ответ:
```
status: 200
{
    "spectacles": {
        "id": 7,
        "name": "test",
        "date_from": "2019-02-19",
        "date_to": "2019-03-21"
    }
}
```
Если выбранные даты уже заняты:
```
status: 400
{
    "errors": {
        "detail": "Period Spectacle exists."
    }
}
```
Если не передан один из обязательных параметров:
```
status: 400
{
    "errors": {
        "detail": "bad request"
    }
}
```

__3 Запрос на удаление спектакля__
```
DELETE /spectacles/:id

"Authorization: Bearer [ACCESS_API_TOKEN]"
```

Пример:
```
curl -H "Authorization: Bearer [ACCESS_API_TOKEN]" \
     -H "Accept: application/json" -H "Content-type: application/json" \
     -X DELETE -d ' {}'
     http://localhost:3000/api/spectacles/24
```
Если в системе не существует спектакля с переданным :id
Ответ:
```
status: 404
{
    "errors": {
        "detail": "not_found"
    }
}
```
Если удаление прошло успешно:
```
status: 200
{Was successfully destroyed.}
```
