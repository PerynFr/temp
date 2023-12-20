На тестовом сервере smsk02db56u делаю запрос через OPENQUERY в таблицу
Запрос
INSERT OPENQUERY(VTB_KK, 'select UF_NAME, UF_FILE, UF_XML_ID from vtb_kk.vtb_product_document') VALUES ('Правила фонда', 5394,'pdu_urk_26')
Три параметра должны вставить, но в результате первое NULL
