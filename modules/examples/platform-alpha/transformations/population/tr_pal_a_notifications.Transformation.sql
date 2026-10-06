SELECT
  concat('pal_notif_', cast(`QMNUM` as STRING)) as externalId,
  cast(`QMNUM` as STRING) as name,
  cast(`QMTXT` as STRING) as description,
  cast(`QMNUM` as STRING) as sapNotificationNumber,
  cast(`QMART` as STRING) as notificationType,
  cast(`PRIOK` as STRING) as priority,
  cast(`OTEIL` as STRING) as objectPart,
  cast(`FECOD` as STRING) as damageCode,
  cast(`URCOD` as STRING) as causeCode,
  cast(`STAT` as STRING) as status,
  to_timestamp(cast(`QMDAT` as STRING), 'yyyy-MM-dd') as reportedDate,
  to_timestamp(cast(`QMDAT` as STRING), 'yyyy-MM-dd') as startTime
FROM `{{ rawSourceDatabase }}`.`sap_qmel`
WHERE isnotnull(`QMNUM`)
