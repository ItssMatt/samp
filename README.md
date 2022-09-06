# How the BigInt works?

We have 2 variables, prefix and suffix.
The prefix can be the maximum value of an integer (2,147,483,647) and the suffix can be maximum 999,999,999.
The prefix holds the number of billions, and the suffix holds the other digits.

# Example
We have the following BigInts: 
prefix = 3, suffix = 100. The result number: 3,000,000,100.                 
prefix = 10, suffix = 5,000,000. The result number: 10,005,000,000.
