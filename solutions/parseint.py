str = "12345"
n = 0

for c in str:
	n *= 10
	x = ord(c) - ord('0') # ord() gets ascii value of the character
	n += x

print(n)
