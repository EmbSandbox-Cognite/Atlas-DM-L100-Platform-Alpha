SELECT
  concat('pal_fl_', cast(`TPLNR` as STRING)) as externalId,
  node_reference('{{ instanceSpace }}', concat('pal_fl_', cast(`TPLMA` as STRING))) as parent
FROM `{{ rawSourceDatabase }}`.`sap_iflot`
WHERE isnotnull(`TPLMA`) AND cast(`TPLMA` as STRING) != ''
