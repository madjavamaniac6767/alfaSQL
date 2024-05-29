Задание 8
Напишите запрос, который вывел бы по каждому товару его остаток на складе (Таблица StkDocsGdsAndSrv) на дату 01 июня 2005 г. (поле DateWrt таблицы StkDocs).
Дополнения:
Остаток должен быть получен одним запросом, по возможности без подзапросов.
Поле FlagInOut в таблице StkDocs – направленность документа:
0 – приходный документ.
1 – расходный документ.
Поле Type таблицы GdsAndSrv – тип элемента:
0 – товар;
1 – услуга.

WITH Inventory AS (
    SELECT
        CodGdsRv,
        SUM(CASE WHEN FlagInOut = 0 THEN QtyGdSrv ELSE -QtyGdSrv END) OVER (PARTITION BY CodGdsRv ORDER BY DateWrt) AS Stock
    FROM
        StkDocsGdsAndSrv
    JOIN
        StkDocs ON StkDocs.CodDoc = StkDocsGdsAndSrv.CodDoc
    WHERE
        StkDocs.DateWrt <= TO_DATE('2005-06-01', 'YYYY-MM-DD')
)
SELECT
    I.CodGdsRv,
    G.NmGdSrv AS ProductName,
    G.Type AS ProductType,
    I.Stock AS StockOnDate
FROM
    Inventory I
JOIN
    GdsAndSrv G ON I.CodGdsRv = G.CodGdSrv;
