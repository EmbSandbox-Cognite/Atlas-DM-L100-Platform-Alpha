-- Pass A: pumps from sap_equi + pivoted sap_equi_char
SELECT
  concat('pal_equip_', cast(e.`EQUNR` as STRING)) as externalId,
  cast(e.`TIDNR` as STRING) as name,
  cast(e.`EQKTX` as STRING) as description,
  cast(e.`EQUNR` as STRING) as sapEquipmentNumber,
  cast(e.`TIDNR` as STRING) as tag,
  cast(e.`EQTYP` as STRING) as equipmentCategory,
  cast(e.`EQART` as STRING) as objectType,
  cast(e.`HERST` as STRING) as manufacturer,
  cast(e.`TYPBZ` as STRING) as modelFamily,
  cast(e.`SERGE` as STRING) as serialNumber,
  to_timestamp(cast(e.`INBDT` as STRING), 'yyyy-MM-dd') as startupDate,
  cast(c.`RATED_FLOW_M3H` as DOUBLE) as ratedFlowM3h,
  cast(c.`RATED_POWER_KW` as DOUBLE) as ratedPowerKw,
  cast(c.`BEARING_ARRANGEMENT` as INT) as bearingArrangement,
  cast(c.`DUTY_ROLE` as STRING) as dutyRole,
  cast(c.`CRITICALITY` as STRING) as criticality,
  cast(e.`SWERK` as STRING) as maintenancePlant,
  cast(e.`ARBPL` as STRING) as workCenter,
  cast(e.`INGRP` as STRING) as plannerGroup
FROM `{{ rawSourceDatabase }}`.`sap_equi` e
LEFT JOIN (
  SELECT
    `EQUNR`,
    max(case when `ATNAM` = 'BEARING_ARRANGEMENT' then `ATWRT` end) as BEARING_ARRANGEMENT,
    max(case when `ATNAM` = 'DUTY_ROLE' then `ATWRT` end) as DUTY_ROLE,
    max(case when `ATNAM` = 'RATED_FLOW_M3H' then `ATWRT` end) as RATED_FLOW_M3H,
    max(case when `ATNAM` = 'RATED_POWER_KW' then `ATWRT` end) as RATED_POWER_KW,
    max(case when `ATNAM` = 'CRITICALITY' then `ATWRT` end) as CRITICALITY
  FROM `{{ rawSourceDatabase }}`.`sap_equi_char`
  GROUP BY `EQUNR`
) c ON cast(e.`EQUNR` as STRING) = cast(c.`EQUNR` as STRING)
WHERE cast(e.`EQART` as STRING) = 'PUMP-CENT'
