Создайте таблицу AlfaAudit со столбцами:
NumID(Number not null, Номер записи),
TriggerName(VARCHAR2(30), Название триггера),
CodGdSrv(VARCHAR2(2000), Код товара (GdsAndSrv)),
DbUser(VARCHAR2(30,) польователь Oracle, выполнящий изменение поля PrcGdSrv в таблице Stkdocsgdsandsrv),
DateChange(DATE, Дата изменения поля PrcGdSrv в таблице Stkdocsgdsandsr),
OldPrice(Number not null, Старое значение поля PrcGdSrv в таблице Stkdocsgdsandsrv),
NewPrice(Number not null, Новое значение поля PrcGdSrv в таблице Stkdocsgdsandsrv)
Создайте триггер, который при изменении значение поля SummaGdSrv из таблицы StkDocsGdsAndSrv заполнял поля таблицы AlfaAudit в соответствие с описанием полей таблицы AlfaAudit.

Создание таблицы AlfaAudit:

CREATE TABLE AlfaAudit (
    NumID SERIAL PRIMARY KEY,
    TriggerName VARCHAR2(30),
    CodGdSrv VARCHAR2(2000),
    DbUser VARCHAR2(30),
    DateChange DATE,
    OldPrice NUMBER NOT NULL,
    NewPrice NUMBER NOT NULL
);

Создание триггера:

CREATE OR REPLACE FUNCTION audit_stkdocsgdsandsrv()
RETURNS TRIGGER AS $$
BEGIN
    IF TG_OP = 'UPDATE' THEN
        INSERT INTO AlfaAudit (TriggerName, CodGdSrv, DbUser, DateChange, OldPrice, NewPrice)
        VALUES ('StkDocsGdsAndSrv_UPDATE', NEW.CodGdsRv, current_user, current_date, OLD.SummaGdSrv, NEW.SummaGdSrv);
    END IF;
    RETURN NEW;
END;
$$ LANGUAGE plpgsql;

CREATE TRIGGER trg_audit_stkdocsgdsandsrv
AFTER UPDATE OF SummaGdSrv ON StkDocsGdsAndSrv
FOR EACH ROW
EXECUTE FUNCTION audit_stkdocsgdsandsrv();
