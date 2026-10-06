SELECT
  concat('pal_order_', cast(`AUFNR` as STRING)) as externalId,
  array(node_reference('{{ instanceSpace }}', concat('pal_equip_', cast(`EQUNR` as STRING)))) as equipment
FROM `{{ rawSourceDatabase }}`.`sap_aufk`
WHERE isnotnull(`EQUNR`) AND cast(`EQUNR` as STRING) != ''
