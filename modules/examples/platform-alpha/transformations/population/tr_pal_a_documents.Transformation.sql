-- Enrich existing CogniteFile nodes with PalDocument metadata from doc_register
SELECT
  existing.externalId as externalId,
  cast(d.`DOC_NO` as STRING) as documentNumber,
  cast(d.`DOC_TYPE` as STRING) as documentType,
  cast(d.`REV` as STRING) as revision,
  cast(d.`STATUS` as STRING) as documentStatus,
  to_timestamp(cast(d.`ISSUE_DATE` as STRING), 'yyyy-MM-dd') as issueDate,
  cast(d.`AUTHORITY` as STRING) as authority,
  cast(d.`APPLICABILITY` as STRING) as applicability,
  cast(d.`DISCIPLINE` as STRING) as discipline,
  cast(d.`TITLE` as STRING) as description,
  cast(d.`FILE_NAME` as STRING) as name
FROM `{{ rawSourceDatabase }}`.`doc_register` d
INNER JOIN cdf_data_models("cdf_cdm", "CogniteCore", "v1", "CogniteFile") as existing
  ON cast(d.`FILE_NAME` as STRING) = existing.name
WHERE existing.space = '{{ instanceSpace }}'
