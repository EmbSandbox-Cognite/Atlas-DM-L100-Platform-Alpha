SELECT
  concat('pal_order_', cast(`AUFNR` as STRING)) as externalId,
  cast(`AUFNR` as STRING) as name,
  cast(`KTEXT` as STRING) as description,
  cast(`AUFNR` as STRING) as sapOrderNumber,
  cast(`AUART` as STRING) as orderType,
  cast(`STAT` as STRING) as status,
  cast(`KTEXT` as STRING) as operationsText,
  cast(`MATNR_TXT` as STRING) as materialUsed,
  to_timestamp(cast(`GSTRP` as STRING), 'yyyy-MM-dd') as startTime,
  to_timestamp(cast(`GLTRP` as STRING), 'yyyy-MM-dd') as endTime
FROM `{{ rawSourceDatabase }}`.`sap_aufk`
WHERE isnotnull(`AUFNR`)
