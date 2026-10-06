-- Pass A: lube oil unit
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
  cast(c.`OIL_GRADE` as STRING) as oilGrade,
  cast(c.`RESERVOIR_VOLUME_L` as DOUBLE) as reservoirVolumeL,
  cast(c.`CRITICALITY` as STRING) as criticality,
  cast(e.`SWERK` as STRING) as maintenancePlant,
  cast(e.`ARBPL` as STRING) as workCenter,
  cast(e.`INGRP` as STRING) as plannerGroup
FROM `{{ rawSourceDatabase }}`.`sap_equi` e
LEFT JOIN (
  SELECT
    `EQUNR`,
    max(case when `ATNAM` = 'OIL_GRADE' then `ATWRT` end) as OIL_GRADE,
    max(case when `ATNAM` = 'RESERVOIR_VOLUME_L' then `ATWRT` end) as RESERVOIR_VOLUME_L,
    max(case when `ATNAM` = 'CRITICALITY' then `ATWRT` end) as CRITICALITY
  FROM `{{ rawSourceDatabase }}`.`sap_equi_char`
  GROUP BY `EQUNR`
) c ON cast(e.`EQUNR` as STRING) = cast(c.`EQUNR` as STRING)
WHERE cast(e.`EQART` as STRING) = 'LUBE-UNIT'
