IF((SELECT COUNT(*) FROM icustom2) = 0)
	BEGIN
		INSERT INTO icustom2(Custom, CustomKey, Active)	VALUES ('Fall', 'FL',1)	
		INSERT INTO icustom2(Custom, CustomKey, Active)	VALUES ('Summer', 'SU',1)	
		INSERT INTO icustom2(Custom, CustomKey, Active)	VALUES ('Spring', 'SP',1)	
		INSERT INTO icustom2(Custom, CustomKey, Active)	VALUES ('Core', 'CO',1)
		INSERT INTO icustom2(Custom, CustomKey, Active)	VALUES ('Holiday', 'HO',1)
	END
	
	GO


INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES     ('DB_Version', '4.1.0000', '01542', GetDate())
GO