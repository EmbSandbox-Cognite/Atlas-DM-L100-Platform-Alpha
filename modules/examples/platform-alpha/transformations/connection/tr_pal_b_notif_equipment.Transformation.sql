SELECT
  concat('pal_notif_', cast(`QMNUM` as STRING)) as externalId,
  array(node_reference('{{ instanceSpace }}', concat('pal_equip_', cast(`EQUNR` as STRING)))) as equipment
FROM `{{ rawSourceDatabase }}`.`sap_qmel`
WHERE isnotnull(`EQUNR`) AND cast(`EQUNR` as STRING) != ''
