Напишите запросы, которые вывели бы:
Наименования всех контрагентов, у которых имеется телефон (таблицы Contras  и Telct ) и поле Respondent пустое.
Наименования всех контрагентов и телефоны для тех из них, у которых он существует.
Наименование и количество указанных телефонов тех  контрагентов, у которых указано более одного телефона.
Наименования контрагентов, у которых не привязано ни одного телефона.

Запрос 1: Наименования всех контрагентов, у которых имеется телефон (таблицы Contras и Telct) и поле Respondent пустое

SELECT
    C.Nm_Ct
FROM
    Contras C
JOIN
    Telct T ON C.CodCt = T.CodCt
WHERE
    T.Respondent IS NULL;

Запрос 2: Наименования всех контрагентов и телефоны для тех из них, у которых он существует

SELECT
    C.Nm_Ct,
    T.TelNum
FROM
    Contras C
JOIN
    Telct T ON C.CodCt = T.CodCt;

Запрос 3: Наименование и количество указанных телефонов тех контрагентов, у которых указано более одного телефона

SELECT
    C.Nm_Ct,
    COUNT(T.TelNum) AS PhoneCount
FROM
    Contras C
JOIN
    Telct T ON C.CodCt = T.CodCt
GROUP BY
    C.Nm_Ct
HAVING
    COUNT(T.TelNum) > 1;

Запрос 4: Наименования контрагентов, у которых не привязано ни одного телефона

SELECT
    C.Nm_Ct
FROM
    Contras C
LEFT JOIN
    Telct T ON C.CodCt = T.CodCt
WHERE
    T.CodCt IS NULL;

