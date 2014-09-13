IF NOT EXISTS(SELECT COLUMN_NAME FROM INFORMATION_SCHEMA.COLUMNS 
				WHERE TABLE_NAME='pLineFolderFinancial' AND COLUMN_NAME='Active')
BEGIN
	ALTER TABLE pLineFolderFinancial ADD Active INT DEFAULT 1
END

IF NOT EXISTS(SELECT COLUMN_NAME FROM INFORMATION_SCHEMA.COLUMNS 
				WHERE TABLE_NAME='pLineFolderFinancial' AND COLUMN_NAME='Editable')
BEGIN
	ALTER TABLE pLineFolderFinancial ADD Editable INT DEFAULT 0
END

DELETE FROM pLineFolderFinancial

GO

INSERT INTO pLineFolderFinancial(LineFolderFinancialID, LineFolderFinancialDataType, LineFolderFinancialDataFormat, 
				LineFolderFinancialCssClass, LineFolderFinancialText, LineFolderFinancialSort, Active, Editable)
VALUES ('10000000-0000-0000-0000-000000000000', 'decimal', '0', 'fontHead', 'Number of Styles', '0000', 1, 1)

INSERT INTO pLineFolderFinancial(LineFolderFinancialID, LineFolderFinancialDataType, LineFolderFinancialDataFormat, 
				LineFolderFinancialCssClass, LineFolderFinancialText, LineFolderFinancialSort, Active, Editable)
VALUES ('10000000-0000-0000-0000-000000000001', 'decimal', '0', 'fontHead', 'Number of Carry Over Styles', '0001', 1, 1)

INSERT INTO pLineFolderFinancial(LineFolderFinancialID, LineFolderFinancialDataType, LineFolderFinancialDataFormat, 
				LineFolderFinancialCssClass, LineFolderFinancialText, LineFolderFinancialSort, Active, Editable)
VALUES ('10000000-0000-0000-0000-000000000002', 'decimal', '0', 'fontHead', 'Number of Fabrics', '0002', 0, 1)

INSERT INTO pLineFolderFinancial(LineFolderFinancialID, LineFolderFinancialDataType, LineFolderFinancialDataFormat, 
				LineFolderFinancialCssClass, LineFolderFinancialText, LineFolderFinancialSort, Active, Editable)
VALUES ('10000000-0000-0000-0000-000000000003', 'decimal', '0', 'fontHead', 'Number of Colorways', '0003', 0, 1)

INSERT INTO pLineFolderFinancial(LineFolderFinancialID, LineFolderFinancialDataType, LineFolderFinancialDataFormat, 
				LineFolderFinancialCssClass, LineFolderFinancialText, LineFolderFinancialSort, Active, Editable)
VALUES ('10000000-0000-0000-0000-000000000004', 'decimal', '0', 'font', 'Wholesale Units', '0004', 1, 1)

INSERT INTO pLineFolderFinancial(LineFolderFinancialID, LineFolderFinancialDataType, LineFolderFinancialDataFormat, 
				LineFolderFinancialCssClass, LineFolderFinancialText, LineFolderFinancialSort, Active, Editable)
VALUES ('10000000-0000-0000-0000-000000000005', 'decimal', '0', 'font', 'Retail Units', '0005', 1, 1)

INSERT INTO pLineFolderFinancial(LineFolderFinancialID, LineFolderFinancialDataType, LineFolderFinancialDataFormat, 
				LineFolderFinancialCssClass, LineFolderFinancialText, LineFolderFinancialSort, Active, Editable)
VALUES ('10000000-0000-0000-0000-000000000006', 'decimal', '0.00', 'fontRed', 'Avg Cost / Unit', '0006', 1, 1)

INSERT INTO pLineFolderFinancial(LineFolderFinancialID, LineFolderFinancialDataType, LineFolderFinancialDataFormat, 
				LineFolderFinancialCssClass, LineFolderFinancialText, LineFolderFinancialSort, Active, Editable)
VALUES ('10000000-0000-0000-0000-000000000007', 'decimal', '0.00', 'fontRed', 'Avg Wholesale Price / Unit', '0007', 1, 1)

INSERT INTO pLineFolderFinancial(LineFolderFinancialID, LineFolderFinancialDataType, LineFolderFinancialDataFormat, 
				LineFolderFinancialCssClass, LineFolderFinancialText, LineFolderFinancialSort, Active, Editable)
VALUES ('10000000-0000-0000-0000-000000000008', 'decimal', '0.00', 'fontRed', 'Avg Retail Price / Unit', '0008', 1, 1)

INSERT INTO pLineFolderFinancial(LineFolderFinancialID, LineFolderFinancialDataType, LineFolderFinancialDataFormat, 
				LineFolderFinancialCssClass, LineFolderFinancialText, LineFolderFinancialSort, Active, Editable)
VALUES ('10000000-0000-0000-0000-000000000009', 'decimal', '0.00', 'fontRed', 'Extended Wholesale', '0009', 1, 0)

INSERT INTO pLineFolderFinancial(LineFolderFinancialID, LineFolderFinancialDataType, LineFolderFinancialDataFormat, 
				LineFolderFinancialCssClass, LineFolderFinancialText, LineFolderFinancialSort, Active, Editable)
VALUES ('10000000-0000-0000-0000-000000000010', 'decimal', '0.00', 'fontRed', 'Extended Retail', '0010', 1, 0)

INSERT INTO pLineFolderFinancial(LineFolderFinancialID, LineFolderFinancialDataType, LineFolderFinancialDataFormat, 
				LineFolderFinancialCssClass, LineFolderFinancialText, LineFolderFinancialSort, Active, Editable)
VALUES ('10000000-0000-0000-0000-000000000011', 'decimal', '0.00', 'fontRed', 'Extended Cost', '0011', 1, 0)

INSERT INTO pLineFolderFinancial(LineFolderFinancialID, LineFolderFinancialDataType, LineFolderFinancialDataFormat, 
				LineFolderFinancialCssClass, LineFolderFinancialText, LineFolderFinancialSort, Active, Editable)
VALUES ('10000000-0000-0000-0000-000000000012', 'percent', '{0:p}', 'font', 'Gross Margin WHS %', '0012', 1, 0)

INSERT INTO pLineFolderFinancial(LineFolderFinancialID, LineFolderFinancialDataType, LineFolderFinancialDataFormat, 
				LineFolderFinancialCssClass, LineFolderFinancialText, LineFolderFinancialSort, Active, Editable)
VALUES ('10000000-0000-0000-0000-000000000013', 'percent', '{0:p}', 'font', 'Gross Margin Retail %', '0013', 1, 0)

GO

INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES ('DB_Version', '0.5.0000', '05361', GetDate())
GO
