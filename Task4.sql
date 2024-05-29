Задание 4
Напишите запрос, который выведет номера всех документов, суммы которых больше 3000,
но меньше 6000 (Таблицы StkDocsGdsAndSrv  и StkDocs).

SELECT
    D.NumDoc
FROM
    StkDocsGdsAndSrv S
JOIN
    StkDocs D ON S.CodDoc = D.CodDoc
WHERE
    S.SummaGdSrv > 3000 AND S.SummaGdSrv < 6000;
