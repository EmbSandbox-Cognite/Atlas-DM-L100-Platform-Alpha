-- Document appliesTo via tag lookup (semicolon-separated APPLIES_TO_TAGS)
WITH unique_documents AS (
  SELECT DISTINCT
    cast(`FILE_NAME` as STRING) as FILE_NAME,
    cast(`APPLIES_TO_TAGS` as STRING) as APPLIES_TO_TAGS
  FROM `{{ rawSourceDatabase }}`.`doc_register`
),
expanded_documents AS (
  SELECT
    d.FILE_NAME,
    trim(tag) as equipmentTag
  FROM unique_documents d
  LATERAL VIEW explode(split(d.APPLIES_TO_TAGS, ';')) t AS tag
)
SELECT
  existing.externalId as externalId,
  collect_list(DISTINCT node_reference('{{ instanceSpace }}', concat('pal_equip_', cast(e.`EQUNR` as STRING)))) as appliesTo
FROM expanded_documents d
INNER JOIN cdf_data_models("cdf_cdm", "CogniteCore", "v1", "CogniteFile") as existing
  ON cast(d.`FILE_NAME` as STRING) = existing.name
INNER JOIN `{{ rawSourceDatabase }}`.`sap_equi` e
  ON d.equipmentTag = cast(e.`TIDNR` as STRING)
WHERE existing.space = '{{ instanceSpace }}'
GROUP BY existing.externalId
