-----------------------------------
-- Name: Kyle Russell
-- ID: 13831056
-- Physical database design
-----------------------------------

-- Updates the despatch desp_num's quantity to the new_quant quantity
-- Checks for bad input such that quantity cannot be negative or exceed max

CREATE OR REPLACE PROCEDURE updateDispStock (desp_num NUMBER, new_quant NUMBER)
IS
	e_disp_notfound		EXCEPTION;
	e_exceed_max		EXCEPTION;
	e_negative_quant	EXCEPTION;

	v_max_quant			NUMBER;

	CURSOR disp_cursor IS
	SELECT * FROM Despatch
	WHERE Desp_id = desp_num;

BEGIN
	
	OPEN disp_cursor;
	IF(disp_cursor%NOTFOUND)
		THEN RAISE e_disp_notfound;
	END IF;

	v_max_quant	:=	1000;

	-- Check for bad quantity
	-- Cannot have negative quantity
	-- Quantity cannot exceed max
	IF new_quant > v_max_quant
		THEN RAISE e_exceed_max;
	ELSIF new_quant < 0
		THEN RAISE e_negative_quant;
	END IF;
	
	UPDATE Despatch
	SET Quantity = new_quant
	WHERE Desp_id = desp_num;

	EXCEPTION
		WHEN e_disp_notfound
		THEN dbms_output.put_line('Dispatch was not found');

		WHEN e_exceed_max
		THEN dbms_output.put_line('New quantity exceeds maximum quantity');

		WHEN e_negative_quant
		THEN dbms_output.put_line('Quantity cannot be negative');

		CLOSE disp_cursor;
END;
/
