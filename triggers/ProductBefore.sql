CREATE OR REPLACE TRIGGER ProductBefore
BEFORE INSERT ON Product
FOR EACH ROW

DECLARE
v_shelf_row			NUMBER(5);
v_shelf_isle		NUMBER(5);
v_shelf_index		NUMBER(5);
v_shelfLoc			Despatch.ShelfLoc%TYPE;
v_shelfCount		NUMBER(5);

v_min_disp_quant	NUMBER(5);
v_max_disp_quant	NUMBER(5);
v_disp_quant	NUMBER(5);

BEGIN

LOOP
	-- Generate shelf row
	SELECT dbms_random.value(0, 9)
	INTO v_shelf_row
	FROM dual;

	-- Generate shelf isle
	SELECT dbms_random.value(0, 9)
	INTO v_shelf_isle
	FROM dual;

	-- Generate shelf col
	SELECT dbms_random.value(0, 99)
	INTO v_shelf_index
	FROM dual;

	v_shelfLoc := ''|| v_shelf_isle || 'R' || v_shelf_row || 'C';

	IF v_shelf_index < 10 THEN 
		v_shelfLoc := v_shelfLoc || '0' || v_shelf_index;
	ELSE
		v_shelfLoc := v_shelfLoc || v_shelf_index;
	END IF;
	
	SELECT count(*)
	INTO v_shelfCount
	FROM Despatch
	WHERE ShelfLoc = v_shelfLoc;
	
	EXIT WHEN v_shelfCount = 0;
END LOOP;

v_min_disp_quant	:=	1;
v_max_disp_quant	:=	:new.QOH;

SELECT dbms_random.value(v_min_disp_quant, v_max_disp_quant)
INTO v_disp_quant
FROM dual;

:new.QOH :=	(:new.QOH - v_disp_quant);

INSERT INTO Despatch (Prod_name, ShelfLoc, Quantity)
VALUES
(
	:new.Prod_name,
	v_shelfLoc,
	v_disp_quant
);

END;
/
