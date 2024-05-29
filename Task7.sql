Задание 7
Напишите запрос, который сосчитал бы всю сумму поля SummaGdSrv на 01 июня 2005 года (поле DateWr таблицы StkDocs)
из таблиц StkDocs и StkDocsGdsAndSrv тех документов, которые созданы пользователями LOBUC и  DES.

SELECT
    SUM(SGS.SummaGdSrv) AS TotalSum
FROM
    StkDocs SD
JOIN
    StkDocsGdsAndSrv SGS ON SD.CodDoc = SGS.CodDoc
WHERE
    SD.Creator IN ('LOBUC', 'DES')
    AND SD.DateWrt = TO_DATE('2005-06-01', 'YYYY-MM-DD');
