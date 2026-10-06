SELECT
  cast(t.`EXTERNAL_ID` as STRING) as externalId,
  'numeric' as type,
  false as isStep,
  array(node_reference('{{ instanceSpace }}', concat('pal_equip_', cast(t.`EQUNR` as STRING)))) as equipment
FROM `{{ rawSourceDatabase }}`.`ts_register` t
WHERE isnotnull(t.`EQUNR`)
