-- servedBy edges: pump (TO_TAG) served by LO unit (FROM_TAG)
SELECT DISTINCT
  concat('pal_edge_servedBy_', cast(p.`LINE_NO` as STRING)) as externalId,
  type_reference('{{ schemaSpace }}', 'servedBy') as type,
  node_reference('{{ instanceSpace }}', concat('pal_equip_', cast(eq_to.`EQUNR` as STRING))) as startNode,
  node_reference('{{ instanceSpace }}', concat('pal_equip_', cast(eq_from.`EQUNR` as STRING))) as endNode,
  cast(p.`LINE_NO` as STRING) as lineNumber
FROM `{{ rawSourceDatabase }}`.`pid_line_list` p
INNER JOIN `{{ rawSourceDatabase }}`.`sap_equi` eq_from
  ON cast(p.`FROM_TAG` as STRING) = cast(eq_from.`TIDNR` as STRING)
INNER JOIN `{{ rawSourceDatabase }}`.`sap_equi` eq_to
  ON cast(p.`TO_TAG` as STRING) = cast(eq_to.`TIDNR` as STRING)
WHERE cast(eq_to.`EQART` as STRING) = 'PUMP-CENT'
