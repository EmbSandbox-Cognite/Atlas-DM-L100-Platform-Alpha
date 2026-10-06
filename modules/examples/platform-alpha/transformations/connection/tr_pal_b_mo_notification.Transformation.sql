SELECT
  concat('pal_order_', cast(`AUFNR` as STRING)) as externalId,
  node_reference('{{ instanceSpace }}', concat('pal_notif_', cast(`QMNUM` as STRING))) as notification
FROM `{{ rawSourceDatabase }}`.`sap_aufk`
WHERE isnotnull(`QMNUM`) AND cast(`QMNUM` as STRING) != ''
