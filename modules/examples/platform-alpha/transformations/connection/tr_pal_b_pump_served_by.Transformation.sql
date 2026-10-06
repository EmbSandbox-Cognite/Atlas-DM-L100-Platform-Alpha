-- Indexed direct relation for fast pump-to-lube-unit navigation.
SELECT DISTINCT
  concat('pal_equip_', cast(eq_to.`EQUNR` as STRING)) as externalId,
  node_reference('{{ instanceSpace }}', concat('pal_equip_', cast(eq_from.`EQUNR` as STRING))) as servedByUnit
FROM `{{ rawSourceDatabase }}`.`pid_line_list` p
INNER JOIN `{{ rawSourceDatabase }}`.`sap_equi` eq_from
  ON cast(p.`FROM_TAG` as STRING) = cast(eq_from.`TIDNR` as STRING)
INNER JOIN `{{ rawSourceDatabase }}`.`sap_equi` eq_to
  ON cast(p.`TO_TAG` as STRING) = cast(eq_to.`TIDNR` as STRING)
WHERE cast(eq_to.`EQART` as STRING) = 'PUMP-CENT'
