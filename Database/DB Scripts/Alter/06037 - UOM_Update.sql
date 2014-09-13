UPDATE pMaterial SET UOM = u.UOM 
FROM pMaterial m
INNER JOIN UOM u ON m.UOM = u.UOMValue
WHERE u.UOM IN ('Gross', 'Each', 'Dozen')

UPDATE UOM SET UOMValue = UOM WHERE UOM IN ('Gross', 'Each', 'Dozen')
GO

INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES ('DB_Version', '0.5.0000', '06037', GetDate())
GO
