Задание 3
Напишите запрос, который может дать вам все записи со значениями суммы в поле
SummaGdSrv  больше чем 1,500.( таблица StkDocsGdsAndSrv ).

SELECT
    *
FROM
    StkDocsGdsAndSrv
WHERE
    SummaGdSrv > 1500;
