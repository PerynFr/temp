На тестовом сервере smsk02db56u делаю запрос через OPENQUERY в таблицу
Запрос
INSERT OPENQUERY(VTB_KK, 'select UF_NAME, UF_FILE, UF_XML_ID from vtb_kk.vtb_product_document') VALUES ('Правила фонда', 5394,'pdu_urk_26')
Три параметра должны вставить, но в результате первое NULL


нужно использовать SELECT с INSERT INTO, а не INSERT с SELECT. Ваш текущий запрос пытается вставить результаты запроса в таблицу, а не вставить значения из запроса.

Вот правильный запрос:

sql
Скопировать

INSERT INTO [your_table] (UF_NAME, UF_FILE, UF_XML_ID)
SELECT UF_NAME, UF_FILE, UF_XML_ID 
FROM OPENQUERY(VTB_KK, 'SELECT UF_NAME, UF_FILE, UF_XML_ID FROM vtb_kk.vtb_product_document')
WHERE [your_condition]
