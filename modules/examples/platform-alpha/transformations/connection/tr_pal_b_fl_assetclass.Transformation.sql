-- FL → assetClass
SELECT
  concat('pal_fl_', cast(`TPLNR` as STRING)) as externalId,
  node_reference('{{ instanceSpace }}',
    case
      when cast(`TPLNR` as STRING) = 'PAL' then 'pal_assetclass_Site'
      when cast(`TPLNR` as STRING) = 'PAL-M20' then 'pal_assetclass_Area'
      when cast(`TPLNR` as STRING) = 'PAL-M20-50' then 'pal_assetclass_System'
      else 'pal_assetclass_EquipmentPosition'
    end
  ) as assetClass
FROM `{{ rawSourceDatabase }}`.`sap_iflot`
WHERE isnotnull(`TPLNR`)
