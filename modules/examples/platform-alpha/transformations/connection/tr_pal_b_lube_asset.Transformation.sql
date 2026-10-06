SELECT
  concat('pal_equip_', cast(`EQUNR` as STRING)) as externalId,
  node_reference('{{ instanceSpace }}', concat('pal_fl_', cast(`TPLNR` as STRING))) as asset,
  node_reference('{{ instanceSpace }}', 'pal_eqtype_LUBE-UNIT') as equipmentType
FROM `{{ rawSourceDatabase }}`.`sap_equi`
WHERE cast(`EQART` as STRING) = 'LUBE-UNIT'
