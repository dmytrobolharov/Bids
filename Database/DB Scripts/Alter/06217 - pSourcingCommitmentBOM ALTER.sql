IF NOT EXISTS (select * from INFORMATION_SCHEMA.COLUMNS where TABLE_NAME = N'pSourcingCommitmentBOM'
and COLUMN_NAME = N'NotShow'
)
BEGIN
      ALTER TABLE pSourcingCommitmentBOM ADD  NotShow int NULL default 0
END
GO

INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES ('DB_Version', '0.5.0000', '06217', GetDate())
GO