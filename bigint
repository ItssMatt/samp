/*
	BigInt by Matt
	- Nu adaugati mai mult de 999,999,999 deodata. (AddBigInt)
	- Pentru a adauga mai mult de 999,999,999 deodata, folositi AddBigIntToBigInt!
	- Este foarte important sa verificati inainte sa scadeti din bigint, altfel ajunge pe minus si o sa aveti probleme!

	AddBigInt(=variabila care stocheaza numarul miliardelor=, =variabila care stocheaza restul cifrelor=, =suma de adaugat=);			= adaugi (returneaza 1 daca s-a efectuat vreo operatie de impartire a miliardelor, altfel 0)
	SubstractBigInt(=variabila care stocheaza numarul miliardelor=, =variabila care stocheaza restul cifrelor=, =suma de scazut=);		= scazi	 (returneaza 0 daca scaderea este < 0, altfel 1)
	GetBigInt(=variabila care stocheaza numarul miliardelor=, =variabila care stocheaza restul cifrelor=); 								= iei suma (neformatata, returneaza STRING)
	FormatBigInt(GetBigInt(...));							= iei suma   (formatata, returneaza STRING)

	CompareBigInt(var_store1, var_add1, var_store2, var_add2); 																			= compari 2 bigint-uri
	AddBigIntToBigInt(&var_store1, &var_add1, var_store2, var_add2); 																	= aduni 2 bigint-uri
	SubstractBigIntToBigInt(&var_store1, &var_add1, var_store2, var_add2);																= scazi 2 bigint-uri

	// avansat (necesita inline, modificate tabelele, eventual handle-ul SQL)
	AddSQLBigInt(sqlid, amount)																											= aduni un bigint direct in sql
	

	Sa zicem ca avem numarul: 3,123,456,789
	=variabila care stocheaza numarul miliardelor= - 3			(variabila trebuie sa fie INT)
	=variabila care stocheaza restul cifrelor= - 123,456,789	(variabila trebuie sa fie INT)

	Valoare maxima: 2,147,483,647,999,999,999.

*/

enum {
	COMPARE_RESULT_NULL,
	COMPARE_RESULT_FIRST,
	COMPARE_RESULT_SECOND,
	COMPARE_RESULT_EQUAL
};

stock CompareBigInt(var_store1, var_add1, var_store2, var_add2)
{
	if(var_store2 > var_store1 || (var_store1 == var_store2 && var_add2 > var_add1)) return COMPARE_RESULT_SECOND;
	else if(var_store1 > var_store2 || (var_store1 == var_store2 && var_add1 > var_add2)) return COMPARE_RESULT_FIRST;
	else return COMPARE_RESULT_EQUAL;
}

stock AddBigIntToBigInt(&var_store1, &var_add1, var_store2, var_add2)
{
	var_store1 += var_store2;
	var_add1 += var_add2;
	if(var_add1 > 1000000000)
	{
		var_store1 ++;
		var_add1 -= 1000000000;
		return 1;
	}
	return 0;
}

stock SubstractBigIntToBigInt(&var_store1, &var_add1, var_store2, var_add2)
{
	if(CompareBigInt(var_store1, var_add1, var_store2, var_add2) == COMPARE_RESULT_SECOND) return 0;
	var_store1 -= var_store2;
	var_add1 -= var_add2;
	if(var_add1 < 0 && var_store1 > 0)
	{
		new copy = var_add1 * -1;
		var_store1--;
		var_add1 = 1000000000 - copy;
	}
	return 1;
}
/*
stock AddSQLBigInt(sqlid, amount)
{
	new str[256];
	mysql_format(SQL, str, 256, "SELECT `MStore`,`Money` FROM `accounts` WHERE `ID`=%d LIMIT 1", sqlid);

	inline localfunction()
	{
		new var_store = cache_get_field_content_int(0, "MStore"), var_add = cache_get_field_content_int(0, "Money");
		AddBigInt(var_store, var_add, amount);
		mysql_format(SQL, str, 256, "UPDATE `accounts` SET `MStore`=%d, `Money`=%d WHERE `ID`=%d", var_store, var_add, sqlid);
		mysql_pquery(SQL, str);
		return 1;
	}
	mysql_tquery_inline(SQL, str, using inline localfunction, "");
	return 1;
}
*/
stock AddBigInt(&var_store, &var_add, amount)
{
	if(amount > 999999999) return 0;
	var_add += amount;
	if(var_add >= 1000000000)
	{
		var_store++;
		var_add -= 1000000000;
		return 1;
	}
	return 0;
}

stock SubstractBigInt(&var_store, &var_add, amount)
{
	if((amount > var_add && var_store == 0) || amount > 999999999) return 0;
	var_add -= amount;
	if(var_add < 0 && var_store > 0) {
		new copy = var_add * -1;
		var_store--;
		var_add = 1000000000 - copy;
	}
	return 1;
}

stock GetBigInt(&var_store, &var_add)
{
	new str[30], helper[20], helper2[20], copy = var_store, copy2 = var_add, cifre;
	while(copy2 != 0) {
		cifre++;
		copy2 /= 10;
	}
	if(copy >= 0) {
		for(new ii = 0; ii < 9; ii++)
		{
			if(9-ii == cifre)
			{
				format(helper2, 20, "%d", var_add);
				strcat(helper, helper2);
				ii += cifre;
			}
			if(ii < 9) strcat(helper, "0"); 
		}
	}
	if(copy > 0) format(str, 30, "%d%s", var_store, helper);
	else format(str, 30, "%d", var_add);
	return str;
}

stock FormatBigInt(get[])
{
	new str[40];
	format(str, 40, get);
	for(new ii = strlen(str)-3; ii >= 1; ii-=3) { strins(str, ",", ii); }
	return str;
}
