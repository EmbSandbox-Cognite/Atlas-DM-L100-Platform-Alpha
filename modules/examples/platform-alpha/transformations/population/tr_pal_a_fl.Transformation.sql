-- Pass A: functional locations from sap_iflot
SELECT
  concat('pal_fl_', cast(`TPLNR` as STRING)) as externalId,
  cast(`TPLNR` as STRING) as name,
  cast(`PLTXT` as STRING) as description,
  cast(`TPLNR` as STRING) as sapFunctionalLocation,
  case
    when cast(`TPLNR` as STRING) = 'PAL' then 1
    when cast(`TPLNR` as STRING) = 'PAL-M20' then 2
    when cast(`TPLNR` as STRING) = 'PAL-M20-50' then 3
    else 4
  end as structureLevel,
  case
    when cast(`TPLNR` as STRING) = 'PAL' then 'Site'
    when cast(`TPLNR` as STRING) = 'PAL-M20' then 'Area'
    when cast(`TPLNR` as STRING) = 'PAL-M20-50' then 'System'
    else 'Equipment position'
  end as levelType,
  case
    when cast(`TPLNR` as STRING) = 'PAL' then 'L3'
    when cast(`TPLNR` as STRING) = 'PAL-M20' then 'L4'
    when cast(`TPLNR` as STRING) = 'PAL-M20-50' then 'L5'
    else 'L6'
  end as iso14224Level,
  cast(`FLTYP` as STRING) as flCategory,
  cast(`SWERK` as STRING) as maintenancePlant,
  cast(`IWERK` as STRING) as planningPlant,
  cast(`STORT` as STRING) as location,
  cast(`BEBER` as STRING) as plantSection,
  cast(`ARBPL` as STRING) as workCenter,
  cast(`INGRP` as STRING) as plannerGroup,
  cast(`KOSTL` as STRING) as costCenter,
  cast(`BUKRS` as STRING) as companyCode
FROM `{{ rawSourceDatabase }}`.`sap_iflot`
WHERE isnotnull(`TPLNR`)
