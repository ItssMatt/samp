/*
	BigInt by Matt
	- Nu adaugati mai mult de 2,000,000,000 deodata.

	AddBigInt(=variabila care stocheaza numarul miliardelor=, =variabila care stocheaza restul cifrelor=, =suma de adaugat=);			= adaugi (returneaza 1 daca s-a efectuat vreo operatie de impartire a miliardelor, altfel 0)
	SubstractBigInt(=variabila care stocheaza numarul miliardelor=, =variabila care stocheaza restul cifrelor=, =suma de scazut=);		= scazi	 (returneaza 1 daca s-a efectuat vreo operatie de impartire a miliardelor, altfel 0)
	GetBigInt(=variabila care stocheaza numarul miliardelor=, =variabila care stocheaza restul cifrelor=); 								= iei suma (neformatata, returneaza STRING)
	FormatBigInt(=variabila care stocheaza numarul miliardelor=, =variabila care stocheaza restul cifrelor=);							= iei suma   (formatata, returneaza STRING)

	Sa zicem ca avem numarul: 3,123,456,789
	=variabila care stocheaza numarul miliardelor= - 3			(variabila trebuie sa fie INT)
	=variabila care stocheaza restul cifrelor= - 123,456,789	(variabila trebuie sa fie INT)

	Valoare maxima: 2,147,483,647,999,999,999.

*/






stock AddBigInt(&var_store, &var_add, amount)
{
	var_add += amount;
	if(var_add >= 1000000000)
	{
		while(var_add >= 1000000000)
		{
			var_store++;
			var_add -= 1000000000;
		}
		return 1;
	}
	return 0;
}

stock SubstractBigInt(&var_store, &var_add, amount)
{
	if(amount >= 1000000000 && var_store > 0)
	{
		var_store--;
		var_add += amount;
	}
	var_add -= amount;
	if(var_add < 0 && var_store > 0) {
		new copy = var_add * -1;
		var_store--;
		var_add = 1000000000 - copy;
		return 1;
	}
	return 0;
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