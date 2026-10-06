-- Reference asset classes (inline)
SELECT * FROM VALUES
  ('pal_assetclass_Site', 'Site', 'Site / Installation', 'Site', 'ISO14224'),
  ('pal_assetclass_Area', 'Area', 'Area / Plant section', 'Area', 'ISO14224'),
  ('pal_assetclass_System', 'System', 'System', 'System', 'ISO14224'),
  ('pal_assetclass_EquipmentPosition', 'Equipment position', 'Equipment position', 'EquipmentPosition', 'ISO14224')
AS t(externalId, name, description, code, standard)
