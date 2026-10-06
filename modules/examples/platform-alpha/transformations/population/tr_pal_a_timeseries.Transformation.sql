SELECT
  cast(`EXTERNAL_ID` as STRING) as externalId,
  cast(`EXTERNAL_ID` as STRING) as name,
  cast(`DESCRIPTION` as STRING) as description,
  cast(`EXTERNAL_ID` as STRING) as sourceId,
  'numeric' as type,
  false as isStep,
  cast(`UNIT` as STRING) as sourceUnit,
  if(try_get_unit(cast(`UNIT` as STRING)) IS NOT NULL,
     node_reference('cdf_cdm_units', try_get_unit(cast(`UNIT` as STRING))),
     NULL) as unit,
  'Time Series' as sourceContext
FROM `{{ rawSourceDatabase }}`.`ts_register`
WHERE isnotnull(`EXTERNAL_ID`)
