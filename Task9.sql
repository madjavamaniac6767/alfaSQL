К любому документу могут быть привязаны определенные аналитические признаки – элементы пользовательских справочников (таблицы StkDocsRef и RefItem). Напишите следующие запросы:
Запрос, который выведет для всех документов, привязанные к ним аналитические признаки в виде следующей таблицы со столбцами
Номер Документа, Дата Документа, Наименование документа, Наименование значения

Запрос, который выведет все документы, имеющие аналитический признак «Розничные продажи» по справочнику «Вид реализации».
Запрос, который вывел бы количество документов, имеющих аналитический признак по справочнику «Статус документа» и количество документов, не имеющих такого признака.
Запрос, выводящий список ВСЕХ (как имеющих аналитический признак, так и не имеющих) документов с наименованием привязанной аналитики для тех документов, у которых есть аналитический признак по справочнику «Вид реализации». Выводить привязанные значения по другим аналитическим справочникам ненужно.
Дополнения
Один справочник может быть привязан к одному документу только один раз.

Запрос 1: Вывести для всех документов привязанные к ним аналитические признаки

SELECT
    SD.NumDoc AS "Номер Документа",
    SD.DateWrt AS "Дата Документа",
    SD.NmDoc AS "Наименование документа",
    RI.NmInRef AS "Наименование значения"
FROM
    StkDocs SD
LEFT JOIN
    StkDocsRef SDR ON SD.CodDoc = SDR.CodDoc
LEFT JOIN
    RefItem RI ON SDR.CodInRef = RI.CodInRef;

Запрос 2: Вывести все документы, имеющие аналитический признак «Розничные продажи» по справочнику «Вид реализации»

SELECT
    SD.NumDoc,
    SD.DateWrt,
    SD.NmDoc,
    RI.NmInRef AS "Аналитический признак"
FROM
    StkDocs SD
JOIN
    StkDocsRef SDR ON SD.CodDoc = SDR.CodDoc
JOIN
    RefItem RI ON SDR.CodInRef = RI.CodInRef
JOIN
    Refs R ON SDR.CodRef = R.CodRef
WHERE
    R.NmRef = 'Вид реализации'
    AND RI.NmInRef = 'Розничные продажи';

Запрос 3: Вывести количество документов с аналитическим признаком и количество документов без него по справочнику «Статус документа»

SELECT
    CASE WHEN SDR.CodRef IS NOT NULL THEN 'С признаком' ELSE 'Без признака' END AS "Статус документа",
    COUNT(*) AS "Количество документов"
FROM
    StkDocs SD
LEFT JOIN
    StkDocsRef SDR ON SD.CodDoc = SDR.CodDoc AND SDR.CodRef = (SELECT CodRef FROM Refs WHERE NmRef = 'Статус документа')
GROUP BY
    CASE WHEN SDR.CodRef IS NOT NULL THEN 'С признаком' ELSE 'Без признака' END;

Запрос 4: Вывести список ВСЕХ документов с привязанными аналитическими признаками по справочнику «Вид реализации»

SELECT
    SD.NumDoc AS "Номер Документа",
    SD.DateWrt AS "Дата Документа",
    SD.NmDoc AS "Наименование документа",
    RI.NmInRef AS "Аналитический признак"
FROM
    StkDocs SD
LEFT JOIN
    StkDocsRef SDR ON SD.CodDoc = SDR.CodDoc
LEFT JOIN
    RefItem RI ON SDR.CodInRef = RI.CodInRef
LEFT JOIN
    Refs R ON SDR.CodRef = R.CodRef AND R.NmRef = 'Вид реализации';




