SELECT * FROM VALUES
  ('pal_eqtype_PUMP-CENT', 'Centrifugal pump', 'Centrifugal pump', 'PUMP-CENT', 'PU', 'ISO14224', 'ISO 14224 class PU'),
  ('pal_eqtype_LUBE-UNIT', 'Lubrication unit', 'Lubrication unit', 'LUBE-UNIT', 'Lubrication system', 'ISO14224', 'ISO 14224 subunit Lubrication system')
AS t(externalId, name, description, code, equipmentClass, standard, standardReference)
