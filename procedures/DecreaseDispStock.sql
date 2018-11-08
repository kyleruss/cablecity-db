-----------------------------------
-- Name: Kyle Russell
-- ID: 13831056
-- Physical database design
-----------------------------------

-- Decreases the despatch desp_num's stock by num_units
-- Checking for bad quantity is done in UpdateDispStock

CREATE OR REPLACE PROCEDURE decreaseDispStock (desp_num NUMBER, num_units NUMBER)
IS

	e_disp_notfound		EXCEPTION;

	CURSOR disp_cursor IS
	SELECT * FROM Despatch
	WHERE Desp_id = desp_num;

	r_disp_row			disp_cursor%ROWTYPE;
	v_next_quant		Despatch.Quantity%TYPE;

BEGIN
	OPEN disp_cursor;
	IF(disp_cursor%NOTFOUND)
		THEN RAISE e_disp_notfound;
	ELSE
		FETCH disp_cursor INTO r_disp_row;
	END IF;

	v_next_quant := v_next_quant - num_units;

	-- Update the despatch stock with the decremented stock
	UpdateDispStock(desp_num, v_next_quant);

	EXCEPTION
		WHEN e_disp_notfound
		THEN dbms_output.put_line('Dispatch was not found');

	CLOSE disp_cursor;
END;
/
